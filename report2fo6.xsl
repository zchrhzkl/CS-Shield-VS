<?xml version="1.0" encoding="utf-8"?>
<!--
    (C) 2017, Tenable, Inc.

    @ReadableName@ = "FO Transformation"
    @Extension@  = "html"
    @MinVersion@ = 5000
    @Hide@ = true
    $Id$
!-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:svg="http://www.w3.org/2000/svg">
    <xsl:output method="xml" indent="yes" encoding="utf-8" />

    <xsl:template match="report">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="page" page-height="27.94cm" page-width="21.59cm" margin="2cm">
                    <fo:region-body region-name="body" />
                    <fo:region-before region-name="header" />
                    <fo:region-after region-name="footer" />
                </fo:simple-page-master>
            </fo:layout-master-set>

            <xsl:call-template name="bookmark" />
            <xsl:call-template name="report_title" />
            <xsl:call-template name="toc" />

            <xsl:apply-templates select="chapter" />
        </fo:root>
    </xsl:template>

    <xsl:template name="bookmark">
        <fo:bookmark-tree>
            <fo:bookmark internal-destination="table_of_content">
                <fo:bookmark-title font-size="30px" font-family="open_sans_regular, Helvetica, Arial, sans-serif" font-weight="400" color="#333333">Table Of Contents</fo:bookmark-title>
            </fo:bookmark>

            <xsl:for-each select="chapter">
                <fo:bookmark internal-destination="{generate-id(.)}">
                    <fo:bookmark-title font-family="open_sans_bold" font-weight="600">
                        <xsl:value-of select="@name" />
                    </fo:bookmark-title>

                    <xsl:for-each select="section">
                        <fo:bookmark internal-destination="{generate-id(.)}">
                            <fo:bookmark-title font-family="open_sans_bold" font-weight="600">
                                <xsl:value-of select="@name" />
                            </fo:bookmark-title>
                        </fo:bookmark>
                    </xsl:for-each>
                </fo:bookmark>
            </xsl:for-each>
        </fo:bookmark-tree>
    </xsl:template>

    <xsl:template name="report_title">
        <xsl:variable name="logo">
            <xsl:choose>
                <xsl:when test="@logo"><xsl:value-of select="@logo" /></xsl:when>
            </xsl:choose>
        </xsl:variable>

        <fo:page-sequence master-reference="page">
            <xsl:call-template name="add_header">
                <xsl:with-param name="acas_text"><xsl:value-of select="@acas_text"/></xsl:with-param>
                <xsl:with-param name="acas_color"><xsl:value-of select="@acas_color"/></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="add_footer">
                <xsl:with-param name="acas_text"><xsl:value-of select="@acas_text"/></xsl:with-param>
                <xsl:with-param name="acas_color"><xsl:value-of select="@acas_color"/></xsl:with-param>
            </xsl:call-template>
            <fo:flow flow-name="body">
                <xsl:choose>
                    <xsl:when test="@licenseType = 'home'">
                        <fo:block>
                            <fo:block-container position="fixed" left="-50pt" top="-50pt" width="100%" height="100%">
                                <fo:block>
                                    <fo:instream-foreign-object>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="680" height="920" style="pointer-events: none;">
                                            <text font-family="open_sans_bold" font-weight="600" font-size="55pt" style="fill:grey;opacity:0.1;" x="-10" y="300" width="680" text-anchor="middle" transform="rotate(-54, 340, 15)">Nessus Essentials</text>
                                        </svg>
                                    </fo:instream-foreign-object>
                                </fo:block>
                            </fo:block-container>
                        </fo:block>
                    </xsl:when>
                    <xsl:when test="@licenseEval = 'true'">
                        <fo:block>
                            <fo:block-container position="fixed" left="-50pt" top="-50pt" width="100%" height="100%">
                                <fo:block>
                                    <fo:instream-foreign-object>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="680" height="920" style="pointer-events: none;">
                                            <text font-family="open_sans_bold" font-weight="600" font-size="65pt" style="fill:grey;opacity:0.1;" x="-10" y="300" width="680" text-anchor="middle" transform="rotate(-54, 340, 15)">For Trial Use Only</text>
                                        </svg>
                                    </fo:instream-foreign-object>
                                </fo:block>
                            </fo:block-container>
                        </fo:block>
                    </xsl:when>
                </xsl:choose>
                <fo:block-container height="50%">
                    <xsl:if test="@logo">
                        <fo:block text-align="center" padding-top="25px">
                            <fo:external-graphic content-width="scale-to-fit" content-height="300px" width="300px" scaling="uniform" src="url('{$logo}')" />
                        </fo:block>
                    </xsl:if>
                </fo:block-container>

                <fo:block-container height="50%">
                    <fo:block text-align-last="left" font-size="22px" font-family="open_sans_bold, Helvetica, Arial, sans-serif" font-weight="600" color="#333333" space-after="5px">
                        <xsl:value-of select="@name" />
                    </fo:block>

                    <xsl:if test="@message != ''">
                        <fo:block text-align-last="left" font-size="16px" font-family="open_sans_regular, Helvetica, Arial, sans-serif" color="#333333" space-after="5px">
                            <xsl:value-of select="@message" />
                        </fo:block>
                    </xsl:if>

                    <fo:block text-align-last="justify" font-size="8px" font-family="open_sans_regular, Helvetica, Arial, sans-serif" font-weight="400" color="#999999" space-after="5px" padding-top="5px" padding-bottom="5px" border-bottom-color="#999999" border-bottom-width="thin" border-bottom-style="dotted" border-top-color="#999999" border-top-width="thin" border-top-style="dotted">
                        Report generated by Nessus&#8482;
                        <fo:leader leader-pattern="space" />
                        <xsl:value-of select="@date" />
                    </fo:block>
                </fo:block-container>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

    <xsl:template name="toc">
        <fo:page-sequence master-reference="page" id="table_of_content">
            <xsl:call-template name="add_header">
                <xsl:with-param name="acas_text"><xsl:value-of select="@acas_text"/></xsl:with-param>
                <xsl:with-param name="acas_color"><xsl:value-of select="@acas_color"/></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="add_footer">
                <xsl:with-param name="acas_text"><xsl:value-of select="@acas_text"/></xsl:with-param>
                <xsl:with-param name="acas_color"><xsl:value-of select="@acas_color"/></xsl:with-param>
            </xsl:call-template>
            <fo:flow flow-name="body">
                <xsl:choose>
                    <xsl:when test="@licenseType = 'home'">
                        <fo:block>
                            <fo:block-container position="fixed" left="-50pt" top="-50pt" width="100%" height="100%">
                                <fo:block>
                                    <fo:instream-foreign-object>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="680" height="920" style="pointer-events: none;">
                                            <text font-family="open_sans_bold" font-weight="600" font-size="55pt" style="fill:grey;opacity:0.1;" x="-10" y="300" width="680" text-anchor="middle" transform="rotate(-54, 340, 15)">Nessus Essentials</text>
                                        </svg>
                                    </fo:instream-foreign-object>
                                </fo:block>
                            </fo:block-container>
                        </fo:block>
                    </xsl:when>
                    <xsl:when test="@licenseEval = 'true'">
                        <fo:block>
                            <fo:block-container position="fixed" left="-50pt" top="-50pt" width="100%" height="100%">
                                <fo:block>
                                    <fo:instream-foreign-object>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="680" height="920" style="pointer-events: none;">
                                            <text font-family="open_sans_bold" font-weight="600" font-size="65pt" style="fill:grey;opacity:0.1;" x="-10" y="300" width="680" text-anchor="middle" transform="rotate(-54, 340, 15)">For Trial Use Only</text>
                                        </svg>
                                    </fo:instream-foreign-object>
                                </fo:block>
                            </fo:block-container>
                        </fo:block>
                    </xsl:when>
                </xsl:choose>

                <fo:block text-align-last="center" font-size="10px" font-family="open_sans_bold, Helvetica, Arial, sans-serif" font-weight="600" color="#999999" padding-top="5px" padding-bottom="5px" border-bottom-color="#999999" border-bottom-width="thin" border-bottom-style="dotted" border-top-color="#999999" border-top-width="thin" border-top-style="dotted">
                    <xsl:text>TABLE OF CONTENTS</xsl:text>
                </fo:block>

                <xsl:for-each select="chapter">
                    <fo:block font-size="12px" font-family="open_sans_bold, Helvetica, Arial, sans-serif" font-weight="600" color="#333333" space-before="20px" space-after="5px">
                        <fo:basic-link internal-destination="{generate-id(.)}">
                            <xsl:value-of select="@name" />
                        </fo:basic-link>
                    </fo:block>

                    <xsl:for-each select="section">
                        <xsl:variable name="sev">
                            <xsl:choose>
                                <xsl:when test="@severity = '0'">#67ACE1</xsl:when>
                                <xsl:when test="@severity = '1'">#F8C851</xsl:when>
                                <xsl:when test="@severity = '2'">#F18C43</xsl:when>
                                <xsl:when test="@severity = '3'">#DD4B50</xsl:when>
                                <xsl:when test="@severity = '4'">#91243E</xsl:when>
                                <xsl:otherwise>#000000</xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <fo:block text-align-last="justify" font-size="10px" font-family="open_sans_regular, Helvetica, Arial, sans-serif" font-weight="400" color="#666666" space-before="7px" space-after="7px">
                            <fo:inline vertical-align="middle" font-size="14px" color="{$sev}">&#x2022;&#xA0;</fo:inline>
                            <fo:basic-link internal-destination="{generate-id(.)}">
                                <xsl:value-of select="substring(@name, 1, 100)" />
                                <fo:leader leader-pattern="dots" />
                                <fo:page-number-citation ref-id="{generate-id(.)}" />
                            </fo:basic-link>
                        </fo:block>
                    </xsl:for-each>
                </xsl:for-each>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

    <xsl:template match="chapter">
        <fo:page-sequence master-reference="page">
            <xsl:call-template name="add_header">
                <xsl:with-param name="acas_text"><xsl:value-of select="../@acas_text"/></xsl:with-param>
                <xsl:with-param name="acas_color"><xsl:value-of select="../@acas_color"/></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="add_footer">
                <xsl:with-param name="acas_text"><xsl:value-of select="../@acas_text"/></xsl:with-param>
                <xsl:with-param name="acas_color"><xsl:value-of select="../@acas_color"/></xsl:with-param>
            </xsl:call-template>
            <fo:flow flow-name="body">
                <xsl:choose>
                    <xsl:when test="ancestor::report/@licenseType = 'home'">
                        <fo:block>
                            <fo:block-container position="fixed" left="-50pt" top="-50pt" width="100%" height="100%">
                                <fo:block>
                                    <fo:instream-foreign-object>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="680" height="920" style="pointer-events: none;">
                                            <text font-family="open_sans_bold" font-weight="600" font-size="55pt" style="fill:grey;opacity:0.1;" x="-10" y="300" width="680" text-anchor="middle" transform="rotate(-54, 340, 15)">Nessus Essentials</text>
                                        </svg>
                                    </fo:instream-foreign-object>
                                </fo:block>
                            </fo:block-container>
                        </fo:block>
                    </xsl:when>
                    <xsl:when test="ancestor::report/@licenseEval = 'true'">
                        <fo:block>
                            <fo:block-container position="fixed" left="-50pt" top="-50pt" width="100%" height="100%">
                                <fo:block>
                                    <fo:instream-foreign-object>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="680" height="920" style="pointer-events: none;">
                                            <text font-family="open_sans_bold, Helvetica, Arial, sans-serif" font-weight="600" font-size="65pt" style="fill:grey;opacity:0.1;" x="-10" y="300" width="680" text-anchor="middle" transform="rotate(-54, 340, 15)">For Trial Use Only</text>
                                        </svg>
                                    </fo:instream-foreign-object>
                                </fo:block>
                            </fo:block-container>
                        </fo:block>
                    </xsl:when>
                </xsl:choose>

                <fo:block-container height="100%" display-align="center">
                    <fo:block id="{generate-id(.)}" text-align-last="center" font-size="16px" font-family="open_sans_bold, Helvetica, Arial, sans-serif" font-weight="600" color="#333333" padding-top="5px" padding-bottom="5px" border-bottom-color="#333333" border-bottom-width="thin" border-bottom-style="dotted" border-top-color="#333333" border-top-width="thin" border-top-style="dotted">
                        <xsl:value-of select="@name" />
                    </fo:block>
                    <fo:block text-align="left" font-size="14px" font-family="open_sans_light, Helvetica, Arial, sans-serif" font-weight="300" color="#000" padding-top="3px" padding-bottom="5px" letter-spacing="1px">
                        <xsl:if test="string-length(@table_desc) != 0">
                            <xsl:value-of select="@table_desc" />
                        </xsl:if>
                    </fo:block>
                </fo:block-container>
            </fo:flow>
        </fo:page-sequence>

        <xsl:if test="section">
            <xsl:apply-templates select="section" />
        </xsl:if>
    </xsl:template>

    <xsl:template match="section">
        <fo:page-sequence master-reference="page">
            <xsl:variable name="bgcolor">
                <xsl:choose>
                    <xsl:when test="@severity = '0'">#67ACE1</xsl:when>
                    <xsl:when test="@severity = '1'">#F8C851</xsl:when>
                    <xsl:when test="@severity = '2'">#F18C43</xsl:when>
                    <xsl:when test="@severity = '3'">#DD4B50</xsl:when>
                    <xsl:when test="@severity = '4'">#91243E</xsl:when>
                    <xsl:when test="@compliance_level = '0'">#966807</xsl:when>
                    <xsl:when test="@compliance_level = '1'">#527421</xsl:when>
                    <xsl:when test="@compliance_level = '3'">#9f4909</xsl:when>
                    <xsl:when test="@compliance_level = '4'">#c2212e</xsl:when>
                    <xsl:otherwise>#000000</xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:call-template name="add_header">
                <xsl:with-param name="acas_text"><xsl:value-of select="../../@acas_text" /></xsl:with-param>
                <xsl:with-param name="acas_color"><xsl:value-of select="../../@acas_color" /></xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="add_footer">
                <xsl:with-param name="value"><xsl:value-of select="@name" /></xsl:with-param>
                <xsl:with-param name="acas_text"><xsl:value-of select="../../@acas_text" /></xsl:with-param>
                <xsl:with-param name="acas_color"><xsl:value-of select="../../@acas_color" /></xsl:with-param>
            </xsl:call-template>

            <fo:flow flow-name="body">
                <xsl:choose>
                    <xsl:when test="ancestor::report/@licenseType = 'home'">
                        <fo:block>
                            <fo:block-container position="fixed" left="-50pt" top="-50pt" width="100%" height="100%">
                                <fo:block>
                                    <fo:instream-foreign-object>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="680" height="920" style="pointer-events: none;">
                                            <text font-family="open_sans_bold" font-weight="600" font-size="55pt" style="fill:grey;opacity:0.1;" x="-10" y="300" width="680" text-anchor="middle" transform="rotate(-54, 340, 15)">Nessus Essentials</text>
                                        </svg>
                                    </fo:instream-foreign-object>
                                </fo:block>
                            </fo:block-container>
                        </fo:block>
                    </xsl:when>
                    <xsl:when test="ancestor::report/@licenseEval = 'true'">
                        <fo:block>
                            <fo:block-container position="fixed" left="-50pt" top="-50pt" width="100%" height="100%">
                                <fo:block>
                                    <fo:instream-foreign-object>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="680" height="920" style="pointer-events: none;">
                                            <text font-family="open_sans_bold" font-weight="600" font-size="65pt" style="fill:grey;opacity:0.1;" x="-10" y="300" width="680" text-anchor="middle" transform="rotate(-54, 340, 15)">For Trial Use Only</text>
                                        </svg>
                                    </fo:instream-foreign-object>
                                </fo:block>
                            </fo:block-container>
                        </fo:block>
                    </xsl:when>
                </xsl:choose>

                <fo:block-container background-color="{$bgcolor}" border-top-color="#333333" border-top-width="thin" border-top-style="dotted">
                    <xsl:if test="@style = 'plugin-header'">
                        <xsl:attribute name="width">98%</xsl:attribute>
                        <xsl:attribute name="margin">0</xsl:attribute>
                        <xsl:attribute name="padding">0 1%</xsl:attribute>
                        <xsl:attribute name="border-bottom-color">#333333</xsl:attribute>
                        <xsl:attribute name="border-bottom-style">dotted</xsl:attribute>
                        <xsl:attribute name="border-bottom-width">thin</xsl:attribute>
                    </xsl:if>

                    <fo:block id="{generate-id(.)}" text-align="center" font-size="14px" font-family="open_sans_bold, Helvetica, Arial, sans-serif" font-weight="600" color="#333333" padding-top="5px" padding-bottom="5px">
                        <xsl:if test="@style = 'plugin-header'">
                            <xsl:attribute name="font-size">12px</xsl:attribute>
                            <xsl:attribute name="color">#FFFFFF</xsl:attribute>
                            <xsl:attribute name="text-align">left</xsl:attribute>
                        </xsl:if>

                        <xsl:value-of select="@name" />

                        <fo:block text-align="left" font-size="12px" font-family="open_sans_light, Helvetica, Arial, sans-serif" font-weight="300" color="#000" padding-top="3px" padding-bottom="5px" letter-spacing="1px">
                            <xsl:if test="string-length(@table_desc) != 0">
                                <xsl:value-of select="@table_desc" />
                            </xsl:if>
                        </fo:block>
                    </fo:block>
                </fo:block-container>
                <xsl:apply-templates select="table" />
                <xsl:apply-templates select="h1" />

            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

    <xsl:template name="add_header">
        <xsl:param name="acas_text" />
        <xsl:param name="acas_color" />
        <fo:static-content flow-name="header">
            <xsl:if test="string-length($acas_text) != 0">
                <fo:block font-size="10px" margin-top="-1cm" font-family="open_sans_bold, Helvetica, Arial, sans-serif" text-align="center" font-weight="600" color="{$acas_color}">
                    <xsl:value-of select="$acas_text"/>
                </fo:block>
            </xsl:if>
            <xsl:if test="string-length($acas_text) = 0">
                <fo:block></fo:block>
            </xsl:if>
        </fo:static-content>
    </xsl:template>

    <xsl:template name="add_footer">
        <xsl:param name="value" />
        <xsl:param name="acas_text" />
        <xsl:param name="acas_color" />
        <fo:static-content flow-name="footer">
            <xsl:if test="string-length($value) != 0">
                <fo:block font-size="8px" font-family="open_sans_regular, Helvetica, Arial, sans-serif" margin-top="5px" padding-top="5px" text-align="right" color="#999999" border-top-color="#999999" border-top-style="dotted" border-top-width="thin" text-align-last="justify">
                    <xsl:value-of select="$value" />
                    <fo:leader leader-pattern="space" />
                    <fo:page-number/>
                </fo:block>
            </xsl:if>
            <xsl:if test="string-length($acas_text) != 0">
                <fo:block font-size="10px" font-family="open_sans_bold, Helvetica, Arial, sans-serif" text-align="center" font-weight="600" color="{$acas_color}">
                    <xsl:if test="string-length($value) = 0">
                        <xsl:attribute name="margin-top">5px</xsl:attribute>
                        <xsl:attribute name="padding-top">5px</xsl:attribute>
                    </xsl:if>
                    <xsl:value-of select="$acas_text"/>
                </fo:block>
            </xsl:if>
            <xsl:if test="string-length($acas_text) = 0 and string-length($value) = 0">
                <fo:block></fo:block>
            </xsl:if>
        </fo:static-content>
    </xsl:template>

    <xsl:template match="subsection">
        <xsl:variable name="sev">
            <xsl:choose>
                <xsl:when test="@severity = '0'">#67ACE1</xsl:when>
                <xsl:when test="@severity = '1'">#F8C851</xsl:when>
                <xsl:when test="@severity = '2'">#F18C43</xsl:when>
                <xsl:when test="@severity = '3'">#DD4B50</xsl:when>
                <xsl:when test="@severity = '4'">#91243E</xsl:when>
                <xsl:otherwise>#666666</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:if test="@name">
            <fo:block font-size="12px" font-family="open_sans_bold, Helvetica, Arial, sans-serif" font-weight="600" color="#333333" padding-top="5px" padding-bottom="5px" border-bottom-color="#333333" border-bottom-width="thin" border-bottom-style="dotted" border-top-color="#333333" border-top-width="thin" border-top-style="dotted">
                <xsl:value-of select="@name" />
            </fo:block>
        </xsl:if>

        <xsl:apply-templates select="h0" />
    </xsl:template>

    <xsl:template match="h0">
        <xsl:variable name="sev">
            <xsl:choose>
                <xsl:when test="@severity = '0'">#67ACE1</xsl:when>
                <xsl:when test="@severity = '1'">#F8C851</xsl:when>
                <xsl:when test="@severity = '2'">#F18C43</xsl:when>
                <xsl:when test="@severity = '3'">#DD4B50</xsl:when>
                <xsl:when test="@severity = '4'">#91243E</xsl:when>
                <xsl:otherwise>#333333</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:if test="@name">
            <fo:block-container width="98%" padding="0 1%" margin="0" background-color="{$sev}" border-bottom-color="#999999" border-bottom-width="thin" border-bottom-style="dotted">
                <fo:block font-size="10px" font-family="open_sans_bold, Helvetica, Arial, sans-serif" font-weight="600" color="#FFFFFF" padding-top="5px" padding-bottom="5px">
                    <xsl:value-of select="@name" />
                </fo:block>
            </fo:block-container>
        </xsl:if>

        <xsl:apply-templates select="h1" />
        <xsl:if test="@page-break = 'end'">
            <fo:block page-break-after="always" />
        </xsl:if>
    </xsl:template>

    <xsl:template match="h1">
        <xsl:if test="@name">
            <fo:block font-size="12px" text-align-last="justify" font-family="open_sans_regular" font-weight="400" color="#333333" padding-top="5px" padding-bottom="5px" border-bottom-color="#333333" border-bottom-width="thin" border-bottom-style="dotted" space-before="20px">
                <xsl:if test="@style = 'vuln-table'">
                    <xsl:attribute name="font-size">10px</xsl:attribute>
                </xsl:if>

                <xsl:if test="@style = 'host-details'">
                    <xsl:attribute name="font-size">10px</xsl:attribute>
                    <xsl:attribute name="space-before">15px</xsl:attribute>
                    <xsl:attribute name="space-after">5px</xsl:attribute>
                    <xsl:attribute name="font-weight">600</xsl:attribute>
                </xsl:if>

                <xsl:if test="@style = 'plugin-details'">
                    <xsl:attribute name="font-size">10px</xsl:attribute>
                    <xsl:attribute name="space-before">15px</xsl:attribute>
                    <xsl:attribute name="space-after">5px</xsl:attribute>
                    <xsl:attribute name="font-weight">600</xsl:attribute>
                </xsl:if>

                <xsl:value-of select="@name" />
                <fo:leader leader-pattern="space" />
                <xsl:value-of select="@total" />
            </fo:block>
        </xsl:if>

        <xsl:apply-templates select="subsection" />
        <xsl:apply-templates select="h2" />
        <xsl:apply-templates select="text" />
        <xsl:apply-templates select="table" />
        <xsl:apply-templates select="link" />
    </xsl:template>

    <xsl:template match="table">
        <fo:table table-layout="fixed" width="100%">
            <xsl:apply-templates select="column" />

            <fo:table-body>
                <xsl:apply-templates select="row" />
            </fo:table-body>
        </fo:table>
    </xsl:template>

    <xsl:template match="column">
        <fo:table-column column-width="{@size}" />
    </xsl:template>

    <xsl:template match="row">
        <xsl:variable name="borderWidth">
            <xsl:choose>
                <xsl:when test="@border"><xsl:value-of select="@border" /></xsl:when>
                <xsl:otherwise>thin</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="borderStyle">
            <xsl:choose>
                <xsl:when test="@border-style"><xsl:value-of select="@border-style" /></xsl:when>
                <xsl:otherwise>dotted</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="borderColor">
            <xsl:choose>
                <xsl:when test="@border-color"><xsl:value-of select="@border-color" /></xsl:when>
                <xsl:otherwise>#FFFFFF</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <fo:table-row border-bottom-color="{$borderColor}" border-bottom-style="{$borderStyle}" border-bottom-width="{$borderWidth}">
            <xsl:if test="@style = 'plugin-header'">
                <xsl:attribute name="background-color">#EEEEEE</xsl:attribute>
            </xsl:if>

            <xsl:if test="@style = 'plugin-row'">
                <xsl:attribute name="border-top-color">#999999</xsl:attribute>
                <xsl:attribute name="border-top-style">dotted</xsl:attribute>
                <xsl:attribute name="border-top-width">thin</xsl:attribute>
            </xsl:if>

            <xsl:apply-templates select="cell" />
        </fo:table-row>
    </xsl:template>

    <xsl:template match="cell">
        <xsl:variable name="sev">
            <xsl:choose>
                <xsl:when test="@severity = '0'">#67ACE1</xsl:when>
                <xsl:when test="@severity = '1'">#F8C851</xsl:when>
                <xsl:when test="@severity = '2'">#F18C43</xsl:when>
                <xsl:when test="@severity = '3'">#DD4B50</xsl:when>
                <xsl:when test="@severity = '4'">#91243E</xsl:when>
                <xsl:otherwise>#ffffff</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <fo:table-cell>
            <xsl:if test="@sortcolumn = 'true'">
                <xsl:attribute name="font-weight">600</xsl:attribute>
            </xsl:if>

            <xsl:if test="@background">
                <xsl:attribute name="background-color"><xsl:value-of select="@background" /></xsl:attribute>
            </xsl:if>

            <xsl:if test="@severity">
                <xsl:attribute name="background-color"><xsl:value-of select="$sev" /></xsl:attribute>
            </xsl:if>

            <xsl:if test="@col-span">
                <xsl:attribute name="number-columns-spanned"><xsl:value-of select="@col-span" /></xsl:attribute>
            </xsl:if>

            <fo:block font-family="open_sans_regular, Helvetica, Arial, sans-serif" font-size="10px">
                <xsl:if test="@style = 'severity-box'">
                    <xsl:attribute name="font-size">16px</xsl:attribute>
                    <xsl:attribute name="font-weight">400</xsl:attribute>
                    <xsl:attribute name="padding-top">15px</xsl:attribute>
                    <xsl:attribute name="padding-bottom">15px</xsl:attribute>
                    <xsl:attribute name="color">#FFFFFF</xsl:attribute>
                    <xsl:attribute name="text-align">center</xsl:attribute>
                </xsl:if>

                <xsl:if test="@style = 'severity-desc'">
                    <xsl:attribute name="font-size">8px</xsl:attribute>
                    <xsl:attribute name="font-weight">400</xsl:attribute>
                    <xsl:attribute name="color">#666666</xsl:attribute>
                    <xsl:attribute name="text-align">center</xsl:attribute>
                    <xsl:attribute name="text-transform">uppercase</xsl:attribute>
                    <xsl:attribute name="padding-top">2px</xsl:attribute>
                    <xsl:attribute name="padding-bottom">2px</xsl:attribute>
                </xsl:if>

                <xsl:if test="@style = 'plugin-header'">
                    <xsl:attribute name="font-size">8px</xsl:attribute>
                    <xsl:attribute name="font-family">open_sans_bold</xsl:attribute>
                    <xsl:attribute name="font-weight">600</xsl:attribute>
                    <xsl:attribute name="color">#333333</xsl:attribute>
                    <xsl:attribute name="text-align">left</xsl:attribute>
                    <xsl:attribute name="text-transform">uppercase</xsl:attribute>
                    <xsl:attribute name="padding-top">5px</xsl:attribute>
                    <xsl:attribute name="padding-bottom">5px</xsl:attribute>
                </xsl:if>

                <xsl:if test="@style = 'plugin-score'">
                    <xsl:attribute name="font-size">10px</xsl:attribute>
                    <xsl:attribute name="font-weight">400</xsl:attribute>
                    <xsl:attribute name="color">#333333</xsl:attribute>
                    <xsl:attribute name="text-align">left</xsl:attribute>
                    <xsl:attribute name="padding-top">7px</xsl:attribute>
                    <xsl:attribute name="padding-bottom">5px</xsl:attribute>
                </xsl:if>

                <xsl:if test="@style = 'plugin-name' or @style = 'plugin-name-offline'">
                    <xsl:attribute name="font-size">10px</xsl:attribute>
                    <xsl:attribute name="font-weight">400</xsl:attribute>
                    <xsl:attribute name="color">#333333</xsl:attribute>
                    <xsl:attribute name="text-align">left</xsl:attribute>
                    <xsl:attribute name="padding-top">7px</xsl:attribute>
                    <xsl:attribute name="padding-bottom">5px</xsl:attribute>
                    <xsl:attribute name="line-height">14px</xsl:attribute>
                </xsl:if>

                <xsl:if test="@style = 'plugin-id'">
                    <xsl:attribute name="text-align">center</xsl:attribute>
                </xsl:if>

                <xsl:if test="@text-align">
                    <xsl:attribute name="text-align"><xsl:value-of select="@text-align" /></xsl:attribute>
                </xsl:if>

                <xsl:if test="@style = 'host-key'">
                    <xsl:attribute name="font-size">10px</xsl:attribute>
                    <xsl:attribute name="padding-top">5px</xsl:attribute>
                    <xsl:attribute name="color">#333333</xsl:attribute>
                </xsl:if>

                <xsl:if test="@style = 'host-value'">
                    <xsl:attribute name="font-size">10px</xsl:attribute>
                    <xsl:attribute name="padding-top">5px</xsl:attribute>
                    <xsl:attribute name="color">#333333</xsl:attribute>
                </xsl:if>

                <xsl:if test="@style = 'plugin-ref-key'">
                    <xsl:attribute name="padding-bottom">3px</xsl:attribute>
                </xsl:if>

                <xsl:if test="@style = 'plugin-ref-value'">
                    <xsl:attribute name="padding-bottom">3px</xsl:attribute>
                </xsl:if>

                <xsl:value-of select="@name" />

                <xsl:if test="@style = 'plugin-name-offline'">
                    <fo:inline font-size="10px" color="#999999" text-align="left">
                        [Offline]
                    </fo:inline>
                </xsl:if>
            </fo:block>

            <xsl:apply-templates select="pre" />
            <xsl:apply-templates select="text" />
            <xsl:apply-templates select="link" />
        </fo:table-cell>
    </xsl:template>

    <xsl:template match="h2">
        <xsl:variable name="sev">
            <xsl:choose>
                <xsl:when test="@severity = '0'">#67ACE1</xsl:when>
                <xsl:when test="@severity = '1'">#F8C851</xsl:when>
                <xsl:when test="@severity = '2'">#F18C43</xsl:when>
                <xsl:when test="@severity = '3'">#DD4B50</xsl:when>
                <xsl:when test="@severity = '4'">#91243E</xsl:when>
                <xsl:otherwise>#333333</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <fo:block font-size="10px" font-family="open_sans_regular, Helvetica, Arial, sans-serif" color="{$sev}" text-align="left">
            <xsl:value-of select="@name" />
        </fo:block>

        <xsl:apply-templates select="pre" />
    </xsl:template>

    <xsl:template match="text">
        <xsl:variable name="sev">
            <xsl:choose>
                <xsl:when test="@severity = '0'">#67ACE1</xsl:when>
                <xsl:when test="@severity = '1'">#F8C851</xsl:when>
                <xsl:when test="@severity = '2'">#F18C43</xsl:when>
                <xsl:when test="@severity = '3'">#DD4B50</xsl:when>
                <xsl:when test="@severity = '4'">#91243E</xsl:when>
                <xsl:otherwise>#ffffff</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <fo:block font-size="10px" font-family="open_sans_regular" color="#333333">
            <xsl:if test="@style = 'plugin-badge' or @style = 'plugin-badge-offline'">
                <xsl:attribute name="font-size">8px</xsl:attribute>
                <xsl:attribute name="color">#FFFFFF</xsl:attribute>
                <xsl:attribute name="text-align">center</xsl:attribute>
                <xsl:attribute name="text-transform">uppercase</xsl:attribute>
                <xsl:attribute name="margin-top">5px</xsl:attribute>
                <xsl:attribute name="padding-top">3px</xsl:attribute>
                <xsl:attribute name="padding-bottom">3px</xsl:attribute>
                <xsl:attribute name="background-color"><xsl:value-of select="$sev" /></xsl:attribute>
            </xsl:if>

            <xsl:if test="@style = 'remediations-desc'">
                <xsl:attribute name="font-size">10px</xsl:attribute>
                <xsl:attribute name="font-weight">400</xsl:attribute>
                <xsl:attribute name="text-align">left</xsl:attribute>
                <xsl:attribute name="padding-top">20px</xsl:attribute>
                <xsl:attribute name="padding-bottom">20px</xsl:attribute>
                <xsl:attribute name="border-top-color">#333333</xsl:attribute>
                <xsl:attribute name="border-top-style">dotted</xsl:attribute>
                <xsl:attribute name="border-top-width">thin</xsl:attribute>
                <xsl:attribute name="border-bottom-color">#999999</xsl:attribute>
                <xsl:attribute name="border-bottom-style">dotted</xsl:attribute>
                <xsl:attribute name="border-bottom-width">thin</xsl:attribute>
            </xsl:if>

            <xsl:choose>
                <xsl:when test="@style = 'plugin-badge' or @style = 'plugin-badge-offline'">
                    <xsl:value-of select="." />
                </xsl:when>
                <xsl:when test="@style = 'remediations-desc'">
                    <xsl:value-of select="." />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="br">
                        <xsl:with-param name="padding" select="'5px'" />
                    </xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
        </fo:block>
    </xsl:template>

    <xsl:template match="pre">
        <fo:block-container width="98%" padding="0 1%" background-color="#EEEEEE" space-before="10px" space-after="10px" margin-left="0">
            <fo:block font-size="8px" font-family="Courier New, Courier, monospace" font-weight="normal" color="#333333" padding="10px 0" text-align="left" white-space-treatment="preserve" white-space-collapse="false">
                <xsl:apply-templates select="br">
                    <xsl:with-param name="padding" select="'0'" />
                </xsl:apply-templates>
            </fo:block>
        </fo:block-container>
    </xsl:template>

    <xsl:template match="br">
        <xsl:param name="padding" />
        <xsl:value-of select="." />

        <xsl:if test="not(@last)">
            <fo:block>
                <xsl:attribute name="space-after">
                    <xsl:value-of select="$padding" />
                </xsl:attribute>
            </fo:block>
        </xsl:if>
    </xsl:template>

    <xsl:template match="link">
        <fo:block font-size="10px" font-family="open_sans_regular, Helvetica, Arial, sans-serif" font-weight="400" color="#666666" text-align="left">
            <xsl:if test="@style = 'plugin-id'">
                <xsl:attribute name="color">#67ACE1</xsl:attribute>
                <xsl:attribute name="padding-top">7px</xsl:attribute>
                <xsl:attribute name="padding-bottom">5px</xsl:attribute>
            </xsl:if>

            <xsl:if test="@style = 'see-also'">
                <xsl:attribute name="padding-bottom">5px</xsl:attribute>
            </xsl:if>

            <xsl:if test="@style = 'plugin-ref-value'">
                <xsl:attribute name="color">#333333</xsl:attribute>
            </xsl:if>

            <fo:basic-link external-destination="url({@href})">
                <xsl:value-of select="." />
            </fo:basic-link>
        </fo:block>
    </xsl:template>
</xsl:stylesheet>
