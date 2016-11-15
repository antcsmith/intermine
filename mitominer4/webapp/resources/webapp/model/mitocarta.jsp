<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im" %>

<html:xhtml/>

  <div class="body aspectIntro">
  <img src="model/images/refsetlogo.jpg" class="aspectPageIcon" align="left" style="PADDING-RIGHT: 10px"/>
  
<BR>
    <h1>MitoCarta: An Inventory of Mammalian Mitochondrial Genes</h1>
  </div>
  <BR><BR><BR>
  
<hr></hr>
<BR><BR>

<div class="body">
<DL>
MitoMiner integrates data from the MitoCarta 2.0 inventory of genes that encode mitochondrial proteins. This is a popular reference list
produced by <a href="http://mootha.med.harvard.edu/index.html">Vamsi Mootha's group at the Broad Institute</a>, first published in 2008 and then 
updated in 2016. It was generated from mass spectrometry of isolated mitochondrial fractions from 14 tissues alongside GFP tagging and then 
integrated with the results of six other large-scale mitochondrial datasets. 
<BR><BR>

More information on MitoCarta can be found in the following publications:
<BR><BR>
<strong>Calvo SE, Clauser KR, Mootha VK.</strong>
<BR>
<strong>MitoCarta2.0: an updated inventory of mammalian mitochondrial proteins (2016).</strong>
<BR>
Nucleic Acids Research Jan 4;44(D1):D1251-7 <a href="http://www.ncbi.nlm.nih.gov/pubmed/26450961">[Pubmed:26450961] </a>
<BR><BR>
<strong>Pagliarini DJ, Calvo SE, Chang B, Sheth SA, Vafai SB, Ong SE, Walford GA, Sugiana C, Boneh A, Chen WK, 
Hill DE, Vidal M, Evans JG, Thorburn DR, Carr SA, Mootha VK.</strong>
<BR>
<strong>A mitochondrial protein compendium elucidates complex I disease biology. (2008)</strong>
<BR>
Cell Jul 11;134(1):112-23 <a href="http://www.ncbi.nlm.nih.gov/pubmed/18614105">[Pubmed: 18614015] </a>
<BR><BR>
The original data files can be found at the <a href="http://www.broadinstitute.org/scientific-community/science/programs/metabolic-disease-program/publications/mitocarta/mitocarta-in-0">MitoCarta website.</a>
<BR><BR>
</div>

<td valign="top">
      <div class="heading2">
        View MitoCarta 2.0 genes in MitoMiner
      </div>
      <div class="body">
        <ul>
          <li>
            Human MitoCarta 2.0 genes:
            <span style="white-space:nowrap">
              <im:querylink text="[browse/download]" skipBuilder="true">

<query name="" model="genomic" view="Gene.primaryIdentifier Gene.name Gene.symbol Gene.description Gene.chr Gene.mitoEvidenceMitoCarta Gene.mitoEvidenceIMPI Gene.mitoEvidenceGO Gene.mitoEvidenceHumanProteinAtlas Gene.MTSipsort Gene.MTSmitofates Gene.MTSmitoprot Gene.MTStargetP" longDescription="" sortOrder="Gene.symbol asc" constraintLogic="A and B">
  <constraint path="Gene.mitoEvidenceMitoCarta" code="A" op="=" value="true"/>
  <constraint path="Gene.organism.shortName" code="B" op="=" value="H. sapiens"/>
</query>
              </im:querylink>
            </span>
          </li>
        </ul>
        <ul>
          <li>
            Mouse MitoCarta 2.0 genes:
            <span style="white-space:nowrap">
              <im:querylink text="[browse/download]" skipBuilder="true">

<query name="" model="genomic" view="Gene.primaryIdentifier Gene.name Gene.symbol Gene.description Gene.chr Gene.mitoEvidenceMitoCarta Gene.mitoEvidenceIMPI Gene.mitoEvidenceGO Gene.mitoEvidenceHumanProteinAtlas Gene.MTSipsort Gene.MTSmitofates Gene.MTSmitoprot Gene.MTStargetP" longDescription="" sortOrder="Gene.symbol asc" constraintLogic="A and B">
  <constraint path="Gene.mitoEvidenceMitoCarta" code="A" op="=" value="true"/>
  <constraint path="Gene.organism.shortName" code="B" op="=" value="M. musculus"/>
</query>
              </im:querylink>
            </span>
          </li>
        </ul>
      </div>
    </td>

<BR><BR>

<div class="heading">
    Use the queries below to explore the genes in the MitoCarta dataset:
  </div>
  <div class="body aspectTemplates">
    <tiles:insert name="templateList.tile">
      <tiles:put name="scope" value="global"/>
      <tiles:put name="placement" value="MitoCarta"/>
      <tiles:put name="noTemplatesMsgKey" value="templateList.noTemplates"/>
    </tiles:insert>
  </div>
