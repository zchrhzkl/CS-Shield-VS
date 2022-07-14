<?xml version="1.0" encoding="utf-8"?>
<!--
 (C) 2017 Tenable, Inc.

 @ReadableName@ = "HTML Transformation"
 @Extension@  = "html"
 @MinVersion@ = 5000
 @Hide@ = true
 $Id$
!-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" indent="yes" encoding="utf-8"></xsl:output>

    <xsl:variable name="colorSev4">#91243E</xsl:variable>
    <xsl:variable name="colorSev3">#DD4B50</xsl:variable>
    <xsl:variable name="colorSev2">#F18C43</xsl:variable>
    <xsl:variable name="colorSev1">#F8C851</xsl:variable>
    <xsl:variable name="colorSev0">#67ACE1</xsl:variable>

    <xsl:variable name="colorComp0">#966807</xsl:variable>
    <xsl:variable name="colorComp1">#527421</xsl:variable>
    <xsl:variable name="colorComp3">#9f4909</xsl:variable>
    <xsl:variable name="colorComp4">#c2212e</xsl:variable>

    <xsl:template match="report">
        <html xmlns="http://www.w3.org/1999/xhtml" style="margin: 0;padding: 0;border: 0;font-size: 12px;font: inherit;vertical-align: baseline;-webkit-text-size-adjust: none;font-family: 'Open Sans', sans-serif;width: 100%; color: #333; background: #efefef;">
        <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
        <title><xsl:value-of select="@name" /></title>
        <style type="text/css" media="all">
            @import url("https://fonts.googleapis.com/css?family=Open+Sans:400,600")
        </style>
        </head>
        <xsl:variable name="bodyStyle">
            <xsl:choose>
                <xsl:when test="@toc = 'on'"></xsl:when>
                <xsl:when test="@showSections = 'true'"></xsl:when>
                <xsl:otherwise>email</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <body class="{$bodyStyle}" style="margin: 0;padding: 0;border: 0;font-size: 12px;vertical-align: baseline;-webkit-text-size-adjust: none;font-family: 'Open Sans', sans-serif;width: 100%;color: #333;background: #efefef;">
            <table cellpadding="0" cellspacing="0" border="0" width="100%" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                <tr style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                    <td align="center" valign="top" class="nopadding" style="vertical-align: top;margin: 0;padding: 0 !important;border: 0;font-size: 13px;-webkit-text-size-adjust: none;color: #263746;">
                        <table cellpadding="0" cellspacing="0" border="0" width="80%" bgcolor="#FFFFFF" class="container_16" style="margin: 0 auto;padding: 0 14px 14px 14px;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;background: #fff;border-top: #263746 solid 3px;box-shadow: 0 2px 10px rgba(0, 0, 0, .2);margin-bottom: 20px;border-radius: 0 0 3px 3px;">
                            <tr style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                                <td style="margin: 0;padding: 6px 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;">
                                    <xsl:if test="string-length(@header) != 0"><span class="classheader" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;"><h1 style="background: {@hf_color};margin: 0;padding: 0 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #fff;font-weight: 600;text-align: center;"><font color="#ffffff"><xsl:value-of select="@header"></xsl:value-of></font></h1></span></xsl:if>
                                    <xsl:call-template name="report_title"></xsl:call-template>
                                    <div id="reportContent" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;width: 100%;">
                                        <xsl:if test="@toc = 'on'">
                                            <xsl:call-template name="toc"></xsl:call-template>
                                        </xsl:if>
                                        <xsl:apply-templates select="chapter"></xsl:apply-templates>
                                    </div>
                                    <xsl:if test="string-length(@footer) != 0"><span class="classheader" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;"><h1 style="background: {@hf_color};margin: 0;padding: 0 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #fff;font-weight: 600;text-align: center;"><xsl:value-of select="@footer"></xsl:value-of></h1></span></xsl:if>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div id="copyright" style="margin: 0;padding: 6px 0 20px 0;border: 0;font-size: 12px;vertical-align: baseline;-webkit-text-size-adjust: none;display: block;width: 100%;text-align: center;color: #999;">
                &#169; <xsl:value-of select="@year" /> Tenable&#8482;, Inc. All rights reserved.
            </div>
        </body>
        </html>
    </xsl:template>

    <xsl:template name="report_title">
        <table cellpadding="0" cellspacing="0" border="0" width="100%" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
            <tr style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                <td class="nopadding" style="margin: 0;padding: 0 !important;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;"><h1 class="classtitle" style="margin: 0 0 15px 0;padding: 15px 0 10px 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;border-bottom: 1px dotted #ccc;"><img src="{@logo}" width="200" height="55" border="0" alt="Nessus Report" style="display: block;margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;max-width: 200px;max-height: 55px;" /></h1></td>
            </tr>
            <tr style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                <td class="nopadding" style="margin: 0;padding: 0 !important;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;"><h2 class="classtitle" style="margin: 0;padding: 0;border: 0;font-size: 22px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;font-weight: 400;"><xsl:value-of select="@name"></xsl:value-of></h2></td>
            </tr>
            <tr style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                <td class="nopadding" style="margin: 0;padding: 0 !important;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;"><h2 class="date" style="margin: 0;padding: 0;border: 0;font-size: 14px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #ccc;font-weight: 400;"><xsl:value-of select="@date"></xsl:value-of></h2></td>
            </tr>
            <tr style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                <td class="reportpadding" style="margin: 0;padding: 15px 0 0 0 !important;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;">
                    <div class="reportinfo" style="margin: 0 0 5px 0;padding: 0 0 15px 0;border: 0;font-size: 16px;vertical-align: baseline;-webkit-text-size-adjust: none;display: block;width: 100%;font-weight: 400;border-bottom: 1px dotted #ccc;">
                        <xsl:apply-templates select="report_info"></xsl:apply-templates>
                    </div>
                </td>
            </tr>
            <xsl:if test="@type = 'HomeFeed'">
                <tr style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                    <td style="margin: 0;padding: 6px 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;">
                        <h2 class="classtitle" style="margin: 0;padding: 0;border: 0;font-size: 22px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #00a5b5;font-weight: 400;"><xsl:text>Nessus Essentials: Commercial use of the report is prohibited</xsl:text></h2>
                        <h3 class="classtitle" style="margin: 0;padding: 0 10px;border: 0;font-size: 16px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #69737b;">
                            <xsl:text>Any time Nessus is used in a commercial environment you MUST maintain an active subscription to the Nessus Feed in order to be compliant with our license agreement.</xsl:text>
                            <a href="http://www.tenable.com/products/nessus" target="_blank" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;color: #004a97;"><xsl:text>http://www.tenable.com/products/nessus</xsl:text></a>
                        </h3>
                    </td>
                </tr>
            </xsl:if>
        </table>
    </xsl:template>

    <xsl:template name="toc">
        <span class="classtoc" style="margin: 15px 0 0 0;padding: 15px 0;border: 0;font-size: 18px;vertical-align: baseline;-webkit-text-size-adjust: none;display: block;color: #777779;">
            <xsl:text>Table Of Contents</xsl:text>
        </span>

        <table style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
            <xsl:for-each select="chapter">
                <tr style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                    <td style="margin: 0;padding: 6px 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;">
                        <span class="classtoc1" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;"><a href="#{generate-id(.)}" style="margin: 0;padding: 0;border: 0;font-size: 16px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #004a97;"><xsl:value-of select="@name"></xsl:value-of></a></span>
                    </td>
                </tr>
                <tr style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                    <td style="margin: 0;padding: 6px 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;">
                        <table style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                            <xsl:for-each select="section">
                                <xsl:variable name="sev">
                                    <xsl:choose>
                                        <xsl:when test="@severity = '0'">classcell0</xsl:when>
                                        <xsl:when test="@severity = '1'">classcell1</xsl:when>
                                        <xsl:when test="@severity = '2'">classcell2</xsl:when>
                                        <xsl:when test="@severity = '3'">classcell3</xsl:when>
                                        <xsl:when test="@severity = '4'">classcell4</xsl:when>
                                        <xsl:otherwise></xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:variable name="sevBGColor">
                                    <xsl:choose>
                                        <xsl:when test="@severity = '0'"><xsl:value-of select="$colorSev0" /></xsl:when>
                                        <xsl:when test="@severity = '1'"><xsl:value-of select="$colorSev1" /></xsl:when>
                                        <xsl:when test="@severity = '2'"><xsl:value-of select="$colorSev2" /></xsl:when>
                                        <xsl:when test="@severity = '3'"><xsl:value-of select="$colorSev3" /></xsl:when>
                                        <xsl:when test="@severity = '4'"><xsl:value-of select="$colorSev4" /></xsl:when>
                                        <xsl:otherwise></xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <tr style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                                    <td width="5%" style="margin: 0;padding: 6px 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;">
                                        <table style="table-layout: fixed;margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;" width="10px" height="10px">
                                            <tr style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                                                <td class="nopadding {$sev}" bgcolor="{$sevBGColor}" style="margin: 0;padding: 0 !important;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;"></td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td width="95%" style="margin: 0;padding: 6px 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;">
                                        <a href="#{generate-id(.)}" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;color: #004a97;">
                                            <xsl:value-of select="@name"></xsl:value-of>
                                        </a>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>

    <xsl:template match="chapter">
        <xsl:if test="not(@title)">
            <h1 class="classchapter" id="{generate-id(.)}" style="margin: 10px 0 0 0;padding: 6px 10px;border: 0;font-size: 16px;vertical-align: baseline;-webkit-text-size-adjust: none;background: #425363;color: #fff;font-weight: 600;border-radius: 3px 3px 0 0;"><xsl:value-of select="@name"></xsl:value-of></h1>
            <xsl:if test="not(@showToggle) or (@showToggle and @showToggle = true)">
                <table style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                    <tr width="100%" onclick="ceall(0)" onmouseover="this.style.cursor='pointer'" title="Collapse" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                        <td align="left" width="100%" style="margin: 0;padding: 6px 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;">[-] Collapse All</td>
                    </tr>
                    <tr width="100%" onclick="ceall(1)" onmouseover="this.style.cursor='pointer'" title="Expand" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                        <td align="left" width="100%" style="margin: 0;padding: 6px 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;">[+] Expand All</td>
                    </tr>
                </table>
            </xsl:if>
        </xsl:if>
        <xsl:apply-templates select="section"></xsl:apply-templates>
    </xsl:template>

    <xsl:template match="section">
        <xsl:variable name="sev">
            <xsl:choose>
                <xsl:when test="@bgcolor = 'off'">classsection</xsl:when>
                <xsl:when test="@severity = '0'">classsection0</xsl:when>
                <xsl:when test="@severity = '1'">classsection1</xsl:when>
                <xsl:when test="@severity = '2'">classsection2</xsl:when>
                <xsl:when test="@severity = '3'">classsection3</xsl:when>
                <xsl:when test="@severity = '4'">classsection4</xsl:when>
                <xsl:otherwise>classsection</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="BGColor">
            <xsl:choose>
                <xsl:when test="@severity = '0'">background-color: <xsl:value-of select="$colorSev0" />;</xsl:when>
                <xsl:when test="@severity = '1'">background-color: <xsl:value-of select="$colorSev1" />;</xsl:when>
                <xsl:when test="@severity = '2'">background-color: <xsl:value-of select="$colorSev2" />;</xsl:when>
                <xsl:when test="@severity = '3'">background-color: <xsl:value-of select="$colorSev3" />;</xsl:when>
                <xsl:when test="@severity = '4'">background-color: <xsl:value-of select="$colorSev4" />;</xsl:when>
                <xsl:when test="@compliance_level = '0'">background-color: <xsl:value-of select="$colorComp0" />;</xsl:when>
                <xsl:when test="@compliance_level = '1'">background-color: <xsl:value-of select="$colorComp1" />;</xsl:when>
                <xsl:when test="@compliance_level = '3'">background-color: <xsl:value-of select="$colorComp3" />;</xsl:when>
                <xsl:when test="@compliance_level = '4'">background-color: <xsl:value-of select="$colorComp4" />;</xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <h2 class="{$sev}" id="{generate-id(.)}" style="{$BGColor} display: block;border-radius: 3px 3px 0 0;background: #263746;color: #fff;font-weight: 600;font-size: 13px;padding: 6px 10px;margin-bottom: 0px;margin-top: 10px;border: 0;vertical-align: baseline;-webkit-text-size-adjust: none;">
            <xsl:value-of select="@name"></xsl:value-of>
            <xsl:if test="@count">
                <span style="float: right;margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                    <span class="sub label" style="margin: 0;padding: 0;border: 0;font-size: 12px;vertical-align: baseline;-webkit-text-size-adjust: none;margin-left: 8px;margin-right: 2px;"><xsl:value-of select="@count_label"></xsl:value-of></span><span class="sub text" style="margin: 0;padding: 0;border: 0;font-size: 10px;vertical-align: baseline;-webkit-text-size-adjust: none;margin-left: 2px;margin-right: 2px;"><xsl:value-of select="@count"></xsl:value-of></span>
                </span>
            </xsl:if>
        </h2>
        <xsl:apply-templates select="table"></xsl:apply-templates>
        <xsl:apply-templates select="h1"></xsl:apply-templates>
        <xsl:apply-templates select="subsection"></xsl:apply-templates>
    </xsl:template>

    <xsl:template match="subsection">
        <xsl:variable name="sev">
            <xsl:choose>
                <xsl:when test="@severity = '0'">classsection0</xsl:when>
                <xsl:when test="@severity = '1'">classsection1</xsl:when>
                <xsl:when test="@severity = '2'">classsection2</xsl:when>
                <xsl:when test="@severity = '3'">classsection3</xsl:when>
                <xsl:when test="@severity = '4'">classsection4</xsl:when>
                <xsl:otherwise>classsubsection</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="sevBGColor">
            <xsl:choose>
                <xsl:when test="@severity = '0'">background-color: <xsl:value-of select="$colorSev0" />;</xsl:when>
                <xsl:when test="@severity = '1'">background-color: <xsl:value-of select="$colorSev1" />;</xsl:when>
                <xsl:when test="@severity = '2'">background-color: <xsl:value-of select="$colorSev2" />;</xsl:when>
                <xsl:when test="@severity = '3'">background-color: <xsl:value-of select="$colorSev3" />;</xsl:when>
                <xsl:when test="@severity = '4'">background-color: <xsl:value-of select="$colorSev4" />;</xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <h2 class="{$sev} {@id}" style="{$sevBGColor} margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
            <xsl:value-of select="@name"></xsl:value-of>
            <xsl:if test="@count">
                <span style="float: right;margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                    <span class="sub label" style="margin: 0;padding: 0;border: 0;font-size: 12px;vertical-align: baseline;-webkit-text-size-adjust: none;margin-left: 8px;margin-right: 2px;"><xsl:value-of select="@count_label"></xsl:value-of></span><span class="sub text" style="margin: 0;padding: 0;border: 0;font-size: 10px;vertical-align: baseline;-webkit-text-size-adjust: none;margin-left: 2px;margin-right: 2px;"><xsl:value-of select="@count"></xsl:value-of></span>
                </span>
            </xsl:if>
        </h2>

        <xsl:apply-templates select="h0"></xsl:apply-templates>
        <xsl:apply-templates select="table"></xsl:apply-templates>
        <xsl:apply-templates select="h1"></xsl:apply-templates>
    </xsl:template>

    <xsl:template match="h0">
        <xsl:variable name="sev">
            <xsl:choose>
                <xsl:when test="@severity = '0'">classcell0</xsl:when>
                <xsl:when test="@severity = '1'">classcell1</xsl:when>
                <xsl:when test="@severity = '2'">classcell2</xsl:when>
                <xsl:when test="@severity = '3'">classcell3</xsl:when>
                <xsl:when test="@severity = '4'">classcell4</xsl:when>
                <xsl:otherwise>classcell</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="sevBGColor">
            <xsl:choose>
                <xsl:when test="@severity = '0'"><xsl:value-of select="$colorSev0" /></xsl:when>
                <xsl:when test="@severity = '1'"><xsl:value-of select="$colorSev1" /></xsl:when>
                <xsl:when test="@severity = '2'"><xsl:value-of select="$colorSev2" /></xsl:when>
                <xsl:when test="@severity = '3'"><xsl:value-of select="$colorSev3" /></xsl:when>
                <xsl:when test="@severity = '4'"><xsl:value-of select="$colorSev4" /></xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="id"><xsl:text>btag-</xsl:text><xsl:value-of select="../../../@name"></xsl:value-of>-<xsl:value-of select="../@name"></xsl:value-of>-<xsl:value-of select="substring-before(@name,'-')"></xsl:value-of></xsl:variable>

        <span class="classh1_grey" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
            <h2 style="margin: 0;padding: 0 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;background: #eaeaea;color: #263746;margin-top: 0px;margin-bottom: 2px;">
                <span class="classsection_sub" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                    <table width="100%" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                        <tr width="100%" onclick="toggle('{$id}')" onmouseover="this.style.cursor='pointer'" title="Collapse/Expand" style="margin: 0;padding: 0 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;">
                            <td width="5%" height="50%" style="margin: 0;padding: 6px 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;">
                                <table style="table-layout: fixed;margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;" width="30px" height="15px">
                                    <tr width="100%" style="margin: 0;padding: 0 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;">
                                        <td width="100%" class="{$sev}" bgcolor="{$sevBGColor}" style="margin: 0;padding: 6px 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;"></td>
                                    </tr>
                                </table>
                            </td>
                            <td align="left" width="85%" style="margin: 0;padding: 6px 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;"><xsl:value-of select="@name"></xsl:value-of></td>
                            <td align="right" width="10%" style="margin: 0;padding: 6px 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;"><xsl:text>[-/+]</xsl:text></td>
                        </tr>
                    </table>
                </span>
            </h2>
        </span>
        <div id="{$id}" style="display: none;margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
            <xsl:apply-templates select="h1"></xsl:apply-templates>
        </div>
    </xsl:template>

    <xsl:template match="h1">
        <xsl:variable name="sev">
            <xsl:choose>
                <xsl:when test="@severity = '0'">classsection0</xsl:when>
                <xsl:when test="@severity = '1'">classsection1</xsl:when>
                <xsl:when test="@severity = '2'">classsection2</xsl:when>
                <xsl:when test="@severity = '3'">classsection3</xsl:when>
                <xsl:when test="@severity = '4'">classsection4</xsl:when>
                <xsl:when test="@severity = '99'">classh1_grey</xsl:when>
                <xsl:otherwise>classh1</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="calcStyle">
            <xsl:choose>
                <xsl:when test="@severity = '0'">background-color: <xsl:value-of select="$colorSev0" />; padding: 0;</xsl:when>
                <xsl:when test="@severity = '1'">background-color: <xsl:value-of select="$colorSev1" />; padding: 0;</xsl:when>
                <xsl:when test="@severity = '2'">background-color: <xsl:value-of select="$colorSev2" />; padding: 0;</xsl:when>
                <xsl:when test="@severity = '3'">background-color: <xsl:value-of select="$colorSev3" />; padding: 0;</xsl:when>
                <xsl:when test="@severity = '4'">background-color: <xsl:value-of select="$colorSev4" />; padding: 0;</xsl:when>
                <xsl:otherwise>background: #efefef; padding: 6px 10px;</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <h2 class="{$sev} {@id}" style="{$calcStyle} vertical-align: middle;margin: 0;border: 0;font-size: 100%;-webkit-text-size-adjust: none;font-weight: 600;">
            <xsl:text disable-output-escaping="yes">&lt;!--[if mso]&gt;</xsl:text>
                <img src="cid:#" width="1" height="25" border="0" style="display: block;float: left;margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;" /> &#160;
            <xsl:text disable-output-escaping="yes">&lt;![endif]]]--&gt;</xsl:text>

            <xsl:if test="@id = 'tips' or @id = 'errors'">
                <img src="{@img}" width="20" height="20" border="0" style="display: block;float: left;margin: -2px 10px 0 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;" />
            </xsl:if>
            <xsl:value-of select="@name"></xsl:value-of>
            <xsl:if test="@started_at or @completed_at">
                <span style="float: right;margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                    </span></xsl:if><xsl:if test="@started_at">
                        <span class="sub label" style="margin: 0;padding: 0;border: 0;font-size: 12px;vertical-align: baseline;-webkit-text-size-adjust: none;margin-left: 8px;margin-right: 2px;">Scan Start:</span><span class="sub text" style="margin: 0;padding: 0;border: 0;font-size: 10px;vertical-align: baseline;-webkit-text-size-adjust: none;margin-left: 2px;margin-right: 2px;"><xsl:value-of select="@started_at"></xsl:value-of></span>
                    </xsl:if>
                    <xsl:if test="@completed_at">
                        <span class="sub label" style="margin: 0;padding: 0;border: 0;font-size: 12px;vertical-align: baseline;-webkit-text-size-adjust: none;margin-left: 8px;margin-right: 2px;">Scan End:</span><span class="sub text" style="margin: 0;padding: 0;border: 0;font-size: 10px;vertical-align: baseline;-webkit-text-size-adjust: none;margin-left: 2px;margin-right: 2px;"><xsl:value-of select="@completed_at"></xsl:value-of></span>
                    </xsl:if>


        </h2>

        <xsl:apply-templates select="subsection"></xsl:apply-templates>
        <xsl:apply-templates select="h2"></xsl:apply-templates>
        <xsl:apply-templates select="text"></xsl:apply-templates>
        <xsl:apply-templates select="table"></xsl:apply-templates>
        <xsl:apply-templates select="h0"></xsl:apply-templates>
        <br /><xsl:text>&#xA;</xsl:text>
    </xsl:template>

    <xsl:template match="h1[@id='remediations']/table">
        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
            <xsl:apply-templates select="row"></xsl:apply-templates>
        </table>
    </xsl:template>

    <xsl:template match="h1[@id='hosts']/table">
        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
            <xsl:apply-templates select="row"></xsl:apply-templates>
        </table>
    </xsl:template>

    <xsl:template match="h1[@id='tips']/table">
        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
            <xsl:apply-templates select="row"></xsl:apply-templates>
        </table>
    </xsl:template>

    <xsl:template match="h1[@id='plugins']/table">
        <table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
            <xsl:apply-templates select="row"></xsl:apply-templates>
        </table>
    </xsl:template>

    <xsl:template match="table">
        <xsl:variable name="cls">
            <xsl:choose>
                <xsl:when test="@tableType = 'summaryTable'">summaryTable</xsl:when>
                <xsl:when test="@tableType = 'multiRowSummaryTable'">summaryTable multiRowSummaryTable</xsl:when>
            </xsl:choose>
        </xsl:variable>
        <table class="{$cls}" width="100%" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
            <xsl:apply-templates select="row"></xsl:apply-templates>
        </table>
    </xsl:template>

    <xsl:template match="h1[@id='remediations']/text">
        <table cellpadding="0" cellspacing="0" border="0" width="100%" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
            <tr style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
                <td style="padding: 10px 0 10px 10px !important;margin: 0 0 5px 0;font-weight: 600;font-size: 13px;border-bottom: 1px dotted #ddd;border: 0;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;">
                    <xsl:value-of select="."></xsl:value-of>
                </td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="h1[@id='remediations']/table/row[@class='number']">
        <xsl:variable name="ledger">
            <xsl:choose>
                <xsl:when test="position() mod 2 = 0">#f8f8f8</xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <tr bgcolor="{$ledger}" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
            <xsl:apply-templates select="cell"></xsl:apply-templates>
        </tr>
    </xsl:template>

    <xsl:template match="h1[@id='hosts']/table/row">
        <xsl:variable name="ledger">
            <xsl:choose>
                <xsl:when test="position() mod 2 = 0">#f8f8f8</xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <tr bgcolor="{$ledger}" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
            <xsl:apply-templates select="cell"></xsl:apply-templates>
        </tr>
    </xsl:template>

    <xsl:template match="h1[@id='tips']/table/row">
        <xsl:variable name="ledger">
            <xsl:choose>
                <xsl:when test="position() mod 2 = 0">#f8f8f8</xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <tr bgcolor="{$ledger}" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
            <xsl:apply-templates select="cell"></xsl:apply-templates>
        </tr>
    </xsl:template>

    <xsl:template match="h1[@id='plugins']/table/row">
        <xsl:variable name="ledger">
            <xsl:choose>
                <xsl:when test="position() mod 2 = 0">#f8f8f8</xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <tr bgcolor="{$ledger}" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
            <xsl:apply-templates select="cell"></xsl:apply-templates>
        </tr>
    </xsl:template>

    <xsl:template match="h1[@id='remediations']/table/row/cell">
        <td width="{@width}" valign="top" style="padding: 10px 10px !important;border-bottom: 1px dotted #ddd;margin: 0;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;">
            <xsl:apply-templates select="text"></xsl:apply-templates>
        </td>
    </xsl:template>

    <xsl:template match="h1[@id='hosts']/table/row/cell">
        <td width="{@width}" valign="top" style="padding: 6px 10px !important;border-bottom: 1px dotted #ddd;margin: 0;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;">
            <xsl:apply-templates select="pre"></xsl:apply-templates>
            <xsl:apply-templates select="text"></xsl:apply-templates>
            <xsl:apply-templates select="link"></xsl:apply-templates>
        </td>
    </xsl:template>

    <xsl:template match="h1[@id='plugins']/table/row/cell">
        <xsl:variable name="sev">
            <xsl:choose>
                <xsl:when test="@severity = '0'">classcell0</xsl:when>
                <xsl:when test="@severity = '1'">classcell1</xsl:when>
                <xsl:when test="@severity = '2'">classcell2</xsl:when>
                <xsl:when test="@severity = '3'">classcell3</xsl:when>
                <xsl:when test="@severity = '4'">classcell4</xsl:when>
                <xsl:otherwise>classcell</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="sevBGColor">
            <xsl:choose>
                <xsl:when test="@severity = '0'"><xsl:value-of select="$colorSev0" /></xsl:when>
                <xsl:when test="@severity = '1'"><xsl:value-of select="$colorSev1" /></xsl:when>
                <xsl:when test="@severity = '2'"><xsl:value-of select="$colorSev2" /></xsl:when>
                <xsl:when test="@severity = '3'"><xsl:value-of select="$colorSev3" /></xsl:when>
                <xsl:when test="@severity = '4'"><xsl:value-of select="$colorSev4" /></xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <td width="{@width}" valign="top" class="{$sev}" bgcolor="{$sevBGColor}" style="padding: 6px 10px !important;border-bottom: 1px dotted #ddd;margin: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;">
            <xsl:apply-templates select="pre"></xsl:apply-templates>
            <xsl:apply-templates select="text"></xsl:apply-templates>
            <xsl:apply-templates select="link"></xsl:apply-templates>
        </td>
    </xsl:template>

    <xsl:template match="row">
        <tr style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;">
            <xsl:apply-templates select="cell"></xsl:apply-templates>
        </tr>
    </xsl:template>

    <xsl:template match="h1[@id='tips']/table/row/cell">
        <td width="{@width}" valign="top" style="padding: 6px 10px !important;border-bottom: 1px dotted #ddd;margin: 0;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746;">
            <xsl:choose>
                <xsl:when test="@severity">
                    <xsl:apply-templates select="text"></xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="tip"></xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
        </td>
    </xsl:template>

    <xsl:template match="cell">
        <xsl:variable name="sev">
            <xsl:choose>
                <xsl:when test="@severity = '0'">classcell0</xsl:when>
                <xsl:when test="@severity = '1'">classcell1</xsl:when>
                <xsl:when test="@severity = '2'">classcell2</xsl:when>
                <xsl:when test="@severity = '3'">classcell3</xsl:when>
                <xsl:when test="@severity = '4'">classcell4</xsl:when>
                <xsl:otherwise>classcell</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="sevBGColor">
            <xsl:choose>
                <xsl:when test="@severity = '0'"><xsl:value-of select="$colorSev0" /></xsl:when>
                <xsl:when test="@severity = '1'"><xsl:value-of select="$colorSev1" /></xsl:when>
                <xsl:when test="@severity = '2'"><xsl:value-of select="$colorSev2" /></xsl:when>
                <xsl:when test="@severity = '3'"><xsl:value-of select="$colorSev3" /></xsl:when>
                <xsl:when test="@severity = '4'"><xsl:value-of select="$colorSev4" /></xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="cellAlign">
            <xsl:choose>
                <xsl:when test="@align = 'left'">left</xsl:when>
                <xsl:when test="@align = 'right'">right</xsl:when>
                <xsl:when test="@align = 'center'">center</xsl:when>
                <xsl:otherwise>left</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="noterow">
            <xsl:choose>
                <xsl:when test="@note-row = 'true'">border-left-style: hidden; border-bottom-style: hidden; border-right-style: hidden;</xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="colspan">
            <xsl:choose>
                <xsl:when test="@col-span"><xsl:value-of select="@col-span" /></xsl:when>
                <xsl:otherwise>1</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <td width="{@width}" valign="top" align="{$cellAlign}" class="{$sev}" bgcolor="{$sevBGColor}" style="margin: 0;padding: 6px 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;color: #263746; {$noterow}" colspan="{$colspan}">
            <xsl:apply-templates select="pre"></xsl:apply-templates>
            <xsl:apply-templates select="text"></xsl:apply-templates>
            <xsl:apply-templates select="link"></xsl:apply-templates>
        </td>
    </xsl:template>

    <xsl:template match="h2">
        <xsl:variable name="color">
            <xsl:choose>
                <xsl:when test="@color"><xsl:value-of select="@color"></xsl:value-of></xsl:when>
                <xsl:otherwise>#263645</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <h2 class="classh2" style="color: {$color};margin: 0;padding: 6px 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;background: #f8f8f8;font-weight: 600;"><xsl:value-of select="@name"></xsl:value-of></h2>

        <xsl:apply-templates select="pre"></xsl:apply-templates>
    </xsl:template>

    <xsl:template match="pre">
        <span class="classpre" style="margin: 0;padding: 10px;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;display: block;font-family: Courier New, Courier, monospace;color: #000;">
            <xsl:apply-templates select="br"></xsl:apply-templates>
        </span>
    </xsl:template>

    <xsl:template match="br">
        <xsl:value-of select="."></xsl:value-of>
        <xsl:if test="not(@last)">
            <br />
        </xsl:if>
    </xsl:template>

    <xsl:template match="link">
        <xsl:text> </xsl:text><a href="{@href}" target="_blank" style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;color: #004a97;"><xsl:value-of select="."></xsl:value-of></a>
    </xsl:template>

    <xsl:template match="text">
        <xsl:variable name="color">
            <xsl:choose>
                <xsl:when test="@color"><xsl:value-of select="@color"></xsl:value-of></xsl:when>
                <xsl:otherwise>#263645</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="weight">
            <xsl:choose>
                <xsl:when test="@type = 'bold'">font-weight: 600 !important;</xsl:when>
                <xsl:when test="@type = 'italic'">font-weight: 400 !important; font-family: Open Sans Italic !important</xsl:when>
                <xsl:otherwise>font-weight: 400;</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <span class="classtext" style="color: {$color};{$weight};margin: 0;padding: 0;border: 0;font-size: 13px;vertical-align: baseline;-webkit-text-size-adjust: none;line-height: 18px;">
            <xsl:choose>
                <xsl:when test="@br">
                    <xsl:apply-templates select="br"></xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."></xsl:value-of>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>

    <xsl:template match="copyright/text">
        <xsl:choose>
            <xsl:when test="@br">
                <xsl:value-of select="."></xsl:value-of><br />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."></xsl:value-of>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="report_info/text">
        <xsl:choose>
            <xsl:when test="@type = 'bold'">
                <b style="margin: 0;padding: 0;border: 0;font-size: 100%;vertical-align: baseline;-webkit-text-size-adjust: none;"><xsl:value-of select="."></xsl:value-of></b>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."></xsl:value-of>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
