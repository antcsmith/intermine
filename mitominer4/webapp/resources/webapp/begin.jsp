<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="im"%>

<!-- newBegin.jsp -->
<html:xhtml/>


<!-- faux context help -->
<div id="ctxHelpDiv" class="welcome" style="display:none;">
  <div class="topBar info">
    <div id="ctxHelpTxt" class="welcome"></div>
    <a href="#" onclick="toggleWelcome();return false">Show more</a>
  </div>
</div>

<div id="content-wrap">

  <script type="text/javascript">

  // specify what happens to element in a small browser window (better add class than modify from here)
  if (jQuery(window).width() < '1205') {
    // cite etc
    jQuery('ul#topnav').addClass('smallScreen');
    // corners
    jQuery('#corner').addClass('smallScreen');
    if (jQuery(window).width() < '1125') {
      jQuery('#help').addClass('smallScreen');
    }
  }

  /**
   * A function that will save a cookie under a key-value pair
   * @key Key under which to save the cookie
   * @value Value to associate with the key
   * @days (optional) The number of days from now when to expire the cookie
   */
    jQuery.setCookie = function(key, value, days) {
      if (days == null) {
        document.cookie = key + "=" + escape(value);
      } else {
        // form date
        var expires = new Date();
        expires.setDate(expires.getDate() + days);
        // form cookie
        document.cookie = encodeURIComponent(key) + "=" + encodeURIComponent(value) + "; expires=" + expires.toUTCString();
      }
    };

  /**
   * A function that will get a cookie's value based on a provided key
   * @key Key under which the cookie is saved
   */
    jQuery.getCookie = function(key) {
      return (r = new RegExp('(?:^|; )' + encodeURIComponent(key) + '=([^;]*)').exec(document.cookie)) ?
      decodeURIComponent(r[1]) : null;
    };

    // minimize big welcome box into an info message
    function toggleWelcome(speed) {
      // default speed
      if (speed == null) speed = "slow";

      // minimizing?
      if (jQuery("#welcome").is(':visible')) {
        // hide the big box
        if (speed == "fast") {
          jQuery('#welcome').toggle();
        } else {
          jQuery('#welcome').slideUp();
        }
        // do we have words to say?
        var welcomeText = jQuery("#welcome-content.current").text();
        if (welcomeText.length > 0) {
          jQuery("#ctxHelpDiv.welcome").slideDown(speed, function() {
            // ...display a notification with an appropriate text
            if (welcomeText.length > 150) {
              // ... substr
              jQuery("#ctxHelpTxt.welcome").html(welcomeText.substring(0, 150) + '&hellip;');
            } else {
              jQuery("#ctxHelpTxt.welcome").html(welcomeText);
            }
          });
        }
        // set the cookie
        jQuery.setCookie("welcome-visibility", "minimized", 365);
      } else {
        jQuery("#ctxHelpDiv.welcome").slideUp(function() {
          jQuery("#welcome").slideDown(speed);
          // set the cookie
          jQuery.setCookie("welcome-visibility", "maximized", 365);
        });
      }
    }
  </script>
  <div id="welcome">
        <div class="center">
          <a class="close" title="Close" onclick="toggleWelcome();">Close</a>
          <div class="bochs" id="bochs-1">
              <div id="thumb">
                  <img src="themes/mitominer/thumbs/home.png" alt="MitoMiner home" />
              </div>
              <div id="welcome-content" class="current">
              <h2>New to version 4.0?</h2>
              <p>Welcome to <strong>MitoMiner</strong>, an integrated web resource of mitochondrial localisation evidence and phenotype data for mammals, zebrafish and yeasts.</p>
              <BR>
              <p> MitoMiner is now <strong>gene centric</strong>, with all data attached to gene objects, however the old protein centric version can be found <a href="http://mitominer.mrc-mbu.cam.ac.uk/release-3.1/begin.do">here</a>.</p>
              <BR>
              <p>If you are short of time, just navigate through our set of <a class="nice" href="#" onclick="switchBochs(2);return false;">Feature Hints</a>. For a more detailed description on how to use the site and its features try the 
               <a class="nice" href="<c:url value="http://mitominer.mrc-mbu.cam.ac.uk/support/tutorials" />"
                  onclick="javascript:window.open('<c:url value="http://mitominer.mrc-mbu.cam.ac.uk/support/tutorials" />','_help','toolbar=0,scrollbars=1,location=1,statusbar=1,menubar=0,resizable=1,width=1000,height=800');return false">Tutorials</a></p>
              <br />
              <a class="button gray" href="#" onclick="switchBochs(2);return false;" style="margin-right: 30px"> 
                    <div><span>FEATURES</span></div>
              </a>
              
              <a class="button gray" href="<c:url value="http://mitominer.mrc-mbu.cam.ac.uk/support/tutorials" />"
                  onclick="javascript:window.open('<c:url value="http://mitominer.mrc-mbu.cam.ac.uk/support/tutorials" />','_help','toolbar=0,scrollbars=1,location=1,statusbar=1,menubar=0,resizable=1,width=1000,height=800');return false">
                    <div><span>TUTORIALS</span></div>
              </a>
             </div>
            </div>
            <div class="bochs" id="bochs-2" style="display: none;">
              <div id="thumb">
              <a title="Try Search" href="/${WEB_PROPERTIES['webapp.path']}/dataCategories.do"><img
                src="themes/mitominer/thumbs/data.png"
                alt="MitoMiner data souces" /></a></div>
              <div id="welcome-content">
                <h2>Data Sources</h2>
                <p>MitoMiner integrates <strong>annotation</strong> from the Gene Ontology project, <strong>homology</strong> data from EnsemblCompara, <strong>phenotype</strong> information from MGI, ZFIN and SGD, <strong>interaction</strong> data from BioGRID, <strong>metabolic pathway</strong> data from KEGG
                and <strong>disease</strong> data from OMIM and ArrayExpress. This is combined with <strong>localisation data</strong> from
                <im:querylink text="56 large-scale" skipBuilder="true">
                <query name="" model="genomic" view="Publication.firstAuthor Publication.pubMedId Publication.title Publication.journal Publication.volume Publication.issue Publication.pages Publication.year" longDescription="" sortOrder="Publication.firstAuthor asc" constraintLogic="A and B and C">
                <constraint path="Publication.evidenceType" code="A" op="IS NOT NULL"/>
                <constraint path="Publication.evidenceType" code="B" op="!=" value="GO"/>
                <constraint path="Publication.evidenceType" code="C" op="!=" value="UniProt Keyword"/>
                </query>
                </im:querylink>     
                GFP tagging and mass-spectrometry studies, the Human Protein Atlas, and mitochondrial <strong>targeting sequence predictions</strong>. More details <a href="/${WEB_PROPERTIES['webapp.path']}/dataCategories.do">here.</a></p>
                <BR>
                <p>MitoMiner can help you determine:</p>
                <ul>
                  <li>Whether your gene encodes a mitochondrial protein</li>
                  <li>The function of your gene</li>
                  <li>The tissue specific expression of your gene</li>
                  <li>The knockout phenotype of your gene in mouse, zebrafish and yeast</li>
                  <Li>Other genes that interact with your gene</li>
                  <li>Whether your protein is associated with a human disease</li>
                </ul>
                <br />
                <a class="button gray" onclick="switchBochs(3);"><div><span>Next Hint: Search</span></div></a>
              </div>
            </div>

