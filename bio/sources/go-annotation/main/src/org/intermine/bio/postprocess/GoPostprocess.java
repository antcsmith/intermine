package org.intermine.bio.postprocess;

/*
 * Copyright (C) 2002-2015 FlyMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.Collections;

import org.apache.log4j.Logger;
import org.intermine.bio.util.Constants;
import org.intermine.model.bio.CellularLocation;    //
import org.intermine.model.bio.MitochondrialLocation;   //
import org.intermine.model.bio.GOAnnotation;
import org.intermine.model.bio.GOEvidence;
import org.intermine.model.bio.GOEvidenceCode;
import org.intermine.model.bio.Gene;
import org.intermine.model.bio.OntologyTerm;
import org.intermine.model.bio.Protein;
import org.intermine.model.bio.Publication;
import org.intermine.objectstore.ObjectStore;
import org.intermine.objectstore.ObjectStoreException;
import org.intermine.objectstore.ObjectStoreWriter;
import org.intermine.objectstore.intermine.ObjectStoreInterMineImpl;
import org.intermine.metadata.ConstraintOp;
import org.intermine.objectstore.query.ConstraintSet;
import org.intermine.objectstore.query.ContainsConstraint;
import org.intermine.objectstore.query.Query;
import org.intermine.objectstore.query.QueryField; //
import org.intermine.objectstore.query.QueryValue; //
import org.intermine.objectstore.query.SimpleConstraint; //
import org.intermine.objectstore.query.BagConstraint; //
import org.intermine.objectstore.query.QueryClass;
import org.intermine.objectstore.query.QueryCollectionReference;
import org.intermine.objectstore.query.QueryObjectReference;
import org.intermine.objectstore.query.Results;
import org.intermine.objectstore.query.ResultsRow;
import org.intermine.postprocess.PostProcessor;
import org.intermine.util.DynamicUtil;

/**
 * Take any GOAnnotation objects assigned to proteins and copy them to corresponding genes.
 * Also, update mito_evidence_GO boolean to TRUE if protein has mito GO term
 * @author Richard Smith & Julie Sullivan
 */
public class GoPostprocess extends PostProcessor
{
    private static final Logger LOG = Logger.getLogger(GoPostprocess.class);
    protected ObjectStore os;

    // case sensitive
    private static final String MITOCHONDRION = "mitochondrion";
    private static final Map<String, String> COMPARTMENTS = new HashMap<String, String>();
    private static final Map<String, String> LOCATION = new HashMap<String, String>();
    private static final String EVIDENCE_TYPE = "Gene Ontology";


    // key = UniProt keyword, value = cellularLocation.location
    static {
        COMPARTMENTS.put("cytosol", "cytosol");
        COMPARTMENTS.put("nucleus", "nucleus");
        COMPARTMENTS.put("endoplasmic reticulum", "endoplasmic reticulum");
        COMPARTMENTS.put("Golgi apparatus", "golgi apparatus");
        COMPARTMENTS.put("peroxisome", "peroxisome");
        COMPARTMENTS.put("mitochondrion", "mitochondrion");
        COMPARTMENTS.put("plasma membrane", "plasma membrane");
        COMPARTMENTS.put("vacuole", "vacuole");
        COMPARTMENTS.put("chloroplast", "chloroplast");
        COMPARTMENTS.put("mitosome", "mitosome");
    }
    
    // key = Go name, value = mitochondrialLocation.location
    static {
        LOCATION.put("mitochondrial matrix", "mitochondrial matrix");
        LOCATION.put("mitochondrial intermembrane space", "mitochondrial intermembrane space");
        LOCATION.put("mitochondrial nucleoid", "mitochondrial nucleoid");
        LOCATION.put("mitochondrial inner membrane", "mitochondrial inner membrane");
        LOCATION.put("mitochondrial outer membrane", "mitochondrial outer membrane");
    }


    /**
     * Create a new UpdateOrthologes object from an ObjectStoreWriter
     * @param osw writer on genomic ObjectStore
     */
    public GoPostprocess(ObjectStoreWriter osw) {
        super(osw);
        this.os = osw.getObjectStore();
    }


