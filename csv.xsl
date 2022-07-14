<?xml version="1.0" encoding="utf-8"?>
<!--
 (C) 2012, Tenable Network Security, Inc.

 2012/07/13: Note that file is deprecated as of version 3.0.23 of the Nessus Web Server
 (Feel free to use it as a template to create other types of CSV files)

 @ReadableName@ = "CSV"
 @Extension@  = "csv"
 @MinVersion@ = 5000
 @Hide@ = FALSE
 $Id: csv.xsl,v 1.4 2012/07/13 20:25:28 renaud Exp $
!-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" encoding="utf-8"/>

<xsl:template name="escape_quote_internal">
<xsl:param name="string" />
<xsl:choose>
<xsl:when test="contains($string, '&#x22;')">
  <xsl:call-template name="escape_quote"><xsl:with-param name="string"><xsl:value-of select="substring-before($string, '&#x22;')" /></xsl:with-param></xsl:call-template>""<xsl:call-template name="escape_quote"><xsl:with-param name="string"><xsl:value-of select="substring-after($string, '&#x22;')" /></xsl:with-param></xsl:call-template>
</xsl:when>
<xsl:when test="contains($string, '&#x0a;')">
  <xsl:call-template name="escape_quote"><xsl:with-param name="string"><xsl:value-of select="substring-before($string, '&#x0a;')" /></xsl:with-param></xsl:call-template><xsl:text>&#x0d;&#x0a;</xsl:text><xsl:call-template name="escape_quote"><xsl:with-param name="string"><xsl:value-of select="substring-after($string, '&#x0a;')" /></xsl:with-param></xsl:call-template>
</xsl:when>
<xsl:otherwise>
  <xsl:value-of select="$string" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>


<xsl:template name="escape_quote">
  <xsl:param name="string" />

  <xsl:choose>
    <xsl:when test="string-length($string) > 30000">
      <xsl:call-template name="escape_quote_internal"><xsl:with-param name="string"><xsl:value-of select="substring($string,1,30000)" />[...]</xsl:with-param></xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="escape_quote_internal"><xsl:with-param name="string"><xsl:value-of select="$string" /></xsl:with-param></xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template match="NessusClientData_v2">
  <xsl:apply-templates select="Report"/>
</xsl:template>

<xsl:template match="Report">
  <xsl:text>Plugin ID,CVE,CVSS,Risk,Host,Protocol,Port,Name,Synopsis,Description,Solution,Plugin Output</xsl:text>
  <xsl:text>&#x0d;&#x0a;</xsl:text>

  <xsl:apply-templates select="ReportHost"/>
</xsl:template>

<xsl:template match="ReportHost">
  <xsl:apply-templates select="ReportItem"/>
</xsl:template>

<xsl:template match="ReportItem">

  <xsl:variable name="cvelist">
    <xsl:choose>
      <xsl:when test="cve">
	<xsl:for-each select="cve">
	  <xsl:value-of select="."/>
	  <xsl:if test="position() != last()">#</xsl:if>
       </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>N/A</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:call-template name="GenerateRow">
    <xsl:with-param name="cve_val"><xsl:value-of select="$cvelist"/></xsl:with-param>
  </xsl:call-template> 

</xsl:template>

<xsl:template name="GenerateRow">
  <xsl:param name="cve_val" />

  <xsl:choose>

  <xsl:when test="contains($cve_val, '#')">
    <xsl:call-template name="GenerateRow"><xsl:with-param name="cve_val"><xsl:value-of select="substring-before($cve_val, '#')" /></xsl:with-param></xsl:call-template><xsl:call-template name="GenerateRow"><xsl:with-param name="cve_val"><xsl:value-of select="substring-after($cve_val, '#')" /></xsl:with-param></xsl:call-template>
  </xsl:when>
  <xsl:otherwise>

  <xsl:value-of select="@pluginID"/>

  <xsl:text>,</xsl:text>
  <xsl:value-of select="$cve_val"/>

  <xsl:text>,</xsl:text>
  <xsl:if test="cvss_base_score"><xsl:value-of select="cvss_base_score"/></xsl:if>

  <xsl:text>,</xsl:text>
  <xsl:if test="risk_factor"><xsl:value-of select="risk_factor"/></xsl:if>

  <xsl:text>,</xsl:text><xsl:value-of select="../@name"/>

  <xsl:text>,</xsl:text><xsl:value-of select="@protocol"/>

  <xsl:text>,</xsl:text><xsl:value-of select="@port"/>

  <xsl:text>,"</xsl:text><xsl:value-of select="@pluginName"/><xsl:text>"</xsl:text>

  <xsl:text>,</xsl:text><xsl:if test="synopsis">"<xsl:call-template name="escape_quote"><xsl:with-param name="string"><xsl:value-of select="synopsis" /></xsl:with-param></xsl:call-template>"</xsl:if>

  <xsl:text>,</xsl:text><xsl:if test="description">"<xsl:call-template name="escape_quote"><xsl:with-param name="string"><xsl:value-of select="description" /></xsl:with-param></xsl:call-template>"</xsl:if>

  <xsl:text>,</xsl:text><xsl:if test="solution">"<xsl:call-template name="escape_quote"><xsl:with-param name="string"><xsl:value-of select="solution" /></xsl:with-param></xsl:call-template>"</xsl:if>

  <xsl:text>,</xsl:text><xsl:if test="plugin_output">"<xsl:call-template name="escape_quote"><xsl:with-param name="string"><xsl:value-of select="plugin_output" /></xsl:with-param></xsl:call-template>"</xsl:if>

  <xsl:text>&#x0d;&#x0a;</xsl:text>

  </xsl:otherwise>
  </xsl:choose>

</xsl:template>

</xsl:stylesheet>