<div class="bochs" id="bochs-3" style="display: none;">
              <div id="thumb">
              <a title="Try Search" href="/${WEB_PROPERTIES['webapp.path']}/keywordSearchResults.do?searchBag="><img
                src="themes/mitominer/thumbs/search.png"
                alt="MitoMiner Search" /></a></div>
              <div id="welcome-content">
                <h2>Search</h2>
                <p>Our search engine operates across many data fields giving you the
                highest chance of getting a result. Just type your search words in the
                box.</p><BR>
                <p>You can search by:</p>
                <ul>
                  <li>Gene symbols and descriptions (e.g. COX5B)</li>
                  <li>Gene identifiers (Ensembl, Hugo, MGI, RGD, ZFIN, SGD and PomBase ids)</li>
                  <li>Protein identifiers (UniProt ids, accessions, names, descriptions etc.)</li>
                  <li>OMIM identifiers (ids or descriptions such as diabetes)</li>
                </ul><BR>
                <p>Search supports AND, OR, NOT and wildcard*. You can access Search from
                the home page or use QuickSearch, located top right on every page.</p>
                <br />
                <a class="button gray" onclick="switchBochs(4);"><div><span>Next Hint: Search Categories</span></div></a>
              </div>
            </div>
            <div class="bochs" id="bochs-4" style="display: none;">
              <div id="thumb">
              <a title="Try Category Search" href="/${WEB_PROPERTIES['webapp.path']}/keywordSearchResults.do?searchBag="><img
                src="themes/mitominer/thumbs/facets.png"
                alt="MinerMine Category Search" /></a></div>
              <div id="welcome-content">
                <h2>Category Search</h2>
                <p><strong>Category search</strong> show you the different places where your search words were found (eg. within Gene, Protein, GO Term etc) and in which Organisms.
                You can use these categories to filter for the type of results that are most relevant to you. When you've filtered you can even save the results
                straight to a List.</p>
                <br />
                <a class="button gray" onclick="switchBochs(5);"><div><span>Next Hint: Lists</span></div></a>
              </div>
            </div>

            <div class="bochs" id="bochs-5" style="display: none;">
              <div id="thumb">
              <a title="Try Lists" href="/${WEB_PROPERTIES['webapp.path']}/bag.do?subtab=view"><img
                src="themes/mitominer/thumbs/lists.png"
                alt="MitoMiner Lists" /></a></div>
              <div id="welcome-content">
                <h2>Lists</h2>
                <p>The <strong>Lists</strong> area lets you operate on whole sets of data at once. You can
                upload your own Lists (such as a list of candidate genes) or save them from results tables.
                We have also created useful <strong>Public Lists</strong> for everyone to use such as the IMPI and MitoCarta reference sets.</p><BR>
                <p>Here are just some of the things you can do:</p>
                <ul>
                  <li>Ask questions about your list using our predefined Templates searches</li>
                  <li>Combine or subtract the content of other Lists</li>
                  <li>Uncover hidden relationships with our analysis <strong>Widgets</strong></li>
                </ul><BR>
                <p>You can work with Lists from the Home page or select Lists from the Tab bar, located at the top of every page.</p>
                <br />
                <a class="button gray" onclick="switchBochs(6);"><div><span>Next Hint: Templates</span></div></a>
            </div>
           </div>

            <div class="bochs" id="bochs-6" style="display: none;">
              <div id="thumb">
              <a title="Try Templates" href="/${WEB_PROPERTIES['webapp.path']}/templates.do"><img
                src="themes/mitominer/thumbs/templates.png"
                alt="MitoMiner Templates" /></a></div>
              <div id="welcome-content">
                <h2>Templates</h2>
                <p>Our predefined <strong>template searches</strong> are designed to perform common types of query.
                Templates provide you with a simple form that lets you define your starting point and optional filters to help focus your search.</p><BR>
                <p>Templates cover common questions like:</p>
                <ul>
                    <li>I have a list of genes - do any of them encode mitochondrial proteins?</li>
                    <li>This gene came up in my results - what can I find out about it?</li>
                    <li>What genes/proteins with a particular function are found in the mitochondrion?</li>
                </ul><BR>
                <p>You can work with Templates from the Home page or select Templates from the Tab bar, located at the top of every page. If you have a request for a new template just let us know!</p>
                <br />
                <a class="button gray" onclick="switchBochs(7);"><div><span>Next Hint: MyMine</span></div></a>
            </div>
           </div>

            <div class="bochs" id="bochs-7" style="display: none;">
              <div id="thumb">
              <a title="Try MyMine" href="/${WEB_PROPERTIES['webapp.path']}/mymine.do"><img
                src="themes/mitominer/thumbs/mymine.png"
                alt="MitoMiner MyMine" /></a></div>
              <div id="welcome-content">
                <h2>MyMine</h2>
                <p><strong>MyMine</strong> is your <u>personal space</u> on MitoMiner. Creating an account is easy. Just provide an e-mail and a password and you're ready to go.</p><BR>
                <p>Your account allows you to:</p>
                <ul>
                  <li>Save Queries and Lists</li>
                  <li>Modify and save Templates for later use</li>
                  <li>Mark Public Templates as favourites so they're easier to find</li>
                </ul><BR>
                <p>You can access MyMine from the Tab bar, located at the top of every page.</p>
                <p>Note: Your data and e-mail address are confidential and we won't send you unsolicited mail.</p>
                <br />
                <a class="button gray" onclick="switchBochs(8);"><div><span>Next Hint: QueryBuilder</span></div></a>
            </div>
           </div>

            <div class="bochs" id="bochs-8" style="display: none;">
              <div id="thumb">
              <a title="Try QueryBuilder" href="/${WEB_PROPERTIES['webapp.path']}/customQuery.do"><img
                src="themes/mitominer/thumbs/querybuilder.png"
                alt="metabolicMine QueryBuilder" /></a></div>
              <div id="welcome-content">
                <h2>QueryBuilder</h2>
                <p>The <strong>QueryBuilder (QB)</strong> is the most powerful feature of MitoMiner. Its advanced interface lets you:</p>
                <ul>
                  <li>Construct your own custom searches
                  <li>Modify your previous searches
                  <li>You can even edit our predefined Templates.
                </ul><BR>
                <p>The easiest way to get started with QB is by editing one of our pre-existing Template searches.
                Detailed instructions on how to use the QB can be found in the tutorial.</p>
                <p>You can access QueryBuilder from the Tab bar, located at the top of every page.</p>
                <br/>
                <br/>
            </div>
           </div>

           <div style="clear:both;"></div>

              <ul id="switcher">
                <li id="switcher-1" class="switcher current"><a onclick="switchBochs(1);">Start</a></li>
                <li id="switcher-2" class="switcher"><a onclick="switchBochs(2);">1</a></li>
                <li id="switcher-3" class="switcher"><a onclick="switchBochs(3);">2</a></li>
                <li id="switcher-4" class="switcher"><a onclick="switchBochs(4);">3</a></li>
                <li id="switcher-5" class="switcher"><a onclick="switchBochs(5);">4</a></li>
                <li id="switcher-6" class="switcher"><a onclick="switchBochs(6);">5</a></li>
                <li id="switcher-7" class="switcher"><a onclick="switchBochs(7);">6</a></li>
                <li id="switcher-8" class="switcher"><a onclick="switchBochs(8);">7</a></li>
              </ul>
        </div>
    </div>

    <script type="text/javascript">
    // are we showing a minimized welcome box?
    if (jQuery.getCookie("welcome-visibility") == "minimized") toggleWelcome("fast");

    /* hide switcher of we are on first time here */
    if (jQuery("#switcher-1").hasClass('current')) {
      jQuery("#switcher").hide();
    }

    /* div switcher for welcome bochs using jQuery */
    function switchBochs(newDivId) {
      // no current
      jQuery(".switcher").each (function() { jQuery(this).removeClass('current'); });
      // apply current
      jQuery('#switcher-'+newDivId).addClass('current');
      // hide them all bochs
      jQuery(".bochs").each (function() { jQuery(this).hide(); });
      // then show our baby
      jQuery('#bochs-'+newDivId).fadeIn();

      // apply active class
      jQuery("#welcome-content").each (function() { jQuery(this).removeClass('current'); });
      jQuery('#bochs-'+newDivId+' > #welcome-content').addClass('current');

      // show/hide switcher?
      if (jQuery("#switcher-1").hasClass('current')) {
        jQuery("#switcher").hide();
      } else {
        jQuery("#switcher").show();
      }
    }
  </script>

    <div id="boxes">
        <div id="search-bochs">
            <img class="title" src="themes/mitominer/search.png" title="search"/>
            <div class="inner">
                <h3>Search</h3>
                <span class="ugly-hack">&nbsp;</span>

                <script type="text/javascript">
                  /* pre-fill search input with a term */
                  function preFillInput(term) {
                    var e = jQuery("input#actionsInput");
                    e.val(term);
                    if (e.hasClass(inputToggleClass)) e.toggleClass(inputToggleClass);
                    e.focus();
                  }
                </script>

                <p>Enter a gene symbol, Ensembl id, or genome project identifier [eg.
                <a onclick="preFillInput('atp5b');return false;" title="Search for atp5b"><strong>atp5b</strong></a>,
                <a onclick="preFillInput('ENSMUSG00000025393');return false;" title="Search for ENSMUSG00000025393"><strong>ENSMUSG00000025393</strong></a>,
                <a onclick="preFillInput('MGI:107801');return false;" title="Search for MGI:107801"><strong>MGI:107801</strong></a>,
                <a onclick="preFillInput('HGNC:830');return false;" title="Search for HGNC:830"><strong>HGNC:830</strong></a>].
                <br />Alternatively, search for a gene name, description, or other keyword [eg.
                <a onclick="preFillInput('ATP synthase*');return false;" title="Search for ATP synthase"><strong>ATP synthase subunit*</strong></a>].
                </p>

                <form action="<c:url value="/keywordSearchResults.do"/>" name="search" method="get">
                    <div class="input"><input id="actionsInput" name="searchTerm" class="input" type="text" value="${WEB_PROPERTIES['begin.searchBox.example']}"></div>
                    <div class="bottom">
                        <center>
                            <input id="mainSearchButton" name="searchSubmit" class="button dark" type="submit" value="search"/>
                        </center>
                    </div>
                </form>
               
				<script type="text/javascript">
				(function() {
				    var index = function(value) {
				        switch (value) {
				          case "${ids}":
				          case "${WEB_PROPERTIES['begin.searchBox.example']}":
				          case "":
				            // if placeholder text or no text in place, take us to the index
				            jQuery(location).attr('href', "/${WEB_PROPERTIES['webapp.path']}/keywordSearchResults.do?searchBag=");
				            return false;
				        }
				        return true;
				    }
					
					var button = jQuery('#mainSearchForm a'),
					    input  = jQuery("input#actionsInput");
					
					button.click(function(e){
			        	if( index(input.val()) ) {
			        		document.getElementById("mainSearchForm").submit();
			        	}
					});
				    input.keypress(function(e){
				        if(e.which == 13){
				        	if( index(input.val()) ) {
				        		document.getElementById("mainSearchForm").submit();
				        	}
				        }
				      });
				})()
				</script>

                <div style="clear:both;"></div>
            </div>
        </div>
        <div id="lists-bochs">
            <img class="title" src="themes/mitominer/addlist.png" title="lists"/>
            <div class="inner">
                <h3>Upload and analyse lists of data</h3>
                <div class="right">
                  <p>
                  <img style="float: right; padding-left: 5px; margin-right: 4px;" alt="widget charts" src="themes/mitominer/thumbs/widgets.png">
                  <strong>Explore</strong> and <strong>Analyse</strong> your own data. 
                  Upload your own list of identifiers or use our public mitochondrial genome lists.
                  These can then can analysed with our widgets and used in the template searches below.
                  </p>
                </div>

                <div class="left">
                  <span class="ugly-hack">&nbsp;</span>
                  <form name="buildBagForm" method="post" action="<c:url value="/buildBag.do" />">
                      <select name="type">
                        <option value="Gene">Gene</option>
                        <option value="Protein">Protein</option>
                      </select>
                      <div class="textarea">
                        <textarea autocomplete="off" id="listInput" name="text">e.g. <c:out value="${WEB_PROPERTIES['bag.example.identifiers']}" /></textarea>
                      </div>
                  </form>
                </div>
                <div style="clear:both;"></div>

               
                  <a class="advanced" class="adv" href="bag.do?subtab=upload">advanced</a>                  
                <br />          
                <a class="button gray">
                    <div><span>Upload list</span></div>
                  </a>
                  <script type="text/javascript">
                    
                    jQuery('#lists-bochs a.button').click(function() {
                      jQuery("textarea#listInput").val(jQuery("textarea#listInput").val().replace("e.g.", "").replace(/^\s+|\s+$/g, ""));
                      document.buildBagForm.submit();
                    });
                  </script>
              
            </div>
        </div>
    </div>

    <div style="clear:both"></div>

    <div id="bottom-wrap">
      <div id="templates-bochs">
        <img class="title" src="themes/mitominer/settings.png" title="templates"/>
          <div class="inner">
            <h3>Use template searches</h3>
            <p><span class="ugly-hack"></span>Get started with <strong>powerful searches</strong> using our prebuilt and customizable Templates.</p>
          </div>

          <c:if test="${!empty tabs}">
            <div id="templates">
                <table id="menu" border="0" cellspacing="0">
                    <tr>
                      <!-- templates tabs -->
                      <c:forEach var="item" items="${tabs}">
                        <td><div class="container"><span id="tab${item.key}">
                          <c:forEach var="row" items="${item.value}">
                            <c:choose>
                              <c:when test="${row.key == 'name'}">
                                <c:out value="${row.value}" />
                              </c:when>
                            </c:choose>
                          </c:forEach>
                        </span></div></td>
                      </c:forEach>
                    </tr>
                </table>

                <div id="tab-content">
                    <div id="ribbon"></div>

                    <!-- templates content -->
                    <c:forEach var="item" items="${tabs}">
                      <div id="content${item.key}" class="content" style="display:none;">
                        <c:forEach var="row" items="${item.value}">
                          <c:choose>
                            <c:when test="${row.key == 'identifier'}">
                              <c:set var="aspectTitle" value="${row.value}"/>
                            </c:when>
                            <c:when test="${row.key == 'description'}">
                              <c:if test="${aspectTitle == 'Mito Reference'}">
			  <p><c:out value="${row.value}" />&nbsp;<a href="aspect.do?name=Mitochondrial%20Reference%20Sets">Read more</a></p><br/>
                            </c:if>
                            <c:if test="${aspectTitle == 'Localisation Evidence'}">
                              <p><c:out value="${row.value}" />&nbsp;<a href="aspect.do?name=Proteins">Read more</a></p><br/>
                            </c:if>
                            <c:if test="${aspectTitle == 'Targeting Sequences'}">
                              <p><c:out value="${row.value}" />&nbsp;<a href="aspect.do?name=Experimental%20Data">Read more</a></p><br/>
                            </c:if>
                            <c:if test="${aspectTitle == 'Gene Ontology'}">
                              <p><c:out value="${row.value}" />&nbsp;<a href="aspect.do?name=Annotation">Read more</a></p><br/>
                            </c:if>
                            <c:if test="${aspectTitle == 'Metabolism'}">
                              <p><c:out value="${row.value}" />&nbsp;<a href="aspect.do?name=Metabolic%20Pathways">Read more</a></p><br/>
                            </c:if>
                            <c:if test="${aspectTitle == 'Phenotypes'}">
                              <p><c:out value="${row.value}" />&nbsp;<a href="aspect.do?name=Human%20Diseases">Read more</a></p><br/>
                            </c:if>
                            <c:if test="${aspectTitle == 'Homology'}">
                              <p><c:out value="${row.value}" />&nbsp;<a href="aspect.do?name=Protein%20Homology">Read more</a></p><br/>
                            </c:if>
                            </c:when>
                            <c:when test="${row.key == 'name'}">
                              <p>Search for <c:out value="${row.value}" />:</p>
                            </c:when>
                            <c:when test="${row.key == 'templates'}">
                              <ul>
                                <c:forEach var="template" items="${row.value}" >
                                    <li><a href="template.do?name=${template.name}&scope=global"><c:out value="${fn:replace(template.title,'-->','&nbsp;<img src=\"images/icons/green-arrow-16.png\" style=\"vertical-align:bottom\">&nbsp;')}" escapeXml="false" /></a></li>
                                </c:forEach>
                              </ul>
                              <p class="more"><a href="templates.do?filter=${aspectTitle}">More queries</a></p>
                            </c:when>
                          </c:choose>
                        </c:forEach>
                      </div>
                    </c:forEach>
                </div>
            </div>
          </c:if>
      </div>
      <div style="clear: both;"></div>