    /**
     * Copy all GO annotations from the Protein objects to the corresponding Gene(s)
     * @throws ObjectStoreException if anything goes wrong
     */
    @Override
    public void postProcess() throws ObjectStoreException {

        long startTime = System.currentTimeMillis();

        osw.beginTransaction();

        Iterator<?> resIter = findProteinProperties(false);

        int count = 0;
        Gene lastGene = null;
        Map<OntologyTerm, GOAnnotation> annotations = new HashMap<OntologyTerm, GOAnnotation>();

        while (resIter.hasNext()) {
            ResultsRow<?> rr = (ResultsRow<?>) resIter.next();
            Gene thisGene = (Gene) rr.get(0);
            GOAnnotation thisAnnotation = (GOAnnotation) rr.get(1);

            // process last set of annotations if this is a new gene
            if (lastGene != null && !(lastGene.equals(thisGene))) {
                for (GOAnnotation item : annotations.values()) {
                    osw.store(item);
                }
                lastGene.setGoAnnotation(new HashSet(annotations.values()));
                LOG.debug("store gene " + lastGene.getSecondaryIdentifier() + " with "
                        + lastGene.getGoAnnotation().size() + " GO.");
                osw.store(lastGene);

                lastGene = thisGene;
                annotations = new HashMap<OntologyTerm, GOAnnotation>();
            }

            OntologyTerm term = thisAnnotation.getOntologyTerm();
            Set<GOEvidence> evidence = thisAnnotation.getEvidence();

            GOAnnotation tempAnnotation;
            try {
                tempAnnotation = PostProcessUtil.copyInterMineObject(thisAnnotation);
            } catch (IllegalAccessException e) {
                throw new RuntimeException(e);
            }

            if (hasDupes(annotations, term, evidence, tempAnnotation)) {
                // if a dupe, merge with already created object instead of creating new
                continue;
            }
            tempAnnotation.setSubject(thisGene);

            lastGene = thisGene;
            count++;
        }

        if (lastGene != null) {
            for (GOAnnotation item : annotations.values()) {
                osw.store(item);
            }
            lastGene.setGoAnnotation(new HashSet(annotations.values()));
            LOG.debug("store gene " + lastGene.getSecondaryIdentifier() + " with "
                    + lastGene.getGoAnnotation().size() + " GO.");
            osw.store(lastGene);
        }

        LOG.info("Created " + count + " new GOAnnotation objects for Genes"
                + " - took " + (System.currentTimeMillis() - startTime) + " ms.");
        osw.commitTransaction();
    
    //
    // Once genes have been copied start doing MitoMiner stuff:
    //

    Query q = getGenes();
    updateGenes(q, Boolean.FALSE);
    
    q = getMitoGenes();
    updateGenes(q, Boolean.TRUE);
    
    addCellularLocation();
    
    addMitochondrialLocation();
    
    }

    private boolean hasDupes(Map<OntologyTerm, GOAnnotation> annotations, OntologyTerm term,
            Set<GOEvidence> evidence, GOAnnotation newAnnotation) {
        boolean isDupe = false;
        GOAnnotation alreadySeenAnnotation = annotations.get(term);
        if (alreadySeenAnnotation != null) {
            isDupe = true;
            mergeEvidence(evidence, alreadySeenAnnotation);
        } else {
            annotations.put(term, newAnnotation);
        }
        return isDupe;
    }

    // we've seen this term, merge instead of storing new object
    private void mergeEvidence(Set<GOEvidence> evidence, GOAnnotation alreadySeenAnnotation) {
        for (GOEvidence g : evidence) {
            GOEvidenceCode c = g.getCode();
            Set<Publication> pubs = g.getPublications();
            boolean foundMatch = false;
            for (GOEvidence alreadySeenEvidence : alreadySeenAnnotation.getEvidence()) {
                GOEvidenceCode alreadySeenCode = alreadySeenEvidence.getCode();
                Set<Publication> alreadySeenPubs = alreadySeenEvidence.getPublications();
                // we've already seen this evidence code, just merge pubs
                if (c.equals(alreadySeenCode)) {
                    foundMatch = true;
                    alreadySeenPubs = mergePubs(alreadySeenPubs, pubs);
                }
            }
            if (!foundMatch) {
                // we don't have this evidence code
                alreadySeenAnnotation.addEvidence(g);
            }
        }
    }

