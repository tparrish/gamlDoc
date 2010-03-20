<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />
	
	<xsl:template match="/Bindings">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="styles/reset.css" media="screen" />
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
				<!--<h1><a href="default.html">Gaml Nodes</a></h1>-->
				<ul>
					<!--<xsl:if test="count(Binding)">
						<li class="core">
							<h2>Core</h2>
							<ul>
								<xsl:apply-templates select="Binding">
									<xsl:sort select="@name" data-type="text" />
								</xsl:apply-templates>
							</ul>
						</li>
					</xsl:if>-->
					<xsl:apply-templates select="Package">
						<xsl:sort select="@name" data-type="text" />
					</xsl:apply-templates>
				</ul>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="Package">
		<xsl:if test="not(@nodoc)">
			<li class="package">
				<h2><xsl:value-of select="@name" /></h2>
				<ul>
					<xsl:apply-templates select="Binding" />
				</ul>
			</li>
		</xsl:if>
	</xsl:template>

	<xsl:template match="Binding">
		<xsl:if test="not(@nodoc)">
  			<li><a href="bindings/{@name}.html"><xsl:value-of select="@name" /></a></li>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>