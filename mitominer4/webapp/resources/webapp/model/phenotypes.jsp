<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im" %>

<TABLE width="100%">
  <tr>
    <td valign="top">
      <div class="heading2">
        Current data
      </div>
      <div class="body">
        <p>
        MitoMiner includes phenotype information from  several sources:<BR><BR>
        
        <UL>    
         <LI><I>Homo sapiens</I>: <a href="http://www.ncbi.nlm.nih.gov/omim/">OMIM</a> - disease references, <a href="http://www.ebi.ac.uk/arrayexpress/experiments/E-MTAB-62/">Array Express</a> - tissue and disease data, and <a href="http://www.genomernai.org">GenomeRNAi</a> - High-throughput cell-based RNAi screens</LI>
         <LI><I>Mus musculus</I>: <a href="http://www.informatics.jax.org">MGI</a> - Mammalian phenotypes of spontaneous, induced and engineered mutations</LI>
         <LI><I>Danio rerio</I>: <a href="http://zfin.org">ZFIN</a> - Zebrafish knockdown and mutant information</LI>
         <LI><I>Saccharomyces cerevisiae</I>: <a href="http://www.yeastgenome.org">SGD</a> - Yeast mutant information</LI>
            </UL>
        
        
      </div>
    </td>


  </tr>
</TABLE>
