<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="/Binding">
		<html>
			<head>
				<link rel="stylesheet" type="text/css" href="styles/reset.css" media="screen" />
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
					<xsl:if test="@package">
						<xsl:value-of select="@package" /><span class="seperator">/</span>
					</xsl:if>
					<xsl:value-of select="@name" />
				</h1>
				<div class="description">
					<xsl:apply-templates select="Description" />
				</div>
				<xsl:apply-templates select="Example" />
				
				<h2>Attributes</h2>
				<xsl:choose>
					<xsl:when test="count(Attribute) = 0">
						<span class="message">No attributes defined</span>
					</xsl:when>
					<xsl:otherwise>
						<table id="attributes">
							<thead>
								<tr>
									<th>Name</th>
									<th>Required?</th>
									<th>Default value</th>
									<th>Description</th>
								</tr>
							</thead>
							<tbody>
								<xsl:apply-templates select="Attribute" />
							</tbody>
						</table>
					</xsl:otherwise>
				</xsl:choose>
				
				<h2>Events</h2>
				<xsl:choose>
					<xsl:when test="count(Events/*) = 0">
						<span class="message">No events defined</span>
					</xsl:when>
					<xsl:otherwise>
						<table id="events">
							<thead>
								<tr>
									<th>Event</th>
									<th>Description</th>
									<th>Attributes</th>
								</tr>
							</thead>
							<tbody>
								<xsl:apply-templates select="Events/*" />
							</tbody>
						</table>
					</xsl:otherwise>
				</xsl:choose>
				
				<h2>Children</h2>
				<xsl:choose>
					<xsl:when test="count(Children/*) = 0">
						<span class="message">No children defined</span>
					</xsl:when>
					<xsl:otherwise>
						<table id="children">
							<thead>
								<tr>
									<th>Name</th>
									<th>Required?</th>
									<th>Description</th>
								</tr>
							</thead>
							<tbody>
								<xsl:apply-templates select="Children/*" />
							</tbody>
						</table>
					</xsl:otherwise>
				</xsl:choose>
				
				<h2>Branches</h2>
				<xsl:choose>
					<xsl:when test="count(Branches/*) = 0">
						<span class="message">No branches defined</span>
					</xsl:when>
					<xsl:otherwise>
						<table id="children">
							<thead>
								<tr>
									<th>Name</th>
									<th>Description</th>
								</tr>
							</thead>
							<tbody>
								<xsl:apply-templates select="Branches/*" />
							</tbody>
						</table>
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="Branches/*">
		<tr>
			<td><xsl:value-of select="@name" /></td>
			<td><xsl:value-of select="@description" /></td>
		</tr>
	</xsl:template>
	
	<xsl:template match="Children/*">
		<tr>
			<td><a href="{@name}.html" name="{@name}" class="binding_tooltip"><xsl:value-of select="@name" /></a></td>
			<td>
				<xsl:choose>
					<xsl:when test="@required = true">Yes</xsl:when>
					<xsl:otherwise>No</xsl:otherwise>
				</xsl:choose>
			</td>
			<td><xsl:value-of select="@description" /></td>
		</tr>
	</xsl:template>
	
	<xsl:template match="Events/*">
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
	
	<xsl:template match="Events/*/Attribute">
		<li>
			<span><xsl:value-of select="@name" /></span>:
			<a name="{@type}" class="binding_tooltip" href="{@type}.html">
				<xsl:value-of select="@type" />
			</a>
			<span class="description"><xsl:value-of select="@description" /></span>
		</li>
	</xsl:template>
	
	<xsl:template match="Attribute">
		<tr>
			<td><xsl:value-of select="@name" /></td>

			<td>
				<xsl:choose>
					<xsl:when test="@required = true">Yes</xsl:when>
					<xsl:otherwise>No</xsl:otherwise>
				</xsl:choose>
			</td>
			<td><xsl:value-of select="@defaultValue" /></td>
			<td><xsl:value-of select="@description" /></td>
		</tr>
	</xsl:template>
	
	<xsl:template match="Description">
		<p>
			<xsl:value-of select="text()" />
		</p>
	</xsl:template>
	
	<xsl:template match="Example">
		<a href="#example" class="togglable_control">Expand example</a>
		<div id="example" class="togglable">
			<pre><xsl:value-of select="text()" /></pre>
		</div>
	</xsl:template>
</xsl:stylesheet>