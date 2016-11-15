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
          
MitoMiner contains two different reference sets of mitochondrial genes that have been determined in different ways:<BR><BR>
<UL>
<LI>The Integrated Mitochondrial Protein Index (IMPI). This reference set of mitochondrial genes was was developed by using machine learning techniques to objectively appraise the mass-spectrometry and GFP tagging data in MitoMiner
combined with mitochondrial targeting sequence predictions and antibody localisation staining from the Human Protein Atlas. Support vector machine and random forest classification was used to objectively combine all of this evidence and select
those proteins that have similar properties/evidence to characterised mitochondrial proteins. This approach solves the problem of deciding an arbitrary threshold for what level of evidence can be considered "mitochondrial". The IMPI dataset is recalculated every 6-12 months
so to include the latest annotation and localisation data. More information can be found on the <a href="/${WEB_PROPERTIES['webapp.path']}/impi.do"> IMPI page</a>.
</LI><BR>   
<LI>The MitoCarta Inventory. This is a list of mouse and human mitochondrial proteins as defined by the MitoCarta Inventory of Mammalian Mitochondrial Genes (PubMed:18614015). This was generated from mass spectrometry performed
on fourteen tissues alongside GFP tagging and then integrating this with the results of six other large-scale mitochondrial datasets. More information can be found on the <a href="/${WEB_PROPERTIES['webapp.path']}/mitocarta.do"> MitoCarta page</a>. </LI><BR>
</UL>
<BR>
Many other genes will not be in these lists but may encode a protein that has some experimental evidence for mitochondrial localisation. These can be searched for on the 'Localisation Evidence' data category page.
These are not necessarily non-mitochodrial that have been identified due to contamination. If a protein is low abundance, tissue specific or expression specific this may result in it being missed by a majority of studies.
In addition many mitochondrial proteins are membrane bound and these are notoriously difficult to identify by mass spectrometry as most purification procedures are biased towards extracting soluble proteins. 
<BR><BR> 


<td valign="top">
      <div class="heading2">
        View Reference set genes in MitoMiner
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
     <ul>
          <li>
            Human IMPI genes:
            <span style="white-space:nowrap">
              <im:querylink text="[browse/download]" skipBuilder="true">

<query name="" model="genomic" view="Gene.primaryIdentifier Gene.name Gene.symbol Gene.description Gene.chr Gene.mitoEvidenceMitoCarta Gene.mitoEvidenceIMPI Gene.mitoEvidenceGO Gene.mitoEvidenceHumanProteinAtlas Gene.MTSipsort Gene.MTSmitofates Gene.MTSmitoprot Gene.MTStargetP" longDescription="" sortOrder="Gene.symbol asc" constraintLogic="B and A">
  <constraint path="Gene.organism.shortName" code="B" op="=" value="H. sapiens"/>
  <constraint path="Gene.mitoEvidenceIMPI" code="A" op="=" value="true"/>
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

<query name="" model="genomic" view="Gene.primaryIdentifier Gene.name Gene.symbol Gene.description Gene.chr Gene.mitoEvidenceMitoCarta Gene.mitoEvidenceIMPI Gene.mitoEvidenceGO Gene.mitoEvidenceHumanProteinAtlas Gene.MTSipsort Gene.MTSmitofates Gene.MTSmitoprot Gene.MTStargetP" longDescription="" sortOrder="Gene.symbol asc" constraintLogic="B and A">
  <constraint path="Gene.organism.shortName" code="B" op="=" value="M. musculus"/>
  <constraint path="Gene.mitoEvidenceIMPI" code="A" op="=" value="true"/>
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

<query name="" model="genomic" view="Gene.primaryIdentifier Gene.name Gene.symbol Gene.description Gene.chr Gene.mitoEvidenceMitoCarta Gene.mitoEvidenceIMPI Gene.mitoEvidenceGO Gene.mitoEvidenceHumanProteinAtlas Gene.MTSipsort Gene.MTSmitofates Gene.MTSmitoprot Gene.MTStargetP" longDescription="" sortOrder="Gene.symbol asc" constraintLogic="B and A">
  <constraint path="Gene.organism.shortName" code="B" op="=" value="R. norvegicus"/>
  <constraint path="Gene.mitoEvidenceIMPI" code="A" op="=" value="true"/>
</query>
              </im:querylink>
            </span>
          </li>
        </ul>
     
     
      </div>
    </td>

<BR><BR>


             
           </DL>
      </div>
    </td>
    <%--<td valign="top">
      <div class="heading2">
        Bulk download mitochondrial reference sets
      </div>
      <div class="body">
        <ul>
          <li>
            All genes in the IMPI Reference Set (Human, Mouse and Rat):
            <span style="white-space:nowrap">
              <im:querylink text="[browse/download]" skipBuilder="true">

<query name="" model="genomic" view="Protein.uniprotAccession Protein.uniprotName Protein.mitoEvidenceMitoMinerRefSet Protein.organism.name Protein.mitoEvidenceGFP Protein.mitoEvidenceMassSpec Protein.mitoEvidenceGO" longDescription="" sortOrder="Protein.uniprotAccession asc">
  <constraint path="Protein.mitoEvidenceMitoMinerRefSet" op="=" value="true"/>
</query>
              </im:querylink>
            </span>
          </li>
        </ul>
        <ul>
          <li>
            All proteins in the IMPI Reference Set:
            <span style="white-space:nowrap">
              <im:querylink text="[browse/download]" skipBuilder="true">

<query name="" model="genomic" view="Protein.uniprotAccession Protein.uniprotName Protein.mitoEvidenceMitoMinerRefSet Protein.organism.name Protein.mitoEvidenceGFP Protein.mitoEvidenceMassSpec Protein.mitoEvidenceGO" longDescription="" sortOrder="Protein.uniprotAccession asc">
  <constraint path="Protein.mitoEvidenceIMPI" op="=" value="true"/>
</query>
              </im:querylink>
            </span>
          </li>
        </ul>
      </div>
    </td>--%>
  </tr>
</table>
