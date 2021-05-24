<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">    
  <!--<xsl:output method="xml" indent="yes" 
	      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
	      doctype-public="XHTML 1.0 Transitional"/>-->

  <xsl:output method="html" indent="yes"
	      doctype-system="http://www.w3.org/TR/html4/loose.dtd"
	      doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>

  <!-- *** PAGE *** -->
  <!-- <page name="..."> ... </page> -->
  
  <xsl:template match="/page">
    <html>
      
      <head>
	<title>
          QE 2021: Installation of virtual machine
	</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link href="style.css" rel="stylesheet" type="text/css" />
      </head>
      
      <body>
	<div id="logo">
	  <img src="images/qe2021-header.png" width="100%" alt="QE 2021 title page image"/>
	  <br/><small>
          (Virtual event from 17 till 28 May 2021: more details at
          <a
              href="http://indico.ictp.it/event/9616/">http://indico.ictp.it/event/9616/</a>)
        </small>
	</div>
        
	<xsl:apply-templates/>
        
        <div id="logo">
	  &#160;
	  <img src="images/logos.png" width="100%" alt="sponsors image"/>
	  <br/>
	</div>
      </body>
    </html>    
  </xsl:template>

  <xsl:template match="card">
    <div class="content">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="qe">
    <a href="https://www.quantum-espresso.org/">
      <span class="qe">
        <!--<font color="#af101d">Quantum</font><font color="#808080"> ESPRESSO</font>-->
        <font color="#af101d">Quantum ESPRESSO</font>
      </span>
    </a>
  </xsl:template>
  <xsl:template match="qeplain">
    <span class="qe">Quantum ESPRESSO</span>
  </xsl:template>

  <!-- This part is for uploading slides, hopefully ... --> 

  <xsl:template match="inv">
    <i><font color="#aa0000">(invited)</font></i>
  </xsl:template>

  <xsl:template match="tit">
    <br/><i><xsl:apply-templates/></i>
  </xsl:template>

  <xsl:template match="pdf">
    <img src="images/pdf.png" align="top" vspace="0" height="16" width="16" alt="PDF"/>
  </xsl:template>
</xsl:stylesheet>