<div id="bottom-wrap2">
<div id="mitominerlist-bochs">
        <img class="title" src="themes/mitominer/uselist.png" title="lists"/>
          <div class="inner">
            <h3>Use a mitochondrial genome list</h3>
            <p><span class="ugly-hack"></span>MitoMiner contains two different reference sets of genes that encode mitochondrial proteins: IMPI and MitoCarta. You can use
            these gene lists in the queries above or use the links below to query these datasets directly.</p>
            <BR>
            <div id= "lists">
            <p> <a href="mitocarta.do"><strong>MitoCarta 2.0 </strong></a> - an inventory of 1158 human and mouse genes encoding proteins with strong support</p>
            <p>of mitochondrial localisation. <a href="mitocarta.do">Read about and query MitoCarta 2.0 here</a></p>
            <BR>
            <p> <a href="impi.do"><strong>IMPI (version Q3 2017)</strong></a>- Integrated Mitochondrial Protein Index of 1550 mammalian genes (1130 known and 420 predicted from experimental</p> 
            <p> data) encoding proteins that are associated with the mitochondrion. <a href="impi.do">Read about and query IMPI here</a></p>
          <BR>
          <BR>
          </div>
</div>
</div>
</div>




        <div id="low">
            <div id="rss" style="display:none;">
                <h4>News<span>&nbsp;&amp;&nbsp;</span>Updates</h4>
                <table id="articles"></table>
                <c:if test="${!empty WEB_PROPERTIES['links.blog']}">
                  <p class="more"><a target="new" href="${WEB_PROPERTIES['links.blog']}">More news</a></p>
                </c:if>
            </div>

            <div id="api">
                <h4>Perl, Python, Ruby<span>&nbsp;&amp;&nbsp;</span>Java API</h4>
                <img src="themes/mitominer/api.png" alt="perl java python ruby" />
                <p>
                    You can fetch data directly from <c:out value="${WEB_PROPERTIES['project.title']}"/>
                    for your own programs via our Application Programming Interface (API) too!
                    We provide client libraries in the following languages:
                </p>
                <ul id="api-langs">
                    <li><a href="<c:out value="${WEB_PROPERTIES['path']}" />api.do?subtab=perl">Perl</a>
                    <li><a href="<c:out value="${WEB_PROPERTIES['path']}" />api.do?subtab=python">Python</a>
                    <li><a href="<c:out value="${WEB_PROPERTIES['path']}" />api.do?subtab=ruby">Ruby</a>
                    <li><a href="<c:out value="${WEB_PROPERTIES['path']}" />api.do?subtab=java">Java</a>
                </ul>
            </div>

            <div style="clear:both;"></div>
        </div>
    </div>
