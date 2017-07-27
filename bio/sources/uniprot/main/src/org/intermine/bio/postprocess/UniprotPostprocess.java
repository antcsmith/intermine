package org.intermine.bio.postprocess;

/*
 * Copyright (C) 2002-2012 FlyMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.log4j.Logger;
import org.intermine.model.bio.CellularLocation;
import org.intermine.model.bio.OntologyTerm;
import org.intermine.model.bio.Protein;
import org.intermine.model.bio.Gene;
import org.intermine.model.bio.Organism;
import org.intermine.objectstore.ObjectStore;
import org.intermine.objectstore.ObjectStoreException;
import org.intermine.objectstore.ObjectStoreWriter;
import org.intermine.objectstore.query.BagConstraint;
import org.intermine.objectstore.query.Constraint;
import org.intermine.metadata.ConstraintOp;
import org.intermine.objectstore.query.ConstraintSet;
import org.intermine.objectstore.query.ContainsConstraint;
import org.intermine.objectstore.query.Query;
import org.intermine.objectstore.query.QueryClass;
import org.intermine.objectstore.query.QueryCollectionReference;
import org.intermine.objectstore.query.QueryReference;
import org.intermine.objectstore.query.QueryField;
import org.intermine.objectstore.query.QueryValue;
import org.intermine.objectstore.query.QueryObjectReference;
import org.intermine.objectstore.query.Results;
import org.intermine.objectstore.query.ResultsRow;
import org.intermine.objectstore.query.SimpleConstraint;
import org.intermine.postprocess.PostProcessor;
import org.intermine.util.DynamicUtil;


/**
 * Set mito flag in Protein to be TRUE if protein has a mito-related keyword.
 *
 * @author Julie Sullivan
 */
public class UniprotPostprocess extends PostProcessor
{
    private static final Logger LOG = Logger.getLogger(UniprotPostprocess.class);
    private ObjectStore os;
    // case sensitive
    //private static final String MITOCHONDRION = "Mitochondri%";
    //private static final Collection<String> COMPARTMENTS = new ArrayList<String>();
    //private static final Map<String, String> COMPARTMENTS = new HashMap<String, String>();
    //private static final String EVIDENCE_TYPE = "UniProt";
    
    /**
     * Create a new UpdateOrthologes object from an ObjectStoreWriter
     * @param osw writer on genomic ObjectStore
     */
    public UniprotPostprocess(ObjectStoreWriter osw) {
        super(osw);
        this.os = osw.getObjectStore();
    }

    /**
     * Set mito flag in Protein to be TRUE if protein has a mito-related keyword. 
     * @throws ObjectStoreException if anything goes wrong
     */
    @Override
    public void postProcess() throws ObjectStoreException {
        //set all values to FALSE
        Query q = getGenes();
        updateNullGenes(q, Boolean.FALSE);
        
        Query q2 = getHumanGenes();
        updateNullHumanGenes(q2, Boolean.FALSE);
        
                
        // set proteins with mito keywords to TRUE
    //    q = getMitoProteins();
    //    updateMitoProteins(q, Boolean.TRUE);
        
    //    addCellularLocation();
    }

// key = UniProt keyword, value = cellularLocation.location

    //static {
        //COMPARTMENTS.put("Cytoplasm", "cytoplasm");
        //COMPARTMENTS.put("Nucleus", "nucleus");
        //COMPARTMENTS.put("Endoplasmic reticulum", "endoplasmic reticulum");
        //COMPARTMENTS.put("Golgi apparatus", "golgi apparatus");
        //COMPARTMENTS.put("Peroxisome", "peroxisome");
        //COMPARTMENTS.put("Mitochondrion", "mitochondrion");
        //COMPARTMENTS.put("Cell membrane", "plasma membrane");
        //COMPARTMENTS.put("Vacuole", "vacuole");
        //COMPARTMENTS.put("Chloroplast", "chloroplast");
        //COMPARTMENTS.put("Mitosome", "mitosome");
    //}
    
    //private void addCellularLocation() throws ObjectStoreException {
    //    Map<String, CellularLocation> locations = new HashMap<String, CellularLocation>();
        
    //    Query q = getLocationQuery();
        
