<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im" %>

<table width="100%">
  <tr>
    <td>
      <div class="heading2">
        Annotation included in MitoMiner
      </div>
      <div class="body">
        <DL>
        MitoMiner contains extensive annotation from the <A href="http://www.geneontology.org/">Gene Ontology (GO)</A> 
      project and <A href="http://www.uniprot.org/">UniProt</A>. UniProt annotation consists of keywords associated with that protein. GO annotation describes gene products in terms of their associated biological processes, cellular components and molecular functions in a species-independent and hierarchal manner. 
      In addition we include <A href="http://www.ebi.ac.uk/interpro/">InterPro</A> protein domain information.   
      <BR><BR>
      UniProt, GO and Interpro annotation is available for all species included in MitoMiner (last updated June 2017).
      <BR><BR>	  
      You can use this information to search for genes, such as with a particular function or those involved in a particular cellular process, and see if those genes also have evidence or annotation for mitochondrial localisation.  

</DL>
      </div>
    </td>
    <%--<td width="40%" valign="top">
      <div class="heading2">
        Bulk download GO data
      </div>
      <div class="body">
        <ul>
          <li>
            All Genes in all loaded species that are GO annotated as mitochondrial
            <im:querylink text="[browse/download]" skipBuilder="true">
<query name="" model="genomic" view="Protein.uniprotAccession Protein.uniprotName Protein.name Protein.organism.name Protein.mitoEvidenceGO" longDescription="" sortOrder="Protein.uniprotAccession asc">
  <constraint path="Protein.mitoEvidenceGO" op="=" value="true"/>
  
</query>
</im:querylink>


          </li>

        </ul>
      </div>
    </td>--%>
  </tr>
</table>
