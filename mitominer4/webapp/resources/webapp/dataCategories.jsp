<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im" %>

<div class="body">
  <div id="leftCol">
    <div id="pageDesc" class="pageDesc">
      <p><fmt:message key="dataCategories.intro"/></p>
    </div>

    <im:boxarea title="Actions" stylename="plainbox" >
         <html:link action="/templates">
           <fmt:message key="dataCategories.viewTemplates"/>
           <img border="0" class="arrow" src="images/right-arrow.gif" alt="Go"/>
         </html:link>
    </im:boxarea>
  </div>
</div>

<div id="rightCol">
  <im:boxarea titleKey="dataCategories.title" stylename="gradientbox">
    <c:choose>
      <c:when test="${!empty ASPECTS}">
        <tiles:insert name="aspects.tile"/>
      </c:when>
      <c:otherwise>
        <c:forEach items="${CATEGORIES}" var="category">
          <c:if test="${!empty CATEGORY_CLASSES[category]}">
            <div class="heading">
              <c:out value="${category}"/>
            </div>

            <div class="body">
              <c:set var="classes" value="${CATEGORY_CLASSES[category]}"/>
              <c:forEach items="${classes}" var="classname" varStatus="status">
                <a href="<html:rewrite page="/queryClassSelect.do"/>?action=<fmt:message key="button.selectClass"/>&amp;className=${classname}" title="<c:out value="${classDescriptions[classname]}"/>">${classname}</a><c:if test="${!status.last}">,</c:if>
              </c:forEach>

              <c:if test="${!empty CATEGORY_TEMPLATES[category]}">
                <br/>
                <span class="smallnote"><fmt:message key="begin.or"/> <html:link action="/templates" paramId="category" paramName="category"><fmt:message key="begin.related.templates"/></html:link></span>
              </c:if>
            </div>
            <im:vspacer height="5"/>
          </c:if>
        </c:forEach>
      </c:otherwise>
    </c:choose>
  </im:boxarea>
</div>


<div class="body">
<im:boxarea title="Data" stylename="plainbox"><p><fmt:message key="dataCategories.table"/></p></im:boxarea>


<table cellpadding="0" cellspacing="0" border="0" class="dbsources">
  <tr>
    <th>Data Category</th>
    <th>Organism</th>
    <th>Data</th>
    <th>Source</th>
    <th>PubMed</th>
  </tr>
  
  <tr><td rowspan="2" class="leftcol">
        <h2><p>Genes & Proteins</p></h2></td>
    <td>
       <p><i>H. sapiens</i></p>
       <p><i>M. musculus</i></p>
       <p><i>R. norvegicus</i></p>
       <p><i>D. rerio</i></p>
       <p><i>S. cerevisiae</i></p>
       <p><i>S. pombe</i></p>
    </td>
    <td> Gene identifiers, descriptions, information and annotation</td>
    <td> <a href="http://www.ensembl.org" target="_new" class="extlink">Ensembl</a> - Version 89 <BR>
    <a href="http://www.geneontology.org/" target="_new" class="extlink">Gene Ontology</a> - Version 2017-05-31</td>
    <td> Kersey <i>et al.</i> - <a href="http://www.ncbi.nlm.nih.gov/pubmed/26578574" target="_new" class="extlink">PubMed: 26578574</a> <BR>
    Gene Ontology Consortium - <a href="http://www.ncbi.nlm.nih.gov/pubmed/10802651" target="_new" class="extlink">PubMed: 10802651</a></td>
  </tr>

  <tr>
    <td>
       <p><i>H. sapiens</i></p>
       <p><i>M. musculus</i></p>
       <p><i>R. norvegicus</i></p>
       <p><i>D. rerio</i></p>
       <p><i>S. cerevisiae</i></p>
       <p><i>S. pombe</i></p>
    </td>
    <td>Protein annotation and gene mappings</td>
    <td> <a href="http://www.uniprot.org" target="_new" class="extlink">UniProt</a> - Release 2017_05<BR>
         <a href="http://www.ebi.ac.uk/interpro/" target="_new" class="extlink">InterPro</a> - v63.0
    </td>
    <td> UniProt Consortium - <a href="http://www.ncbi.nlm.nih.gov/pubmed/17142230" target="_new" class="extlink">PubMed: 17142230</a><BR>
    Mitchell <i>et al.</i> - <a href="http://www.ncbi.nlm.nih.gov/pubmed/25428371" target="_new" class="extlink">PubMed: 25428371</a>
    </td>
    
    
  </tr>

