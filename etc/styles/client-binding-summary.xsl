<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="/Binding">
		<div class="summary">
			<xsl:choose>
				<xsl:when test="count(Attribute) = 0">
					<span class="message">No attributes defined</span>
				</xsl:when>
				<xsl:otherwise>
					<ul>
						<xsl:apply-templates select="Attribute" />
					</ul>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:template>

	<xsl:template match="Attribute">
		<li>
			<xsl:value-of select="@name" />
		</li>
	</xsl:template>
	
</xsl:stylesheet>