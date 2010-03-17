<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/Bindings">
	<html>
		<head>
			<link rel="stylesheet" type="text/css" href="styles/screen.css" media="screen" />
			<link href="styles/shCore.css" rel="stylesheet" type="text/css" />
			<link href="styles/shThemeDefault.css" rel="stylesheet" type="text/css" />
			
			<script type="text/javascript" src="scripts/jquery-1.4.2.min.js"></script>
			<script type="text/javascript" src="scripts/application.js"></script>
			<script type="text/javascript" src="scripts/shCore.js"></script>
			<script type="text/javascript" src="scripts/brushes/shBrushXml.js"></script>
			<title>GAMLDoc</title>
		</head>
		<body id="default">
			<h1>Dubit GAML Library</h1>			
			<ul>
				<xsl:apply-templates select="Package" />
				<xsl:apply-templates select="Binding" />
			</ul>
		</body>
	</html>
  </xsl:template>

	<xsl:template match="Package">
		<li class="package">
			<h2><xsl:value-of select="@name" /></h2>
			<ul>
				<xsl:apply-templates select="Binding" />
			</ul>
		</li>
	</xsl:template>

	<xsl:template match="Binding">
		
		  <li>
			<a href="bindings/{@name}.html"><xsl:value-of select="@name" /></a>
			<xsl:if test="@description">
				<xsl:value-of select="@description" />
			</xsl:if>
		</li>
	</xsl:template>
</xsl:stylesheet>