<tr><td rowspan="1" class="leftcol">
        <h2><p>Homology</p></h2></td>
    
    <td>
       <p><i>H. sapiens</i></p>
       <p><i>M. musculus</i></p>
       <p><i>R. norvegicus</i></p>
       <p><i>D. rerio</i></p>
       <p><i>S. cerevisiae</i></p>
       <p><i>S. pombe</i></p>
    </td>
    <td>Orthologues and paralogue relationships between these 6 organisms</td>
    <td><a href=http://www.ensembl.org/info/docs/api/compara/index.html target="_new" class="extlink">Ensembl Compara</a> - Version 89</td>
    <td>Vilella <i>et al</i> - <a href="http://www.ncbi.nlm.nih.gov/pubmed/19029536 " target="_new" class="extlink">PubMed: 19029536</a></td>
    
  </tr>

<tr><td rowspan="4" class="leftcol">
        <h2><p>Localisation evidence</p></h2></td>
    
    <td>
       <p><i>H. sapiens</i></p>
       <p><i>M. musculus</i></p>
       <p><i>R. norvegicus</i></p>
       <p><i>S. cerevisiae</i></p>
    </td>
    <td>Large scale mass-spectometry studies of purified mitochondrial fractions (currently 48 studies)</td>
    <td>Literature</td>
    <td><im:querylink text="Various" skipBuilder="true">
        <query name="" model="genomic" view="Gene.massSpec.publications.pubMedId Gene.massSpec.publications.title Gene.massSpec.publications.firstAuthor Gene.massSpec.publications.correspondingAuthor Gene.massSpec.publications.journal Gene.massSpec.publications.year"
        longDescription="" sortOrder="Gene.massSpec.publications.year desc">
        </query>
        </im:querylink>
    </td>
    </tr>
    <tr>
    <td>
       <p><i>H. sapiens</i></p>
       <p><i>M. musculus</i></p>
       <p><i>S. cerevisiae</i></p>
       <p><i>S. pombe</i></p>
    </td>
    <td>Large scale GFP tagging studies of mitochondrial proteins (currently 10 studies)</td>
    <td>Literature</td>
    <td><im:querylink text="Various" skipBuilder="true">
                <query name="" model="genomic" view="Gene.gfp.publications.pubMedId Gene.gfp.publications.title Gene.gfp.publications.firstAuthor Gene.gfp.publications.correspondingAuthor Gene.gfp.publications.journal Gene.gfp.publications.year"
                longDescription="" sortOrder="Gene.gfp.publications.year desc">
                </query>
                </im:querylink>
    </td>
    </tr>
    <tr>
    <td>
       <p><i>H. sapiens</i></p>
    </td>
     <td>Immunofluorescent cell staining results</td>
    <td> <a href="http://www.proteinatlas.org" target="_new" class="extlink">Human Protein Atlas</a> - Version 16.1</td>
    <td> Uhlen <i>et al.</i> - <a href="http://www.ncbi.nlm.nih.gov/pubmed/21139605" target="_new" class="extlink">PubMed: 21139605</a></td>
    </td>
  </tr>
    <tr>
    <td>
       <p><i>H. sapiens</i></p>
       <p><i>M. musculus</i></p>
       <p><i>R. norvegicus</i></p>
       <p><i>D. rerio</i></p>
       <p><i>S. cerevisiae</i></p>
       <p><i>S. pombe</i></p>
    </td>
    <td>Predictions of mitochondrial targeting sequences</td>
    <td><a href="http://ipsort.hgc.jp" target="_new" class="extlink">iPSORT</a>  <BR>
        <a href="https://ihg.gsf.de/ihg/mitoprot.html" target="_new" class="extlink">MitoProt</a>  <BR>
        <a href="http://www.cbs.dtu.dk/services/TargetP/" target="_new" class="extlink">TargetP</a>  <BR>
        <a href="http://mitf.cbrc.jp/MitoFates/cgi-bin/top.cgi" target="_new" class="extlink">MitoFates</a> 
    </td>
    <td>Bannai <i>et al.</i> - <a href="http://www.ncbi.nlm.nih.gov/pubmed/11847077" target="_new" class="extlink">PubMed: 11847077</a> <BR>
    Claros <i>et al.</i> - <a href="http://www.ncbi.nlm.nih.gov/pubmed/8944766" target="_new" class="extlink">PubMed: 8944766</a> <BR>
    Emanuelsson <i>et al.</i> - <a href="http://www.ncbi.nlm.nih.gov/pubmed/10891285" target="_new" class="extlink">PubMed: 10891285</a> <BR>
    Fukasawa <i>et al.</i> - <a href="http://www.ncbi.nlm.nih.gov/pubmed/25670805" target="_new" class="extlink">PubMed: 25670805</a> <BR>
    </td>