    //    osw.beginTransaction();
    //    int count = 0;
    //    Results res = os.execute(q);
    //    Iterator<?> resultsIterator = res.iterator();
    //    
    //    while (resultsIterator.hasNext()) {            
    //        ResultsRow<?> rr = (ResultsRow<?>) resultsIterator.next();
    //        Protein thisProtein = (Protein) rr.get(0);
    //        String keywordName = (String) rr.get(1);
    //        
    //        // get object from map
    //        CellularLocation cellularLocation = locations.get(keywordName);
    //        
    //        // if this is a new keyword, create object 
    //        if (cellularLocation == null) {
    //            cellularLocation = (CellularLocation) DynamicUtil.createObject(
    //                    Collections.singleton(CellularLocation.class));
    //            cellularLocation.setEvidenceType(EVIDENCE_TYPE);
    //            
    //            String location = COMPARTMENTS.get(keywordName);
    //            cellularLocation.setCellularLocation(location);
    //            
    //            // add to map so we know if we've seen this keyword before
    //            locations.put(keywordName, cellularLocation);
    //        }
    //        cellularLocation.addProtein(thisProtein);
    //        count++;
    //    }
    //    
    //    // done processing all locations, store to database
    //    for (CellularLocation cellularLocation : locations.values()) {
    //        osw.store(cellularLocation);
    //    }
    //    
    //    LOG.info("Added " + count + " cellular locations");
    //    osw.commitTransaction();
    //}
    
    /**
     * @return query to retrieve all proteins in the database that have a mito keyword
     */
    //private static Query getLocationQuery() {
    //    Query q = new Query();
    //    QueryClass qcProtein = new QueryClass(Protein.class);
    //    QueryClass qcKeyword = new QueryClass(OntologyTerm.class);
    //    
    //    // from clause
    //    q.addFrom(qcProtein);
    //    q.addFrom(qcKeyword);
    //    
    //    // SELECT clause
    //    q.addToSelect(qcProtein);
    //    QueryField qfKeyword = new QueryField(qcKeyword, "name");
    //    q.addToSelect(qfKeyword);
    //    
    //    // WHERE clause
    //    ConstraintSet cs = new ConstraintSet(ConstraintOp.AND);
    //    
    //    // Protein.keywords
    //    QueryCollectionReference qcr = new QueryCollectionReference(qcProtein, "keywords");
    //    cs.addConstraint(new ContainsConstraint(qcr, ConstraintOp.CONTAINS, qcKeyword));
    //    
    //    // Protein.keywords.name IN ("vacuole", "body" ...)
    //
    //    cs.addConstraint(new BagConstraint(qfKeyword, ConstraintOp.IN, COMPARTMENTS.keySet()));
    //    
    //    // add where clause to query
    //    q.setConstraint(cs);
    //    
    //    return q;
    //}
    
    
    /**
     * @param q query to run to retrieve proteins from database
     * @param isMito whether or not this protein is a mito protein
     * @throws ObjectStoreException if something goes horribly wrong
     */
    private void updateNullGenes(Query q, boolean isMito) throws ObjectStoreException {
        osw.beginTransaction();
        int count = 0;
        Results res = os.execute(q);
        Iterator<?> resultsIterator = res.iterator();
        
        while (resultsIterator.hasNext()) {            
            ResultsRow<?> rr = (ResultsRow<?>) resultsIterator.next();
            Gene thisGene = (Gene) rr.get(0);
            //thisProtein.setFieldValue("mitoEvidenceUniProtKeyword", isMito);
            
            if (thisGene.getMitoEvidenceMassSpecStudies() == null) {
                thisGene.setFieldValue("mitoEvidenceMassSpecStudies", 0);
            }
            
            if (thisGene.getMitoEvidenceMassSpecExperiments() == null) {
                thisGene.setFieldValue("mitoEvidenceMassSpecExperiments", 0);
            }
            
            // Mitoencoded
            if (thisGene.getMitoEncoded() == null) {
                thisGene.setFieldValue("mitoEncoded", false);
            }
            
            //if (thisGene.getMitoEvidenceIMPI() == null) {
            //    thisGene.setFieldValue("mitoEvidenceIMPI", false);
            //}
            
            if (thisGene.getPhenotype() == null) {
                thisGene.setFieldValue("phenotype", false);
            }
            
            //if (thisProtein.getMitoEvidenceMitoMinerRefSet() == null) {
            //    thisProtein.setFieldValue("mitoEvidenceMitoMinerRefSet", false);
            //}
            
            //if (thisGene.getMitoEvidenceHumanProteinAtlas() == null) {
            //    thisGene.setFieldValue("mitoEvidenceHumanProteinAtlas", false);
            //}
            
            //if (thisGene.getMitoEvidenceMitoCarta() == null) {
            //    thisGene.setFieldValue("mitoEvidenceMitoCarta", false);
            //}
            
            if (thisGene.getMitoEvidenceGFP() == null) {  
                thisGene.setFieldValue("mitoEvidenceGFP", 0);
            }

            
            osw.store(thisGene);
            count++;
        }
        
        LOG.info("Updated " + count + "genes");
        osw.commitTransaction();
    }

