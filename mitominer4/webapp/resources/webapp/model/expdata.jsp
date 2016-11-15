<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im" %>

<table width="100%">
  <tr>
    <td valign="top" rowspan="2">
      <div class="heading2">
        Current data
      </div>
      <div class="body">
        <DL>
           MitoMiner currently includes data from 
           
           <im:querylink text="52 large-scale proteomic datasets" skipBuilder="true">
           <query name="" model="genomic" view="Publication.firstAuthor Publication.pubMedId Publication.title Publication.journal Publication.volume Publication.issue Publication.pages Publication.year" longDescription="" sortOrder="Publication.firstAuthor asc" constraintLogic="A and B and C">
  <constraint path="Publication.evidenceType" code="A" op="IS NOT NULL"/>
  <constraint path="Publication.evidenceType" code="B" op="!=" value="GO"/>
  <constraint path="Publication.evidenceType" code="C" op="!=" value="UniProt Keyword"/>
</query>
           </im:querylink>
           
            of mitochondrial localisation from both mass spectrometry and green fluorescent protein (GFP) tagging studies.
            <BR><BR>
            Experimental data is available for the following species:
            <UL>    
              <LI><I>Homo sapiens</I></LI>
              <LI><I>Mus musculus</I></LI>
              <LI><I>Rattus norvegicus</I></LI>
              <LI><I>Saccharomyces cerevisiae</I></LI>
              <LI><I>Schizosaccharomyces pombe</I></LI>
            </UL>
            <BR>
            GFP tagging provides excellent evidence for mitochondrial localisation and is considered to be more reliable than mass spectrometry data. Due to experimental technical difficulties most of these studies are limited to yeast.
            <BR><BR>
            As mass spectrometry data can include false positives from the incomplete removal of non-mitochondrial proteins in the sample used, we have also recorded the various methods for the purification, separation and
            identification used in each study, to provide a full provenance for each entry. Proteins with minimal mass-spec evidence are not necessarily non-mitochodrial proteins that have been identified due to contamination.
            If a protein is low abundance, tissue specific or expression specific this may result in it being missed by a majority of studies. In addition many mitochondrial proteins are membrane bound and these are notoriously
            difficult to identify by mass spectrometry as most purification procedures are biased towards extracting soluble proteins.
            <BR><BR>
            For each mass spectometry protein record the following information is extracted and loaded into MitoMiner where available:
            <UL><LI>UniProt accession number</LI>
              <LI>UniProt name</LI>
              <LI>Original identifier used in the study</LI>
              <LI>Sequence of identified peptides</LI>
              <LI>Sequence coverage (%)</LI>
              <LI>pI</LI>
              <LI>Purification method used</LI>
              <LI>Separation method used</LI>
              <LI>Identification method used</LI>
              <LI>Subcelluar location</LI>
              <LI>Tissue/cell line from which the protein has been isolated</LI>
              <LI>Publication details of the originating paper</LI></UL>
            <BR>
            Several of these studies conducted multiple experiments on several tissues and MitoMiner records entries from the same study but performed on different tissues separately. The most comprehensive datasets currently included
            are for bakers yeast and mouse and these organisms are often the best place to start a search.             
            <BR><BR>
            MitoMiner includes homology information from EnsemblCompara to allow mitochondrial evidence to be shared between different species for the same homologous gene.
            <BR><BR>
            We also include immunofluorescent staining localisation data from the <A href="http://www.proteinatlas.org">Human Protein Atlas</A>. 
            <BR><BR> 
            We include the original gene identifier, main location, other location, expression type and reliability. 
            The 'other locations' were classed by the Human Protein Atlas as those with a markedly lower staining intensity than the main location, or those that were only observed in a subset of the cell lines.
             Data based on a single antibody is reported as expression type - staining. If the data is based on more than one antibody it is reported as expression type - APE. 
            Reliability is classed as whether the antibodies staining agrees if more than one is used and/or if the localisation agrees with UniProt. A reliability of strong, medium and supportive are considered to be good evidence for that localisation.
            <BR><BR>
            </UL>
             
           </DL>
      </div>
    </td>
    <%--<td valign="top">
      <div class="heading2">
        Bulk download protein data
      </div>
      <div class="body">
        <ul>
          <li>
            All proteins that have experimental evidence for mitochondrial localisation:
            <span style="white-space:nowrap">
              <im:querylink text="[browse/download]" skipBuilder="true">

<query name="" model="genomic" view="Protein.uniprotAccession Protein.uniprotName Protein.name Protein.organism.name Protein.mitoEvidenceGFP Protein.mitoEvidenceMassSpec" longDescription="" sortOrder="Protein.uniprotAccession asc" constraintLogic="A or B">
  <constraint path="Protein.mitoEvidenceGFP" code="A" op="&gt;" value="0"/>
  <constraint path="Protein.mitoEvidenceMassSpec" code="B" op="&gt;" value="0"/>
</query>
              </im:querylink>
            </span>
          </li>
          <li>
            Publication details of datasets integrated into MitoMiner:
            <span style="white-space:nowrap">
              <im:querylink text="[browse/download]" skipBuilder="true">
          <query name="" model="genomic" view="Publication.firstAuthor Publication.pubMedId Publication.title Publication.journal Publication.volume Publication.issue Publication.pages Publication.year" longDescription="" sortOrder="Publication.firstAuthor asc" constraintLogic="A and B and C">
  <constraint path="Publication.evidenceType" code="A" op="IS NOT NULL"/>
  <constraint path="Publication.evidenceType" code="B" op="!=" value="GO"/>
  <constraint path="Publication.evidenceType" code="C" op="!=" value="UniProt Keyword"/>
</query>
</im:querylink>
            </span>
          </li>
        </ul>
      </div>
    </td>--%>
  </tr>
</table>
