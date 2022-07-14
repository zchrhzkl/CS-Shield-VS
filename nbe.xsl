<?xml version="1.0"?>
<!--
 (C) 2009 - 2011 Tenable Network Security, Inc.
 $Id: nbe.xsl,v 1.3 2011/01/19 17:56:27 renaud Exp $

 @ReadableName@ = "NBE export"
 @Extension@  = "nbe"
 @Nessus_v1@
!-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" standalone="yes" omit-xml-declaration="yes" />
<xsl:template match="/NessusClientData">timestamps|||scan_start|<xsl:value-of select="Report/StartTime[1]"/>|<xsl:for-each select="Report/ReportHost"><xsl:variable name="hostname"><xsl:value-of select="HostName"/></xsl:variable><xsl:variable name="hostColumn"><xsl:value-of select="concat(substring-before($hostname, '.'),'.',substring-before(substring-after($hostname, '.'), '.'),'.',substring-before(substring-after(substring-after($hostname, '.'), '.'), '.'))"/></xsl:variable>
timestamps||<xsl:value-of select="HostName"/>|host_start|<xsl:value-of select="startTime"/>|<xsl:for-each select="ReportItem[data='PORT']">
results|<xsl:value-of select="$hostColumn"/>|<xsl:value-of select="../HostName"/>|<xsl:value-of select="port"/>
</xsl:for-each>
<xsl:for-each select="ReportItem[data!='PORT']">
<xsl:if test="severity&lt;2">
results|<xsl:value-of select="$hostColumn"/>|<xsl:value-of select="../HostName"/>|<xsl:value-of select="port"/>|<xsl:value-of select="pluginID"/>|Security Note|<xsl:value-of select="data"/>
</xsl:if>
<xsl:if test="severity=2">
results|<xsl:value-of select="$hostColumn"/>|<xsl:value-of select="../HostName"/>|<xsl:value-of select="port"/>|<xsl:value-of select="pluginID"/>|Security Warning|<xsl:value-of select="data"/>
</xsl:if>
<xsl:if test="severity&gt;2">
results|<xsl:value-of select="$hostColumn"/>|<xsl:value-of select="../HostName"/>|<xsl:value-of select="port"/>|<xsl:value-of select="pluginID"/>|Security Hole|<xsl:value-of select="data"/>
</xsl:if>
</xsl:for-each>
timestamps||<xsl:value-of select="HostName"/>|host_end|<xsl:value-of select="stopTime"/>|
</xsl:for-each>timestamps|||scan_end|<xsl:value-of select="Report/StopTime[last()]"/>|
</xsl:template>
</xsl:stylesheet>
