<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im" %>



<!-- impi.jsp -->

<html:xhtml/>



  <div class="body">
  <img src="model/images/refsetlogo.jpg" class="aspectPageIcon" align="left" style="PADDING-RIGHT: 10px"/>
  
<BR>
    <h1>Integrated Mitochondrial Protein Index (IMPI)</h1>
  </div>
  <BR><BR><BR>
  
<hr></hr>
<BR><BR>

<div class="body">
<DL>
<img src="model/images/impi.png" class="aspectPageIcon" align="left"/>
Finding the genes that encode the mitochondrial proteome is essential for studying mitochondrial function and disease. Clues of 
cellular localisation can be gathered from a range of sources such as the presence of a mitochondrial targeting sequence 
or the identification of the encoded protein by mass spectrometry in a mitochondrial proteomics study. However, no one data source will 
provide full coverage and many types of evidence will contain false positives. Therefore to find mitochondrial genes all this data 
must be integrated together and evaluated holistically. 
<BR><BR>
Using the data contained within MitoMiner <a href="http://www.mrc-mbu.cam.ac.uk/people/alan-robinson">we</a> developed the Integrated Mitochondrial Protein Index (IMPI), a collection of genes that encode proteins 
with strong evidence for cellular localisation within the mammalian mitochondrion. 
<BR><BR>
It was created using machine learning to evaluate multiple types of evidence, including antibody data
from the Human Protein Atlas, predictions from four mitochondrial targeting sequence programs, interactions with known mitochondria proteins, and extensive experimental data from <im:querylink text="52 large-scale GFP and mass spectrometry localisation studies." skipBuilder="true">
           <query name="" model="genomic" view="Publication.firstAuthor Publication.pubMedId Publication.title Publication.journal Publication.volume Publication.issue Publication.pages Publication.year" longDescription="" sortOrder="Publication.firstAuthor asc" constraintLogic="A and B and C">
  <constraint path="Publication.evidenceType" code="A" op="IS NOT NULL"/>
  <constraint path="Publication.evidenceType" code="B" op="!=" value="GO"/>
  <constraint path="Publication.evidenceType" code="C" op="!=" value="UniProt Keyword"/>
</query></im:querylink>
  Evidence was shared between the same gene in different organisms by using the homology mappings from <a href="http://www.ensembl.org/info/genome/compara/index.html">Ensembl Compara</a>.
 <BR><BR>
 To create IMPI we first manually assembled a list of 1130 genes that were known to encode mitochondrial proteins and a list of 1347 genes that were known not to encode mitochondrial proteins. 
 These lists were manually compiled and curated by consulting many different sources including disease databases and the literature.  
 We then trained an SVM algorithm (instead of a random forest machine learning classifier used in previous versions) to learn the best way to separate these two lists using all the different types of localisation data. 
 After training the SVM could be used to score all human genes depending on how similar their properties and evidence were to these already characterised mitochondrial genes.  
  Predictions with a score of 0.8 or greater indicated strong evidence of mitochondrial localisation and these were included in the final IMPI dataset. Finally the homology mappings were used to find the equivalent genes in mouse and rat.
  
<BR><BR>
  IMPI version Q3 2017 contains 1550 human genes that encode mitochondrially localised proteins - 1130 that are known to be mitochondrial and 420 that are predicted to be mitochondrial using the evidence in MitoMiner. 
  IMPI will be updated at regular intervals to take advantage of new evidence as it becomes available. 
     The complete IMPI dataset can be downloaded at the <a href="http://www.mrc-mbu.cam.ac.uk/impi">IMPI webpage</a>.  
<BR><BR>
<BR><BR>
<BR><BR>
<BR><BR>
<BR><BR>
</div>

<td valign="top">
      <div class="heading2">
        View IMPI genes in MitoMiner (Version Q3 2017)
      </div>
      <div class="body">
        <ul>
          <li>
            Human IMPI genes:
            <span style="white-space:nowrap">
              <im:querylink text="[browse/download]" skipBuilder="true">

<query name="" model="genomic" view="Gene.primaryIdentifier Gene.name Gene.symbol Gene.description Gene.chr Gene.mitoEvidenceMitoCarta Gene.mitoEvidenceIMPI Gene.mitoEvidenceIMPIscore Gene.mitoEvidenceGO Gene.mitoEvidenceHumanProteinAtlas Gene.MTSipsort Gene.MTSmitofates Gene.MTSmitoprot Gene.MTStargetP" longDescription="" sortOrder="Gene.symbol asc" constraintLogic="B and (A or C)">
  <constraint path="Gene.organism.shortName" code="B" op="=" value="H. sapiens"/>
  <constraint path="Gene.mitoEvidenceIMPI" code="A" op="=" value="Known mitochondrial"/>
  <constraint path="Gene.mitoEvidenceIMPI" code="C" op="=" value="Predicted mitochondrial"/>
</query>
              </im:querylink>
            </span>
          </li>
        </ul>
        <ul>
          <li>
            Mouse IMPI genes:
            <span style="white-space:nowrap">
              <im:querylink text="[browse/download]" skipBuilder="true">

<query name="" model="genomic" view="Gene.primaryIdentifier Gene.name Gene.symbol Gene.description Gene.chr Gene.mitoEvidenceMitoCarta Gene.mitoEvidenceIMPI Gene.mitoEvidenceGO Gene.mitoEvidenceHumanProteinAtlas Gene.MTSipsort Gene.MTSmitofates Gene.MTSmitoprot Gene.MTStargetP" longDescription="" sortOrder="Gene.symbol asc" constraintLogic="B and (A or C)">
  <constraint path="Gene.organism.shortName" code="B" op="=" value="M. musculus"/>
  <constraint path="Gene.mitoEvidenceIMPI" code="A" op="=" value="Known mitochondrial"/>
  <constraint path="Gene.mitoEvidenceIMPI" code="C" op="=" value="Predicted mitochondrial"/>
</query>
              </im:querylink>
            </span>
          </li>
        </ul>
        <ul>
          <li>
            Rat IMPI genes:
            <span style="white-space:nowrap">
              <im:querylink text="[browse/download]" skipBuilder="true">

<query name="" model="genomic" view="Gene.primaryIdentifier Gene.name Gene.symbol Gene.description Gene.chr Gene.mitoEvidenceMitoCarta Gene.mitoEvidenceIMPI Gene.mitoEvidenceGO Gene.mitoEvidenceHumanProteinAtlas Gene.MTSipsort Gene.MTSmitofates Gene.MTSmitoprot Gene.MTStargetP" longDescription="" sortOrder="Gene.symbol asc" constraintLogic="B and (A or C)">
  <constraint path="Gene.organism.shortName" code="B" op="=" value="R. norvegicus"/>
  <constraint path="Gene.mitoEvidenceIMPI" code="A" op="=" value="Known mitochondrial"/>
  <constraint path="Gene.mitoEvidenceIMPI" code="C" op="=" value="Predicted mitochondrial"/>
</query>
              </im:querylink>
            </span>
          </li>
        </ul>
      </div>
    </td>

<BR><BR>

<div class="heading">
    Use the queries below to explore the genes in the IMPI dataset:
  </div>
  <div class="body aspectTemplates">
    <tiles:insert name="templateList.tile">
      <tiles:put name="scope" value="global"/>
      <tiles:put name="placement" value="IMPI"/>
      <tiles:put name="noTemplatesMsgKey" value="templateList.noTemplates"/>
    </tiles:insert>
  </div>

</div>
<!-- /impi.jsp -->

