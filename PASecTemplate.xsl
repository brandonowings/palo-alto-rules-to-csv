<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:csv="csv:csv">
<xsl:output method="text" encoding="utf-8"/>
<xsl:strip-space elements="*" />
  <xsl:template match="/security/rules/entry">
    <xsl:value-of select="normalize-space(@name)"/>,<xsl:value-of select="normalize-space(source)"/>,<xsl:value-of select="normalize-space(destination)"/>,<xsl:value-of select="normalize-space(from)"/>,<xsl:value-of select="normalize-space(to)"/>,<xsl:value-of select="normalize-space(source-user)"/>,<xsl:value-of select="normalize-space(application)"/>,<xsl:value-of select="normalize-space(service)"/>,<xsl:value-of select="normalize-space(action)"/>,<xsl:value-of select="normalize-space(disabled)"/>,<xsl:value-of select="normalize-space(profile-setting)"/>,<xsl:text>&#34;</xsl:text><xsl:value-of select="normalize-space(description)"/><xsl:text>&#34;</xsl:text>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>
</xsl:stylesheet>
