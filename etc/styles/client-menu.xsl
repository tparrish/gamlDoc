<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />
	<xsl:stylesheet version="1.0"
	  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	  xmlns:h="http://www.w3.org/1999/xhtml" />
	
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
				<base target="content" />
			</head>
			<body id="menu">
				<h1><a href="default.html">Gaml Nodes</a></h1>
				<ul>
					<xsl:apply-templates select="Package" />
					<xsl:apply-templates select="Binding" />
				</ul>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="Package">
		<li>
			<h2><xsl:value-of select="@name" /></h2>
			<ul class="package">
				<xsl:apply-templates select="Binding" />
			</ul>
		</li>
	</xsl:template>

	<xsl:template match="Binding">
		  <li><a href="bindings/{@name}.html"><xsl:value-of select="@name" /></a></li>
	</xsl:template>

</xsl:stylesheet>