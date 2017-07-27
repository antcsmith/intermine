<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im" %>

<table width="100%">
  <tr>
    <td valign="top" rowspan="2">
      <div class="heading2">
        Current data
      </div>
      <div class="body">
        <DL>
                        
            MitoMiner contains various gene identifiers mapped to UniProt protein entries for all 5 species included in MitoMiner.
	    <BR><BR>
            We include the following:
            <UL>
	      <LI>Gene Symbol</LI>
              <LI>Gene Identifier (MGI, SGD etc.)</LI>
              <LI>NCBI Gene numbers</LI>
              <LI>Ensembl identifiers</LI>
              <LI>Mappings to the corresponding protein</LI>
              </UL>
	      <BR>
		In addition Gene Ontology annotation is available for genes, which has been copied from the corresponding proteins entries
	      <BR>
	      As it is easier to query MitoMiner using UniProt protein IDs, you can use this information to convert a gene ID (or list of gene IDs) to proteins identifiers by using the query below.
              Alternatively the excellent UniProt ID mapping service, available at <A href="http://www.uniprot.org/">http://www.uniprot.org/</A>, is able to convert from most types of identifier to UniProt IDs.
        </DL>
      </div>
    </td>
   <%-- <td valign="top">
      <div class="heading2">
      </div>
      <div class="body">
        <ul>

        </ul>
      </div>
    </td>
  </tr>--%>
</table>
