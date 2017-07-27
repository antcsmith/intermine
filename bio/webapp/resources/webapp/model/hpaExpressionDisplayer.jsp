<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
#hpa-expression h3 { background-image:url("images/icons/protein-atlas.gif"); background-repeat:no-repeat; background-position:6px 2px;
      padding-left:28px; line-height:20px; } 
#hpa-expression div.data-table { margin-top:20px; }
#hpa-expression-chart div.data-table { margin-bottom:300px; }
</style>

<div id="hpa-expression">

<c:choose>
  <c:when test="${empty(HPAResults)}">
    <h3 class="goog gray">Human Protein Atlas RNA Tissue Expression</h3>
    <p>No expression data available for this gene.</p>
  </c:when>
  <c:otherwise>
    <h3 class="goog">Human Protein Atlas RNA Tissue Expression</h3>
    <div class="chart" id="hpa-expression-chart"></div>

    <input class="toggle" type="button" value="Toggle table" />

    <%-- collection table --%>
    <div class="data-table collection-table" style="display:none;">
      <h3>Table</h3>
      <c:set var="inlineResultsTable" value="${HPACollection}" />
      <tiles:insert page="/reportCollectionTable.jsp">
        <tiles:put name="inlineResultsTable" beanName="inlineResultsTable" />
        <tiles:put name="object" beanName="reportObject.object" />
        <tiles:put name="fieldName" value="hpaExpression" />
      </tiles:insert>
    </div>


    <script type="text/javascript">
      function drawChart() {




var data = new google.visualization.DataTable();
data.addColumn('string', 'Tissue');
data.addColumn('number', 'Value TPM');


var antresults = "${HPAResults}";
var resultsarray = antresults.split(",");



var n = 0;
<c:forEach var ='i' begin ="1" end ="37">
data.addRows(1);
var temp = resultsarray[n].split("=");
temp[0] = temp[0].replace('{','');
temp[1] = temp[1].replace('}','');
data.setValue(n, 0, temp[0]);
data.setValue(n, 1, temp[1]);
n++;
</c:forEach>


   var options = {
     legend: {position: 'none'},
     bar: {groupWidth: "95%"}, 
      hAxis: { 
      textStyle: {fontSize: 10},
        slantedText:true,
        slantedTextAngle:45 // here you can even use 180
    },
    seriesType: "bars",  
    chartArea: {
    top: 15,
    bottom: 80,
    height:'100%'}   
   }; 






          
          <%-- aim & shoot --%>
     var chart = new google.visualization.ColumnChart(document.getElementById("hpa-expression-chart"));
          chart.draw(data, options);
      }

      google.load("visualization", "1", {"packages":["corechart"], "callback":drawChart}); 




      <%-- toggle table --%>
      jQuery("#hpa-expression input.toggle").click(function() {
        jQuery("#hpa-expression div.collection-table").toggle();
      });
      
    </script>



  </c:otherwise>
</c:choose>

</div>