    private Set<Publication> mergePubs(Set<Publication> alreadySeenPubs, Set<Publication> pubs) {
        Set<Publication> newPubs = new HashSet<Publication>();
        if (alreadySeenPubs != null) {
            newPubs.addAll(alreadySeenPubs);
        }
        if (pubs != null) {
            newPubs.addAll(pubs);
        }
        return newPubs;
    }

    /**
     * Query Gene->Protein->Annotation->GOTerm and return an iterator over the Gene,
     *  Protein and GOTerm.
     *
     * @param restrictToPrimaryGoTermsOnly Only get primary Annotation items linking the gene
     *  and the go term.
     */
    private Iterator<?> findProteinProperties(boolean restrictToPrimaryGoTermsOnly)
        throws ObjectStoreException {
        Query q = new Query();

        q.setDistinct(false);

        QueryClass qcGene = new QueryClass(Gene.class);
        q.addFrom(qcGene);
        q.addToSelect(qcGene);
        q.addToOrderBy(qcGene);

        QueryClass qcProtein = new QueryClass(Protein.class);
        q.addFrom(qcProtein);

        QueryClass qcAnnotation = new QueryClass(GOAnnotation.class);
        q.addFrom(qcAnnotation);
        q.addToSelect(qcAnnotation);

        ConstraintSet cs = new ConstraintSet(ConstraintOp.AND);

        QueryCollectionReference geneProtRef = new QueryCollectionReference(qcProtein, "genes");
        cs.addConstraint(new ContainsConstraint(geneProtRef, ConstraintOp.CONTAINS, qcGene));

        QueryObjectReference annSubjectRef =
            new QueryObjectReference(qcAnnotation, "subject");
        cs.addConstraint(new ContainsConstraint(annSubjectRef, ConstraintOp.CONTAINS, qcProtein));

        q.setConstraint(cs);

        ((ObjectStoreInterMineImpl) os).precompute(q, Constants.PRECOMPUTE_CATEGORY);
        Results res = os.execute(q, 5000, true, true, true);
        return res.iterator();
    }

 

    
     /**
     *
     *Postprocessing required for MitoMiner4
     *
     */


    /**
     * @return query to retrieve all genes in the database
     */
    
 private static Query getGenes() {
        Query q = new Query();
        QueryClass qcGene = new QueryClass(Gene.class);
                
        // FROM clause
        q.addFrom(qcGene);
        
        // SELECT clause
        q.addToSelect(qcGene);
                
        return q;
    }

 /**
     * @param q query to run to retrieve genes from database
     * @param isMito whether or not this protein is a mito protein
     * @throws ObjectStoreException if something goes horribly wrong
     */
    private void updateGenes(Query q, boolean isMito) throws ObjectStoreException {
        osw.beginTransaction();
        int count = 0;
        Results res = os.execute(q);
        Iterator<?> resultsIterator = res.iterator();
        
        while (resultsIterator.hasNext()) {            
            ResultsRow<?> rr = (ResultsRow<?>) resultsIterator.next();
            Gene thisGene = (Gene) rr.get(0);
            thisGene.setFieldValue("mitoEvidenceGO", isMito);
            osw.store(thisGene);
            count++;
        }
        
        LOG.info("Updated " + count + " mito genes");
        osw.commitTransaction();
    }


/**
     * @return query to retrieve all proteins in the database that have a mito keyword
     */
    private static Query getMitoGenes() {
        Query q = new Query();
        QueryClass qcGene = new QueryClass(Gene.class);
        QueryClass qcGO = new QueryClass(OntologyTerm.class);
        QueryClass qcGOParent = new QueryClass(OntologyTerm.class);
        QueryClass qcGOAnnotation = new QueryClass(GOAnnotation.class);
        
        // FROM clause
        q.addFrom(qcGene);
        q.addFrom(qcGO);
        q.addFrom(qcGOParent);
        q.addFrom(qcGOAnnotation);
        
        // SELECT clause
        q.addToSelect(qcGene);
        
        // WHERE clause
        ConstraintSet cs = new ConstraintSet(ConstraintOp.AND);
        
        // Protein.goAnnotation
        QueryCollectionReference qcr1 = new QueryCollectionReference(qcGene, "ontologyAnnotations");
        cs.addConstraint(new ContainsConstraint(qcr1, ConstraintOp.CONTAINS, qcGOAnnotation));
        
        // Protein.goAnnotation.ontologyTerm
        QueryObjectReference qor = new QueryObjectReference(qcGOAnnotation, "ontologyTerm");
        cs.addConstraint(new ContainsConstraint(qor, ConstraintOp.CONTAINS, qcGO));
        
        // Protein.goAnnotation.ontologyTerm.parents
        QueryCollectionReference qcr2 = new QueryCollectionReference(qcGO, "parents");
        cs.addConstraint(new ContainsConstraint(qcr2, ConstraintOp.CONTAINS, qcGOParent));
        
        // Protein.ontologyAnnotations.ontologyTerm.parents.name CONTAINS "mitochondri"
        QueryField qfGOParent = new QueryField(qcGOParent, "name");
        cs.addConstraint(new SimpleConstraint(qfGOParent, ConstraintOp.MATCHES, 
                new QueryValue(MITOCHONDRION)));
        
        // add WHERE clause to query
        q.setConstraint(cs);
        
        return q;
    }

