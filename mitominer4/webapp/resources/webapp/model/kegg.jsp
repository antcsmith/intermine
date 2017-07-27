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
        MitoMiner includes metabolic pathway information from the Kyoto Encyclopedia of Genes and Genomes (KEGG) database.   
        <BR><BR>             
	  The <a href="http://www.genome.jp/kegg/">KEGG</a> database is a collection of manually curated metabolic pathway maps that are based on molecular interaction
	  and reaction networks. Pathway and reaction data can provide a context for a protein and allow metabolic networks to be created.
	  Information regarding pathways, reactions, compounds and enzymes have been extracted from <a href="http://www.genome.jp/kegg/">KEGG</a> and loaded into 
	  MitoMiner (last updated June 2017).
	<BR><BR>
	Due to the requirements of the KEGG license agreement, users of this service may not download large quantities of KEGG Data.
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
