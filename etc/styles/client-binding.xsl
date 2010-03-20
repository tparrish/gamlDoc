<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:textile="java:uk.co.dubit.gaml.doc.TextileHandler">
	
	<xsl:template match="/Binding">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="../styles/reset.css" media="screen" />
				<link rel="stylesheet" type="text/css" href="../styles/screen.css" media="screen" />
				<link href="../styles/shCore.css" rel="stylesheet" type="text/css" />
				<link href="../styles/shThemeDefault.css" rel="stylesheet" type="text/css" />
				
				<script type="text/javascript" src="../scripts/jquery-1.3.2.min.js"></script>
				<script type="text/javascript" src="../scripts/jquery.qtip.1.0.0-rc3052631.min.js"></script>
				<script type="text/javascript" src="../scripts/application.js"></script>
				<script type="text/javascript" src="../scripts/shCore.js"></script>
				<script type="text/javascript" src="../scripts/brushes/shBrushXml.js"></script>
				<script type="text/javascript" src="../scripts/brushes/shBrushJScript.js"></script>
				<script type="text/javascript">
				     SyntaxHighlighter.all();
				</script>
				<title>GAMLDoc</title>
			</head>
			<body id="binding">
				<h1>
					<!--<xsl:if test="@package">
						<xsl:value-of select="@package" /><span class="seperator"> Package -</span>
					</xsl:if>-->
					<xsl:value-of select="@name" />
				</h1>
				<div class="description">
					<xsl:apply-templates select="Description" />
				</div>
				
				<xsl:if test="count(Attribute/*) > 0">
						<!-- <h2>Attributes</h2> -->
						<table id="attributes">
							<thead>
								<tr>
									<th width="180px">Attribute</th>
									<!--<th>Default value</th>-->
									<th>Description</th>
									<th width="180px">Required</th>
								</tr>
							</thead>
							<tbody>
								<xsl:apply-templates select="Attribute" />
							</tbody>
						</table>
				</xsl:if>
				
				<xsl:if test="count(Events/*) > 0">
					<!--<h2>Events</h2>-->
					<table id="events">
						<thead>
							<tr>
								<th width="180px">Event</th>
								<th>Description</th>
								<th width="180px">Attributes</th>
							</tr>
						</thead>
						<tbody>
							<xsl:apply-templates select="Events/*" />
						</tbody>
					</table>
				</xsl:if>
				
				<xsl:if test="count(Children/*) > 0">
					<!--<h2>Children</h2>-->
					<table id="children">
						<thead>
							<tr>
								<th width="180px">Child</th>
								<th>Description</th>
								<th width="180px">Required</th>
							</tr>
						</thead>
						<tbody>
							<xsl:apply-templates select="Children/*" />
						</tbody>
					</table>
				</xsl:if>
				

				<xsl:if test="count(Branches/*) > 0">
					<!--<h2>Branches</h2>-->
					<table id="children">
						<thead>
							<tr>
								<th width="180px">Branch</th>
								<th>Description</th>
								<th width="180px">Attributes</th>
							</tr>
						</thead>
						<tbody>
							<xsl:apply-templates select="Branches/*" />
						</tbody>
					</table>
				</xsl:if>
				
				<xsl:apply-templates select="Example" />
				
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="Children/*">
		<tr>
			<td><a href="{@name}.html" name="{@name}" class="binding_tooltip"><xsl:value-of select="@name" /></a></td>
			<td><xsl:value-of select="@description" /></td>
			<td>
				<xsl:choose>
					<xsl:when test="@required = 'true'">Yes</xsl:when>
					<xsl:otherwise>No</xsl:otherwise>
				</xsl:choose>
			</td>			
		</tr>
	</xsl:template>
	
	<xsl:template match="Events/*|Branches/*">
		<tr>
			<td><xsl:value-of select="@name" /></td>
			<td><xsl:value-of select="@description" /></td>
			<td>
				<xsl:if test="count(Attribute) > 0">
					<ul class="attributes">
						<xsl:apply-templates select="Attribute" />
					</ul>
				</xsl:if>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="Events/*/Attribute|Branches/*/Attribute">
		<xsl:if test="not(@nodoc)">
			<li>
				<span><xsl:value-of select="@name" /></span>:
				<span class="description"><xsl:value-of select="@description" /></span>
				<a name="{@type}" class="binding_tooltip" href="{@type}.html">
					<xsl:value-of select="@type" />
				</a>				
			</li>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="Attribute">
		<xsl:if test="not(@nodoc)">
			<tr>
				<td><xsl:value-of select="@name" /></td>
				<!--<td><xsl:value-of select="@defaultValue" /></td>-->
				<td><xsl:value-of select="@description" /></td>
				<td>
					<xsl:choose>
						<xsl:when test="@required = 'true'">Yes</xsl:when>
						<xsl:otherwise>No</xsl:otherwise>
					</xsl:choose>
				</td>				
			</tr>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="Description" xmlns:gaml="xalan://uk.co.dubit.gaml.doc.GamlExampleHandler">
		<p>
			<xsl:value-of select="gaml:parse_textile(text())" disable-output-escaping="yes" />
		</p>
	</xsl:template>
	
	<xsl:template match="Example" xmlns:gaml="xalan://uk.co.dubit.gaml.doc.GamlExampleHandler">
		<h2>Example</h2>
		<div class="example"><xsl:value-of select="gaml:escape_code(text())" disable-output-escaping="yes" /></div>
	</xsl:template>
	
</xsl:stylesheet>