</div>

<script type="text/javascript">

    // 'open up' the first tab
    jQuery("table#menu td:first").addClass("active").find("div").append('<span class="right"></span><span class="left"></span>').show();
    jQuery("div.content:first").show();

    // onclick behavior for tabs
    jQuery("table#menu td").click(function() {
        jQuery("table#menu td.active").find("div").find('.left').remove();
        jQuery("table#menu td.active").find("div").find('.right').remove();
        jQuery("table#menu td").removeClass("active");

        jQuery(this).addClass("active").find("div").append('<span class="right"></span><span class="left"></span>');
        jQuery("#tab-content .content").hide();

        if (jQuery(this).is('span')) {
            // span
            var activeTab = jQuery(this).attr("id").substring(3);
        } else {
            // td, div (IE)
            var activeTab = jQuery(this).find("span").attr("id").substring(3);
        }
        jQuery('#content' + activeTab).fadeIn();

        return false;
    });

    // feed URL
    var feedURL = "${WEB_PROPERTIES['project.rss']}";
    // limit number of entries displayed
    var maxEntries = 4;
    // where are we appending entries? (jQuery syntax)
    var target = 'table#articles';

    var months = new Array(12); months[0]="Jan"; months[1]="Feb"; months[2]="Mar"; months[3]="Apr"; months[4]="May"; months[5]="Jun";
    months[6]="Jul"; months[7]="Aug"; months[8]="Sep"; months[9]="Oct"; months[10]="Nov"; months[11]="Dec";

    jQuery(document).ready(function () {
        // DWR fetch, see AjaxServices.java
        AjaxServices.getNewsPreview(feedURL, function (data) {
            if (data) {
                // show us
                jQuery('#rss').slideToggle('slow');

                // declare
                var feedTitle, feedDescription, feedDate, feedLink, row, feed;

                // convert to XML, jQuery manky...
                try {
                    // Internet Explorer
                    feed = new ActiveXObject("Microsoft.XMLDOM");
                    feed.async = "false";
                    feed.loadXML(data);
                } catch (e) {
                    try {
                        // ...the good browsers
                        feed = new DOMParser().parseFromString(data, "text/xml");
                    } catch (e) {
                        // ... BFF
                        alert(e.message);
                        return;
                    }
                }

                var items = feed.getElementsByTagName("item"); // ATOM!!!
                for (var i = 0; i < items.length; i++) {
                    // early bath
                    if (i == maxEntries) return;

                    feedTitle = trimmer(items[i].getElementsByTagName("title")[0].firstChild.nodeValue, 70);
                    feedDescription = trimmer(items[i].getElementsByTagName("description")[0].firstChild.nodeValue, 70);
                    // we have a feed date
                    if (items[i].getElementsByTagName("pubDate")[0]) {
                        feedDate = new Date(items[i].getElementsByTagName("pubDate")[0].firstChild.nodeValue);
                        feedLink = items[i].getElementsByTagName("link")[0].firstChild.nodeValue

                        // build table row
                        row = '<tr>' + '<td class="date">' + '<a target="new" href="' + feedLink + '">' + feedDate.getDate()
                        + '<br /><span>' + months[feedDate.getMonth()] + '</span></a></td>'
                        + '<td><a target="new" href="' + feedLink + '">' + feedTitle + '</a><br/>' + feedDescription + '</td>'
                        + '</tr>';
                    } else {
                        feedLink = items[i].getElementsByTagName("link")[0].firstChild.nodeValue

                        // build table row
                        row = '<tr>'
                        + '<td><a target="new" href="' + feedLink + '">' + feedTitle + '</a><br/>' + feedDescription + '</td>'
                        + '</tr>';
                    }

                    // append, done
                    jQuery(target).append(row);
                }
            }
        });
    });

        // trim text to a specified length
    function trimmer(grass, length) {
        if (!grass) return;
        grass = stripHTML(grass);
        if (grass.length > length) return grass.substring(0, length) + '...';
        return grass;
    }

    // strip HTML
    function stripHTML(html) {
        var tmp = document.createElement("DIV"); tmp.innerHTML = html; return tmp.textContent || tmp.innerText;
    }

    var placeholder = '<c:out value="${WEB_PROPERTIES['begin.searchBox.example']}" />';
    var placeholderTextarea = '<c:out value="${WEB_PROPERTIES['textarea.identifiers']}" />';
    var inputToggleClass = 'eg';

    /*
    function preFillInput(target, term) {
        var e = jQuery("input#actionsInput");
        e.val(term);
        if (e.hasClass(inputToggleClass)) e.toggleClass(inputToggleClass);
        e.focus();
    }
    */

    // e.g. values only available when JavaScript is on
    jQuery('input#actionsInput').toggleClass(inputToggleClass);
    jQuery('textarea#listInput').toggleClass(inputToggleClass);

    // register input elements with blur & focus
    jQuery('input#actionsInput').blur(function() {
        if (jQuery(this).val() == '') {
            jQuery(this).toggleClass(inputToggleClass);
            jQuery(this).val(placeholder);
        }
    });
    jQuery('textarea#listInput').blur(function() {
        if (jQuery(this).val() == '') {
            jQuery(this).toggleClass(inputToggleClass);
            jQuery(this).val(placeholderTextarea);
        }
    });
    jQuery('input#actionsInput').focus(function() {
        if (jQuery(this).hasClass(inputToggleClass)) {
            jQuery(this).toggleClass(inputToggleClass);
            jQuery(this).val('');
        }
    });
    jQuery('textarea#listInput').focus(function() {
        if (jQuery(this).hasClass(inputToggleClass)) {
            jQuery(this).toggleClass(inputToggleClass);
            jQuery(this).val('');
        }
    });

    // associate functions with search that redir to a keyword objects listing instead of search results
    jQuery('#mainSearchButton').click(function() {
      // if placeholder text in place, take us elsewhere
      if (jQuery("#actionsInput").val() == placeholder) {
        jQuery(location).attr('href', "/${WEB_PROPERTIES['webapp.path']}/keywordSearchResults.do?searchBag=");
        return false;
      }
    });
</script>

<!-- /newBegin.jsp -->