    /**
     * @return query to retrieve all genes in the database
     */
    private static Query getGenes() {
        Query q = new Query();
        QueryClass qcGenes = new QueryClass(Gene.class);
                
        // from clause
        q.addFrom(qcGenes);
        
        // SELECT clause
        q.addToSelect(qcGenes);
                
        return q;
    }


private void updateNullHumanGenes(Query q2, boolean isMito) throws ObjectStoreException {
        osw.beginTransaction();
        int count = 0;
        Results res = os.execute(q2);
        Iterator<?> resultsIterator = res.iterator();
        
        while (resultsIterator.hasNext()) {            
            ResultsRow<?> rr = (ResultsRow<?>) resultsIterator.next();
            Gene thisGene = (Gene) rr.get(0);

		if (thisGene.getMitoEvidenceHumanProteinAtlas() == null) {
                thisGene.setFieldValue("mitoEvidenceHumanProteinAtlas", false);
            }

	    if (thisGene.getMitoEvidenceIMPI() == null) {
                thisGene.setFieldValue("mitoEvidenceIMPI", false);
            }
	    
	    if (thisGene.getMitoEvidenceMitoCarta() == null) {
                thisGene.setFieldValue("mitoEvidenceMitoCarta", false);
            }
	    

osw.store(thisGene);
            count++;
        }
        
        LOG.info("Updated " + count + "genes");
        osw.commitTransaction();
    }

private void updateNullMouseGenes(Query q3, boolean isMito) throws ObjectStoreException {
        osw.beginTransaction();
        int count = 0;
        Results res = os.execute(q3);
        Iterator<?> resultsIterator = res.iterator();
        
        while (resultsIterator.hasNext()) {            
            ResultsRow<?> rr = (ResultsRow<?>) resultsIterator.next();
            Gene thisGene = (Gene) rr.get(0);

	    if (thisGene.getMitoEvidenceIMPI() == null) {
                thisGene.setFieldValue("mitoEvidenceIMPI", false);
            }
	    
	    if (thisGene.getMitoEvidenceMitoCarta() == null) {
                thisGene.setFieldValue("mitoEvidenceMitoCarta", false);
            }
	    

osw.store(thisGene);
            count++;
        }
        
        LOG.info("Updated " + count + "genes");
        osw.commitTransaction();
    }
    
private void updateNullRatGenes(Query q4, boolean isMito) throws ObjectStoreException {
        osw.beginTransaction();
        int count = 0;
        Results res = os.execute(q4);
        Iterator<?> resultsIterator = res.iterator();
        
        while (resultsIterator.hasNext()) {            
            ResultsRow<?> rr = (ResultsRow<?>) resultsIterator.next();
            Gene thisGene = (Gene) rr.get(0);

	    if (thisGene.getMitoEvidenceIMPI() == null) {
                thisGene.setFieldValue("mitoEvidenceIMPI", false);
            }
	    

osw.store(thisGene);
            count++;
        }
        
        LOG.info("Updated " + count + "genes");
        osw.commitTransaction();
    }
    
    
private static Query getHumanGenes() {
        Query q2 = new Query();
        QueryClass qcGene = new QueryClass(Gene.class);
        QueryClass qcOrganism = new QueryClass(Organism.class); 
                
        // from clause
        q2.addFrom(qcGene);
        q2.addFrom(qcOrganism);
        
        // SELECT clause
        q2.addToSelect(qcGene);
        QueryField qfOrganism = new QueryField(qcOrganism, "taxonId");
        q2.addToSelect(qfOrganism);     
             
        // WHERE clause
        ConstraintSet cs = new ConstraintSet(ConstraintOp.AND);     
        
        //Gene.organism
        QueryObjectReference qcr = new QueryObjectReference(qcGene, "organism");
        cs.addConstraint(new ContainsConstraint(qcr, ConstraintOp.CONTAINS, qcOrganism));
        
        // Gene.organism.taxonId = 9606
        //QueryField qfOrganism = new QueryField(qcOrganism, "taxonId");     
         cs.addConstraint(new SimpleConstraint(qfOrganism, ConstraintOp.EQUALS, 
                new QueryValue(9606)));
        
     
        
        
        q2.setConstraint(cs);
                
        return q2;
    }

private static Query getMouseGenes() {
        Query q3 = new Query();
        QueryClass qcGene = new QueryClass(Gene.class);
        QueryClass qcOrganism = new QueryClass(Organism.class); 
                
        // from clause
        q3.addFrom(qcGene);
        q3.addFrom(qcOrganism);
        
        // SELECT clause
        q3.addToSelect(qcGene);
        QueryField qfOrganism = new QueryField(qcOrganism, "taxonId");
        q3.addToSelect(qfOrganism);     
             
        // WHERE clause
        ConstraintSet cs = new ConstraintSet(ConstraintOp.AND);     
        
        //Gene.organism
        QueryObjectReference qcr = new QueryObjectReference(qcGene, "organism");
        cs.addConstraint(new ContainsConstraint(qcr, ConstraintOp.CONTAINS, qcOrganism));
        
        // Gene.organism.taxonId = 9606
        //QueryField qfOrganism = new QueryField(qcOrganism, "taxonId");     
         cs.addConstraint(new SimpleConstraint(qfOrganism, ConstraintOp.EQUALS, 
                new QueryValue(10090)));
        
        q3.setConstraint(cs);
                
        return q3;
    }

private static Query getRatGenes() {
        Query q4 = new Query();
        QueryClass qcGene = new QueryClass(Gene.class);
        QueryClass qcOrganism = new QueryClass(Organism.class); 
                
        // from clause
        q4.addFrom(qcGene);
        q4.addFrom(qcOrganism);
        
        // SELECT clause
        q4.addToSelect(qcGene);
        QueryField qfOrganism = new QueryField(qcOrganism, "taxonId");
        q4.addToSelect(qfOrganism);     
             
        // WHERE clause
        ConstraintSet cs = new ConstraintSet(ConstraintOp.AND);     
        
        //Gene.organism
        QueryObjectReference qcr = new QueryObjectReference(qcGene, "organism");
        cs.addConstraint(new ContainsConstraint(qcr, ConstraintOp.CONTAINS, qcOrganism));
        
        // Gene.organism.taxonId = 9606
        //QueryField qfOrganism = new QueryField(qcOrganism, "taxonId");     
         cs.addConstraint(new SimpleConstraint(qfOrganism, ConstraintOp.EQUALS, 
                new QueryValue(10116)));
        
        q4.setConstraint(cs);
                
        return q4;
    }
    
    
    /**
     * @return query to retrieve all proteins in the database that have a mito keyword
     */
    //private static Query getMitoProteins() {
    //    Query q = new Query();
    //    QueryClass qcProtein = new QueryClass(Protein.class);
    //    QueryClass qcKeyword = new QueryClass(OntologyTerm.class);
    //    
    //    // from clause
    //    q.addFrom(qcProtein);
    //    q.addFrom(qcKeyword);
    //    
    //    // SELECT clause
    //    q.addToSelect(qcProtein);
    //    
    //    // WHERE clause
    //    ConstraintSet cs = new ConstraintSet(ConstraintOp.AND);
    //    
    //    // Protein.keywords
    //    QueryCollectionReference qcr = new QueryCollectionReference(qcProtein, "keywords");
    //    cs.addConstraint(new ContainsConstraint(qcr, ConstraintOp.CONTAINS, qcKeyword));
    //    
    //    // Protein.keywords.name CONTAINS "mitochondri"
    //    QueryField qfKeyword = new QueryField(qcKeyword, "name");
    //    cs.addConstraint(new SimpleConstraint(qfKeyword, ConstraintOp.MATCHES, 
    //            new QueryValue(MITOCHONDRION)));
    //    
    //    // add where clause to query
    //    q.setConstraint(cs);
    //    
    //    return q;
    //}
    
}