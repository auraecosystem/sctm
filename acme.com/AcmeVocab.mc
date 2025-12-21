<XML-MCF>
 <!--- WebSiteVocab and PersonVocab define some of the basic
       terms we will use to describe web sites and people
       respectively. AcmeVocab are some extensions defined by
       the folks at Acme Content Company --->
 <NBLK XML-LINK="SIMPLE" ROLE="XML-MCF-BLOCK"
       href="http://www.standards.org/WebSiteVocab.mc" prefix="wsv" />
 <NBLK XML-LINK="SIMPLE" ROLE="XML-MCF-BLOCK"
       href="http://www.standards.org/PersonVocab.mc" prefix="pv"/>
 <NBLK XML-LINK="SIMPLE" ROLE="XML-MCF-BLOCK"
       href="http://www.acme.com/AcmeVocab.mc" prefix="acme"/>
 <wsv:TableOfContents id="acc.com/acctoc">
         <name value="Acme Content Company Website Table of Contents"/>
 </wsv:TableOfContents>

 <wsv:WebSite id="www.acc.com/website">
         <XML-MCF:name value="ACME Content Company Web Site"/>
         <siteHomePage unit="http://www.acc.com/"/>
         <helpPage unit="http://www.acc.com/help.html"/>
         <lastRevisionDate value="today"/>
         <toc unit="acc.com/acctoc"/>
         <contactAgent unit="jb@acc.com"/>
         <objectIcon unit="http://www.acc.com/ACCLogo.jpg"/>
         <contactInformation value="webmaster@acme.com"/>
 </wsv:WebSite>

 <wsv:JPGImage id="http://www.acc.com/ACCLogo.jpg">
         <location value="http://www.acc.com/ACCLogo.jpg" />
         <size value="3224"/>
 </wsv:JPGImage>
 
 <pv:Person id="jb@acc.com">
 <!--- we are using the email address as the unique identifier --->
         <XML-MCF:name value="John Brown"/>
         <XML-MCF:description>John Brown, who amongst other things, takes care of
           the ACME web site</XML-MCF:description> 
         <contactInformation value="415-937-2607"/>
         <email value="jb@acc.com"/>
         <homePage unit="/people/jb.html"/>
         <employeeOf unit="/AcmeContentCompany"/>
 </pv:Person>
 
 <pv:Organization id="acc.com/AcmeContentCompany">
         <XML-MCF:name value="The Acme Content Company"/>
         <homePage value="http://www.acme.com"/>
 </pv:Organization>
 
 <wsv:Subject id="http://www.acc.com/WildLifePictures.mc" >
         <location value="http://www.acc.com/WildLifePictures.mc" />
         <XML-MCF:parent unit="acc.com/acctoc"/>
         <XML-MCF:name value="Wild Life Pictures taken in the Sahara"/>
         <lastRevisionDate value="1/1/95"/>
 </wsv:Subject>
 
 <wsv:Subject id="acc.com/StillLife">
         <XML-MCF:parent unit="acc.com/acctoc"/>
         <superTopic unit="http://mcf.yahoo.com/mcf/arts/index.mcf"/>
         <!--- John Brown believes that this Subject should belong 
               to the Yahoo arts category, irrespective of its listing in
               Yahoo ---> 
         <XML-MCF:name value="Still Life Pictures"/>
         <contentUpdateSchedule unit="Monthly"/>
 
         <Page id="acc.com/Copyright.html">
                 <author unit="jb@acc.com" />
                 <contentUpdateSchedule unit="NeverUpdated"/>
         </Page>
 
         <Subject id="acc.com/Fruit Pictures">
                 <XML-MCF:name value="Pictures of Apples and Oranges"/>
                 <nextUpdateTime value="June 1 1997"/>
                 <superTopic unit="acc.com/Fruit Pictures"/>
                 <!--- superTopic is a more specialized relation than just
                       implied parent--> 
 
                 <Page id="http://www.acc.com/Apple001.html">
                         <location value="http://www.acc.com/Apple001.html"/>
                         <authorIndividual unit="jb@acc.com"/>
                         <size value=2000/>
                         <acme:catalogNumber value="3232"/>
                         <acme:deptOfPage unit="acc.com/accEMarketingDept.mc"/>
                         <loadSize value="35000"/> 
                         <contentMirror 
                           value="http://www.mirrors.com/accbackups/Apple001.html"/>
                         <!--- so that a smart browser can use the mirror if 
                               the server is too loaded --->
                 </Page>
 
         <location value="http://www.acc.com/MoreStillLife.mc"/>
         <!--- more entries under this subject can be found at the above url --->
         </Subject>
 </wsv:Subject>
 
 <acme:Department id="acc.com/accEMarketingDept.mc">
         <wsv:location value="http://www-internal.acc.com/accEMarketingDept.mc"/>
         <departmentNumber value="32"/>
 </acme:Department>
</xml-mcf>