    private void addCellularLocation() throws ObjectStoreException {
        Map<String, CellularLocation> locations = new HashMap<String, CellularLocation>();
        
        Query q = getLocationQuery();
        
        osw.beginTransaction();
        int count = 0;
        Results res = os.execute(q);
        Iterator<?> resultsIterator = res.iterator();
        
        while (resultsIterator.hasNext()) {            
            ResultsRow<?> rr = (ResultsRow<?>) resultsIterator.next();
            Gene thisGene = (Gene) rr.get(0);
            String goTermName = (String) rr.get(1);
            
            // get object from map
            CellularLocation cellularLocation = locations.get(goTermName);
            
            // if this is a new keyword, create object 
            if (cellularLocation == null) {
                cellularLocation = (CellularLocation) DynamicUtil.createObject(
                        Collections.singleton(CellularLocation.class));
                
                //cellularLocation = (CellularLocation) DynamicUtil.createObject(CellularLocation.class);
                
                cellularLocation.setEvidenceType(EVIDENCE_TYPE);
                String location = COMPARTMENTS.get(goTermName);
                cellularLocation.setCellularLocation(location);
                
                // add to map so we know if we've seen this keyword before
                locations.put(goTermName, cellularLocation);
            }
            cellularLocation.addGenes(thisGene);
            count++;
        }
        
        // done processing all locations, store to database
        for (CellularLocation cellularLocation : locations.values()) {
            osw.store(cellularLocation);
        }
        
        LOG.info("Added " + count + " cellular locations");
        osw.commitTransaction();
    }
    
    
    /**
     * @return query to retrieve all proteins in the database that have a mito keyword
     */
    private static Query getLocationQuery() {
        Query q = new Query();
        QueryClass qcGene = new QueryClass(Gene.class);
        QueryClass qcGO = new QueryClass(OntologyTerm.class);
        QueryClass qcGOParent = new QueryClass(OntologyTerm.class);
        QueryClass qcGOAnnotation = new QueryClass(GOAnnotation.class);
        
        // FROM clause
        q.addFrom(qcGene);
        q.addFrom(qcGO);
        q.addFrom(qcGOParent);
        q.addFrom(qcGOAnnotation);
        
        // SELECT clause
        q.addToSelect(qcGene);
        QueryField qfGOParent = new QueryField(qcGOParent, "name");
        q.addToSelect(qfGOParent);
        
        // WHERE clause
        ConstraintSet cs = new ConstraintSet(ConstraintOp.AND);
        
        // Protein.goAnnotation
        QueryCollectionReference qcr1 = new QueryCollectionReference(qcGene, "ontologyAnnotations");
        cs.addConstraint(new ContainsConstraint(qcr1, ConstraintOp.CONTAINS, qcGOAnnotation));
        
        // Protein.goAnnotation.ontologyTerm
        QueryObjectReference qor = new QueryObjectReference(qcGOAnnotation, "ontologyTerm");
        cs.addConstraint(new ContainsConstraint(qor, ConstraintOp.CONTAINS, qcGO));
        
        // Protein.goAnnotation.ontologyTerm.parents
        QueryCollectionReference qcr2 = new QueryCollectionReference(qcGO, "parents");
        cs.addConstraint(new ContainsConstraint(qcr2, ConstraintOp.CONTAINS, qcGOParent));
        
        // Protein.ontologyAnnotations.ontologyTerm.parents.name IN ("vacuole", "body" ...)
        cs.addConstraint(new BagConstraint(qfGOParent, ConstraintOp.IN, COMPARTMENTS.keySet()));
        
        // add WHERE clause to query
        q.setConstraint(cs);
        
        return q;
    }

