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
           We include extensive protein information and sequences from <A href="http://www.ebi.uniprot.org/index.shtml">UniProt
            </A> for all the organisms in MitoMiner: <BR><BR>
            <UL>    
              <LI><I><b>Homo sapiens</b></I> (taxon 9606)</LI>
              <LI><I><b>Mus musculus</b></I> (taxon 10090)</LI>
              <LI><I><b>Rattus norvegicus</b></I> (taxon 10116)</LI>
              <LI><I><b>Danio rerio</b></I> (taxon 7955)</LI>
              <LI><I><b>Saccharomyces cerevisiae</b></I> strain ATCC 204508/S288c (taxon 559292)</LI>
              <LI><I><b>Schizosaccharomyces pombe</b></I> strain 972H (taxon 284812)</LI>
              
            </UL>
            <BR> 
            For each protein record in UniProt for each species the following
            information is extracted and loaded into MitoMiner:
            <UL><LI>UniProt accession number</LI>
              <LI>UniProt name</LI>
              <LI>Protein name</LI>
              <LI>Length and molecular weight</LI>
              <LI>Sequence</LI>
              <LI>Features</LI>
              <LI>Associated UniProt keywords</LI>
              <LI>Publications</LI>
              <LI>Gene symbol</LI>
              <LI>Gene Identifier (MGI, SGD etc.)</LI>
              <LI>NCBI Gene numbers</LI>
              <LI>Ensembl identifiers</LI></UL>
            <BR>
          
            <BR>
            For every sequence loaded we calculate the mitochondrial targeting sequence prediction scores from:
            <UL><LI><A href="http://ipsort.hgc.jp">iPSORT</A></LI>
              <LI><A href="http://ihg.gsf.de/ihg/mitoprot.html">MitoProt</A></LI>
              <LI><A href="http://www.cbs.dtu.dk/services/TargetP">TargetP</A></LI>
              <LI><A href="http://mitf.cbrc.jp/MitoFates/cgi-bin/top.cgi">MitoFates</A></LI>
            </UL>
            <BR>
            
            We also include cleavage site predictions where available.<BR>
            <BR>

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
        </ul>
      </div>
    </td>--%>
  </tr>
</table>
