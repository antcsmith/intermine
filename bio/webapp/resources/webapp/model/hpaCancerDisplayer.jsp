<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
#hpacancer-expression h3 { background-image:url("images/icons/protein-atlas.gif"); background-repeat:no-repeat; background-position:6px 2px;
      padding-left:28px; line-height:20px; } 
#hpacancer-expression div.data-table { margin-top:20px; }
#hpacancer-expression-chart div.data-table { margin-bottom:20px; }
</style>

<div id="hpacancer-expression">

<c:choose>
  <c:when test="${empty(HPACancerResults)}">
    <h3 class="goog gray">Human Protein Atlas Cancer Expression</h3>
    <p>No expression data available for this gene.</p>
  </c:when>
  <c:otherwise>
    <h3 class="goog">Human Protein Atlas Cancer Expression</h3>
    <div class="chart" id="hpacancer-expression-chart"></div>

    <input class="toggle" type="button" value="Toggle table" />

    <%-- collection table --%>
    <div class="data-table collection-table" style="display:none;">
      <h3>Table</h3>
      <c:set var="inlineResultsTable" value="${HPACancerCollection}" />
      <tiles:insert page="/reportCollectionTable.jsp">
        <tiles:put name="inlineResultsTable" beanName="inlineResultsTable" />
        <tiles:put name="object" beanName="reportObject.object" />
        <tiles:put name="fieldName" value="hpaCancerExpression" />
      </tiles:insert>
    </div>


    <script type="text/javascript">
      function drawChart() {




var data = new google.visualization.DataTable();
data.addColumn('string', 'Tissue');
data.addColumn('number', 'Negative');
data.addColumn('number', 'Weak');
data.addColumn('number', 'Moderate');
data.addColumn('number', 'Strong');

var antresults = "${HPACancerResults}";
var resultsarray = antresults.split(",");



var n = 0;
<c:forEach var ='i' begin ="1" end ="20">
data.addRows(1);
var temp = resultsarray[n].split("=");
temp[0] = temp[0].replace('{','');

var temp2 = temp[1].split("/");

temp2[3] = temp2[3].replace('}','');
data.setValue(n, 0, temp[0]);
data.setValue(n, 1, temp2[0]);
data.setValue(n, 2, temp2[1]);
data.setValue(n, 3, temp2[2]);
data.setValue(n, 4, temp2[3]);
n++;
</c:forEach>


   var options = {
     isStacked:true, 
     height: 400,
     width: 700,
     top: 15,
     vAxis: { 
      textStyle: {fontSize: 10},
    },
    hAxis: { 
    textStyle: {fontSize: 12},
    title:"Number of patients",
    viewWindow: {
        min: 0,
        max: 12
    	},
    },
    series: {
    0:{color:'#ffffd4'},
    1:{color:'#fed98e'},
    2:{color:'#fe9929'},
    3:{color:'#cc4c02'},
  },
  chartArea: {
    top: 15,
    bottom: 80,
    height:'100%'}   
   }; 


          <%-- aim & shoot --%>
     var chart = new google.visualization.BarChart(document.getElementById("hpacancer-expression-chart"));
          chart.draw(data, options);
      }

      google.load("visualization", "1", {"packages":["corechart"], "callback":drawChart}); 




      <%-- toggle table --%>
      jQuery("#hpacancer-expression input.toggle").click(function() {
        jQuery("#hpacancer-expression div.collection-table").toggle();
      });
      
    </script>



  </c:otherwise>
</c:choose>

</div>