</tr>

<tr>
    <td rowspan="2"  class="leftcol"><p><h2>Mitochondrial reference gene lists</h2></p></td>
    <td>
        <p><i>H. sapiens</i></p>
        <p><i>M. musculus</i></p>
        <p><i>R. norvegicus</i></p>
    </td>
    <td>Integrated Mitochondrial Protein Index (IMPI) </td>
    <td> <a href="/${WEB_PROPERTIES['webapp.path']}/impi.do" target="_new" class="extlink">IMPI</a> - Version Q3 2017 </td>
    <td> Manuscript in preparation </td>
  </tr>
  <tr>
  <td>
        <p><i>H. sapiens</i></p>
        <p><i>M. musculus</i></p>
        
    </td>
    <td>MitoCarta inventory of mammalian mitochondrial proteins</td>
    <td> <a href="http://www.broadinstitute.org/scientific-community/science/programs/metabolic-disease-program/publications/mitocarta/mitocarta-in-0" target="_new" class="extlink">MitoCarta</a> - Version 2 </td>
    <td> Calvo <i>et al.</i> - <a href="http://www.ncbi.nlm.nih.gov/pubmed/26450961" target="_new" class="extlink">PubMed:26450961</a></td>
  </tr>
  

  <tr>
    <td rowspan="3" class="leftcol"><p> <h2>Phenotypes</h2></p></td>
    <td> <p><i>M. musculus</i></p> </td>
    <td> Mammalian phenotypes of spontaneous, induced and engineered mutations</td>
    <td> <a href="http://www.informatics.jax.org/phenotypes.shtml" target="_new" class="extlink">MGI</a> - 30th June 2017</td>
    <td> Blake <i>et al.</i> - <a href="http://www.ncbi.nlm.nih.gov/pubmed/24285300" target="_new" class="extlink">PubMed: 24285300</a></td>
    
  </tr>
  
   <tr>
    <td> <p><i>D. rerio</i></p> </td>
    <td> Zebrafish knockdown and mutant information</td>
    <td> <a href="http://zfin.org" target="_new" class="extlink"> ZFIN </a> - 28th June 2017</td>
    <td> Bradford <i>et al.</i> - <a href="http://www.ncbi.nlm.nih.gov/pubmed/21036866" target="_new" class="extlink">PubMed: 21036866</a></td>
    
  </tr>
  
  <tr>
    <td><p><i>S. cerevisiae</i></p></td>
    <td> Yeast mutant information</td>
    <td> <a href="http://www.yeastgenome.org" target="_new" class="extlink"> SGD </a> - 28th June 2017</td>
    <td> Engel <i>et al.</i> - <a href="http://www.ncbi.nlm.nih.gov/pubmed/19906697" target="_new" class="extlink">PubMed: 19906697</a></td>
    
  </tr>
  
  <tr>
    <td rowspan="1" class="leftcol"><p><h2>Diseases</h2></p></td>
    <td> <p><i>H. sapiens</i></p> </td>
    <td> Human disease information</td>
    <td> <a href="http://omim.org" target="_new" class="extlink">OMIM</a> - Last updated 28th June 2017 <BR>
    <a href="http://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-62/" target="_new" class="extlink">ArrayExpress Atlas</a> - June 2011
    </td>
    <td> Amberger <i>et al.</i>  - <a href="http://www.ncbi.nlm.nih.gov/pubmed/18842627" target="_new" class="extlink">PubMed: 18842627</a>
         Petryszak <i>et al. </i> - <a href="http://www.ncbi.nlm.nih.gov/pubmed/24304889" target="_new" class="extlink">PubMed: 24304889</a>
    </td>
    
  </tr>
  
  
  <tr>
    <td rowspan="2" class="leftcol"><p> <h2>Tissue expression</h2></p></td>
    <td>
       <p><i>H. sapiens</i></p>
    </td>
    <td> Antibody staining results from 47 normal and 20 cancer tissue types </td>
    <td> <a href="http://www.proteinatlas.org" target="_new" class="extlink">Human Protein Atlas</a> - Version 16.1</td>
    <td> Uhlen <i>et al.</i> - <a href="http://www.ncbi.nlm.nih.gov/pubmed/21139605" target="_new" class="extlink">PubMed: 21139605</a></td>
    </tr>
  <tr>
    <td> <p><i>H. sapiens</i></p> </td>
    <td> Human gene expression atlas of 5372 samples representing 369 different cell and tissue types, disease states and cell lines (experiment E-MTAB-62)</td>
    <td> <a href="http://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-62/" target="_new" class="extlink">ArrayExpress Atlas</a> - June 2011 </td>
    <td> Petryszak <i>et al.</i> - <a href="http://www.ncbi.nlm.nih.gov/pubmed/24304889" target="_new" class="extlink">PubMed: 24304889</a></td>
    
  </tr>
  
  
  <tr>
    <td rowspan="1"  class="leftcol"><p><h2>Interactions</h2></p></td>
    <td>
        <p><i>H. sapiens</i></p>
        <p><i>M. musculus</i></p>
        <p><i>R. norvegicus</i></p>
        <p><i>D. rerio</i></p>
        <p><i>S. cerevisiae</i></p>
        <p><i>S. pombe</i></p>
    </td>
    <td> Protein and genetic interactions</td>
    <td> <a href="http://www.thebiogrid.org" target="_new" class="extlink">BioGRID</a> - Version 3.4.148 </td>
    <td> Stark et al - <a href="http://www.ncbi.nlm.nih.gov/pubmed/16381927" target="_new" class="extlink">PubMed:16381927</a></td>
    
  </tr>
  
  <tr>
    <td rowspan="1" class="leftcol"><p> <h2>Metabolic pathways</h2></p></td>
    <td>
       <p><i>H. sapiens</i></p>
       <p><i>M. musculus</i></p>
       <p><i>R. norvegicus</i></p>
       <p><i>D. rerio</i></p>
       <p><i>S. cerevisiae</i></p>
        <p><i>S. pombe</i></p>
    </td>
    <td> Pathway, reaction and metabolite information and the genes involved</td>
    <td> <a href="http://www.genome.jp/kegg/" target="_new" class="extlink">KEGG</a> - June 2017</td>
    <td> Kanehisa et al - <a href="http://www.ncbi.nlm.nih.gov/pubmed/16381885" target="_new" class="extlink">PubMed: 16381885</a></td>
    
  </tr>


  <tr>
    <td rowspan="1" class="leftcol"><p> <h2>Exome</h2></p></td>
    <td>
       <p><i>H. sapiens</i></p>
    </td>
    <td> Aggregated exome sequencing summary data</td>
    <td> <a href="http://exac.broadinstitute.org" target="_new" class="extlink">ExAC</a> - Version 0.31</td>
    <td> N/A </td>
    
  </tr>


  

  

</table>


</div>