    /**
     * @Add mitochondrial locations to MitochondrialLocations table
     */
    
    private void addMitochondrialLocation() throws ObjectStoreException {
        Map<String, MitochondrialLocation> locations = new HashMap<String, MitochondrialLocation>();
       
        Query q = getMitochondrialLocationQuery();
        
        osw.beginTransaction();
        int count = 0;
        Results res = os.execute(q);
        Iterator<?> resultsIterator = res.iterator();
        
        while (resultsIterator.hasNext()) {            
            ResultsRow<?> rr = (ResultsRow<?>) resultsIterator.next();
            Gene thisGene = (Gene) rr.get(0);
            String goTermName = (String) rr.get(1);
            
            // get object from map
            MitochondrialLocation mitochondrialLocation = locations.get(goTermName);
            
            // if this is a new keyword, create object 
            if (mitochondrialLocation == null) {
                //mitochondrialLocation = (MitochondrialLocation) DynamicUtil.createObject(
                //        MitochondrialLocation.class);
                
                mitochondrialLocation = (MitochondrialLocation) DynamicUtil.createObject(
                        Collections.singleton(MitochondrialLocation.class));
                
                mitochondrialLocation.setEvidenceType(EVIDENCE_TYPE);
                
                String location = LOCATION.get(goTermName);
                mitochondrialLocation.setMitochondrialLocation(location);
                
                // add to map so we know if we've seen this keyword before
                locations.put(goTermName, mitochondrialLocation);
            }
            mitochondrialLocation.addGenes(thisGene);
            count++;
        }
        
        // done processing all locations, store to database
        for (MitochondrialLocation mitochondrialLocation : locations.values()) {
            osw.store(mitochondrialLocation);
        }
        
        LOG.info("Added " + count + " mitochondrial locations");
        osw.commitTransaction();
    }
    
    /**
     * @return query to retrieve all proteins in the database that have a mito locations
     */
    private static Query getMitochondrialLocationQuery() {
        Query q = new Query();
        QueryClass qcGene = new QueryClass(Gene.class);
        QueryClass qcGO = new QueryClass(OntologyTerm.class);
        QueryClass qcGOParent = new QueryClass(OntologyTerm.class);
        QueryClass qcGOAnnotation = new QueryClass(GOAnnotation.class);
        
        // FROM clause
        q.addFrom(qcGene);
        q.addFrom(qcGO);
        q.addFrom(qcGOParent);
        q.addFrom(qcGOAnnotation);
        
        // SELECT clause
        q.addToSelect(qcGene);
        QueryField qfGOParent = new QueryField(qcGOParent, "name");
        q.addToSelect(qfGOParent);
        
        // WHERE clause
        ConstraintSet cs = new ConstraintSet(ConstraintOp.AND);
        
        // Protein.goAnnotation
        QueryCollectionReference qcr1 = new QueryCollectionReference(qcGene, "ontologyAnnotations");
        cs.addConstraint(new ContainsConstraint(qcr1, ConstraintOp.CONTAINS, qcGOAnnotation));
        
        // Protein.goAnnotation.ontologyTerm
        QueryObjectReference qor = new QueryObjectReference(qcGOAnnotation, "ontologyTerm");
        cs.addConstraint(new ContainsConstraint(qor, ConstraintOp.CONTAINS, qcGO));
        
        // Protein.goAnnotation.ontologyTerm.parents
        QueryCollectionReference qcr2 = new QueryCollectionReference(qcGO, "parents");
        cs.addConstraint(new ContainsConstraint(qcr2, ConstraintOp.CONTAINS, qcGOParent));
        
        // Protein.ontologyAnnotations.ontologyTerm.parents.name IN ("mitochondrial matrix", "mitochondrial intermembrane space" ...)
        cs.addConstraint(new BagConstraint(qfGOParent, ConstraintOp.IN, LOCATION.keySet()));
        
        // add WHERE clause to query
        q.setConstraint(cs);
        
        return q;
    }
    
}
