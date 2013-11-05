<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="../utilities/master.xsl"/>
<xsl:include href="../utilities/date-time.xsl"/>

<xsl:template name="title-text">/home/adrian</xsl:template>

<xsl:template match="data">

<xsl:apply-templates select="page/entry"/>

</xsl:template>

<xsl:template match="page/entry">
	<div class="last article">
		<xsl:copy-of select="content/node()"/>
	</div>
</xsl:template>

</xsl:stylesheet>
