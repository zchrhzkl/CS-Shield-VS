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
    <xsl:output method="html" indent="yes" encoding="utf-8" />

    <xsl:template match="report">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
                <title><xsl:value-of select="@name" /></title>
                <style type="text/css" media="all">
                @import url("https://fonts.googleapis.com/css?family=Open+Sans:300,400,700,800")
                </style>
                <style type="text/css" media="all">
                    html, body, div, span, applet, object, iframe, h1, h2, h4, h5, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, embed, figure, figcaption, footer, header, hgroup, menu, nav, output, ruby, section, summary, time, mark, audio, video {
                        margin: 0;
                        padding: 0;
                        border: 0;
                        font-size: 100%;
                        font: inherit;
                        vertical-align: baseline;
                        -webkit-text-size-adjust: none;
                    }

                    h3, h6 {
                        font-weight: 300 !important;
                    }

                    html, body {
                        font-family: 'Open Sans', 'Helvetica Neue', 'Segoe UI', helvetica, arial, sans-serif;
                        width: 100%;
                        color: #333;
                        font-size: 13px;
                        background: #efefef;
                    }

                    a, a:visited, a:active {
                        color: #67ACE1;
                        text-decoration: none;
                    }

                    a:hover {
                        color: #67ACE1;
                        text-decoration: underline;
                    }

                    .clear {
                        clear: both;
                        width: 0 !important;
                        height: 0 !important;
                        margin: 0 !important;
                        padding: 0 !important;
                    }

                    table {
                        table-layout: fixed;
                        width: 100%;
                        border-collapse: collapse;
                        border-spacing: 0;
                        margin-bottom: 20px;
                        margin-top: 20px;
                    }

                    .plugin-row-header {
                        height: 35px;
                        line-height: 35px;
                        background: #f5f5f5;
                        font-size: 12px;
                        border: 1px solid #ddd;
                    }

                    .plugin-row {
                        height: 40px;
                        border: 1px solid #ddd;
                    }

                    .plugin-row td {
                        padding: 10px 0;
                        line-height: 20px;
                    }

                    .table-wrapper.details,
                    .table-wrapper.see-also {
                        margin: 0 0 20px 0;
                    }

                    .table-wrapper.details > table > tbody > tr > td {
                        padding: 5px 0;
                    }

                    .button {
                        display: block;
                        float: left;
                        line-height: 30px;
                        background: #eee;
                        border-radius: 3px;
                        cursor: pointer;
                        padding: 0 15px;
                    }

                    .button:hover {
                        background: #ccc;
                    }

                    .expand {
                        display: block;
                        float:right;
                        font-size: 12px;
                        color: #67ACE1;
                        cursor: pointer;
                        font-weight: 400;
                        line-height: 20px;
                        margin: 0 0 0 10px;
                    }

                    .expand:hover {
                        text-decoration: underline;
                    }

                    .expand-spacer {
                        display: block;
                        float:right;
                        font-size: 12px;
                        font-weight: 400;
                        line-height: 20px;
                        margin: 0 0 0 10px;
                    }

                    .details-header {
                        font-size: 14px;
                        font-weight: 700;
                        padding: 0 0 5px 0;
                        margin: 0 0 5px 0;
                        border-bottom: 1px dotted #ccc;
                    }

                    .offline {
                        background-image: -webkit-repeating-linear-gradient(135deg, transparent, transparent 5px, rgba(255, 255, 255, .2) 5px, rgba(255, 255, 255, .2) 10px) !important;
                        background-image: repeating-linear-gradient(135deg, transparent, transparent 5px, rgba(255, 255, 255, .2) 5px, rgba(255, 255, 255, .2) 10px) !important;
                    }

                    .acas-header {
                        padding: 0 10px;
                    }

                    .acas-header,
                    .acas-footer > h1 {
                        color: #fff;
                        font-weight: 700;
                        font-size: 15px;
                        text-align: center;
                    }

                    .table-desc > h5 {
                        color: #000;
                        text-align: left;
                        padding: 3px;
                        font-size: 14px;
                        font-weight: 300;
                        letter-spacing: 1px;
                        padding-top: 15px;
                        padding-bottom: 15px;
                    }

                </style>

                <xsl:if test="@toc = 'on'">
                    <script type="text/javascript">
                        <xsl:text>
                        var toggle = function (id) {
                            var div = document.getElementById(id);
                            var button = document.getElementById(id + '-show');

                            if (!div || !button) {
                                return;
                            }

                            if (div.style.display === '' || div.style.display === 'block') {
                                button.style.display = 'block';
                                div.style.display = 'none';
                                adjustWatermark();
                                return;
                            }

                            button.style.display = 'none';
                            div.style.display = 'block';

                            adjustWatermark();
                        };

                        var toggleAll = function (hide) {
                            if (document.querySelectorAll('div.section-wrapper').length) {
                                toggleAllSection(hide);
                                adjustWatermark();
                                return;
                            }

                            var divs = document.querySelectorAll('div.table-wrapper');

                            for (var i = 0, il = divs.length; i &lt; il; i++) {
                                var id = divs[i].getAttribute('id');
                                var div = document.getElementById(id);
                                var button = document.getElementById(id + '-show');

                                if (div &amp;&amp; button) {
                                    if (hide) {
                                        button.style.display = 'block';
                                        div.style.display = 'none';
                                        adjustWatermark();
                                        continue;
                                    }

                                    button.style.display = 'none';
                                    div.style.display = 'block';
                                }
                            }
                            adjustWatermark();
                        };

                        var toggleSection = function (id) {
                            var div = document.getElementById(id);
                            var toggleText = document.getElementById(id.split('-')[0] + '-toggletext');

                            if (!div) {
                                return;
                            }

                            if (div.style.display !== 'none') {
                                toggleText.innerText = '+';
                                div.style.display = 'none';
                                adjustWatermark();
                                return;
                            }

                            toggleText.innerText = '-';
                            div.style.display = 'block';

                            adjustWatermark();
                        };

                        var toggleAllSection = function (hide) {
                            var divs = document.querySelectorAll('div.section-wrapper');

                            for (var i = 0, il = divs.length; i &lt; il; i++) {
                                var id = divs[i].getAttribute('id');
                                var div = document.getElementById(id);
                                var toggleText = document.getElementById(id.split('-')[0] + '-toggletext');

                                if (div) {
                                    if (hide) {
                                        toggleText.innerText = '+';
                                        div.style.display = 'none';
                                        continue;
                                    }

                                    toggleText.innerText = '-';
                                    div.style.display = 'block';
                                }
                            }
                            adjustWatermark();
                        };

                        var adjustWatermark = function () {
                          if (document.getElementById('nessus-watermark')) {
                            let el = document.getElementById('nessus-watermark');
                            let body = document.body;
                            let html = document.documentElement;
                            let height = Math.max( body.scrollHeight, body.offsetHeight,
                                html.clientHeight, html.scrollHeight, html.offsetHeight );
                            el.setAttribute('height', body.offsetHeight);
                          }
                        };
                        </xsl:text>
                    </script>
                </xsl:if>
            </head>
            <body>
                <div id="report" style="width: 1024px; box-sizing: border-box; margin: 0 auto; background: #fff; padding: 0 20px 20px 20px; border-top: #263746 solid 3px; box-shadow: 0 2px 10px rgba(0, 0, 0, .2); margin-bottom: 20px; border-radius: 0 0 3px 3px;">
                    <xsl:if test="string-length(@acas_text) != 0">
                        <span class="acas-header">
                            <h1 style="background:{@acas_color};">
                                <font color="#ffffff"><xsl:value-of select="@acas_text" /></font>
                            </h1>
                        </span>
                    </xsl:if>
                    <xsl:choose>
                        <xsl:when test="@licenseType ='home' and  @reportType ='custom'">
                            <svg xmlns="http://www.w3.org/2000/svg" id="nessus-watermark" width="680" height="920" style="position:absolute;pointer-events: none;margin-left:10rem;">
                                <defs>
                                    <pattern id="pattern" x="0" y="0" width="1" height=".001">
                                        <text font-family="Arial Black" font-size="55pt" style="fill:grey; opacity:.1;" x="0" y="300" width="680" text-anchor="middle" transform="rotate(-54, 340, 15)">Nessus Essentials</text>
                                    </pattern>
                                </defs>
                                <rect id="nessus-watermark-fill" fill="url(#pattern)" width="680" height="920000"></rect>
                            </svg>
                            <script>
                                window.addEventListener('DOMContentLoaded', (event) => {
                                  let el = document.getElementById('nessus-watermark');
                                  let elFill = document.getElementById('nessus-watermark-fill');
                                  let body = document.body;
                                  let html = document.documentElement;
                                  let height = Math.max( body.scrollHeight, body.offsetHeight,
                                      html.clientHeight, html.scrollHeight, html.offsetHeight );
                                  el.setAttribute('height', height);
                                });
                            </script>
                        </xsl:when>
                        <xsl:when test="@licenseType ='home' and  @reportType ='executive'">
                            <svg xmlns="http://www.w3.org/2000/svg" id="nessus-watermark" width="680" height="920" style="position:absolute;pointer-events: none;margin-left:10rem;">
                                <defs>
                                    <pattern id="pattern" x="0" y="0" width="1" height=".01">
                                        <text font-family="Arial Black" font-size="55pt" style="fill:grey; opacity:.1;" x="0" y="300" width="680" text-anchor="middle" transform="rotate(-54, 340, 15)">Nessus Essentials</text>
                                    </pattern>
                                </defs>
                                <rect id="nessus-watermark-fill" fill="url(#pattern)" width="680" height="92000"></rect>
                            </svg>
                            <script>
                                window.addEventListener('DOMContentLoaded', (event) => {
                                  let el = document.getElementById('nessus-watermark');
                                  let body = document.body;
                                  let html = document.documentElement;
                                  let height = Math.max( body.scrollHeight, body.offsetHeight,
                                      html.clientHeight, html.scrollHeight, html.offsetHeight );
                                  el.setAttribute('height', height);
                                });
                            </script>
                        </xsl:when>

                        <xsl:when test="@licenseEval ='true' and  @reportType ='custom'">
                            <svg xmlns="http://www.w3.org/2000/svg" id="nessus-watermark" width="680" height="920" style="position:absolute;pointer-events: none;margin-left:10rem;">
                                <defs>
                                    <pattern id="pattern" x="0" y="0" width="1" height=".001">
                                        <text font-family="Arial Black" font-size="55pt" style="fill:grey; opacity:.1;" x="0" y="300" width="680" text-anchor="middle" transform="rotate(-54, 340, 15)">For Trial Use Only</text>
                                    </pattern>
                                </defs>
                                <rect id="nessus-watermark-fill" fill="url(#pattern)" width="680" height="920000"></rect>
                            </svg>
                              <script>
                                  window.addEventListener('DOMContentLoaded', (event) => {
                                    let el = document.getElementById('nessus-watermark');
                                    let body = document.body;
                                    let html = document.documentElement;
                                    let height = Math.max( body.scrollHeight, body.offsetHeight,
                                        html.clientHeight, html.scrollHeight, html.offsetHeight );
                                    el.setAttribute('height', height);
                                  });
                              </script>
                        </xsl:when>
                        <xsl:when test="@licenseEval ='true' and  @reportType ='executive'">
                            <svg xmlns="http://www.w3.org/2000/svg" id="nessus-watermark" width="680" height="920" style="position:absolute;pointer-events: none;margin-left:10rem;">
                                <defs>
                                    <pattern id="pattern" x="0" y="0" width="1" height=".01">
                                        <text font-family="Arial Black" font-size="55pt" style="fill:grey; opacity:.1;" x="0" y="300" width="680" text-anchor="middle" transform="rotate(-54, 340, 15)">For Trial Use Only</text>
                                    </pattern>
                                </defs>
                                <rect id="nessus-watermark-fill" fill="url(#pattern)" width="680" height="92000"></rect>
                            </svg>
                            <script>
                                window.addEventListener('DOMContentLoaded', (event) => {
                                  let el = document.getElementById('nessus-watermark');
                                  let elFill = document.getElementById('nessus-watermark-fill');
                                  let body = document.body;
                                  let html = document.documentElement;
                                  let height = Math.max( body.scrollHeight, body.offsetHeight,
                                      html.clientHeight, html.scrollHeight, html.offsetHeight );
                                  el.setAttribute('height', height);
                                });
                            </script>
                        </xsl:when>
                    </xsl:choose>
                    <header style="width: 100%; border-bottom: 1px dotted #ccc; padding: 20px 0; margin: 0 0 20px 0;">
                        <div style="float: left;">
                            <h1><img src="{@logo}" height="50" border="0" alt="Nessus Report" style="display: block;" /></h1>
                        </div>
                        <div style="float: right;">
                            <h1 style="font-size: 18px;"><xsl:value-of select="@message" /></h1>
                            <h2 style="color: #999; text-align: right">Report generated by Nessus&#8482;</h2>
                        </div>
                        <div class="clear" />
                    </header>
                    <div class="clear" />

                    <h3 style="font-size: 24px; font-weight: 300;"><xsl:value-of select="@name" /></h3>
                    <h4 style="color: #999; border-bottom: 1px dotted #ccc; padding: 0 0 20px 0; margin: 0 0 20px 0;"><xsl:value-of select="@date" /></h4>
                    <div class="clear" />

                    <div style="width: 100%;">
                        <xsl:if test="@toc = 'on'">
                            <xsl:call-template name="toc" />
                        </xsl:if>

                        <xsl:apply-templates select="chapter" />
                        <div class="clear" />
                    </div>
                    <div class="clear" />
                    <xsl:if test="string-length(@acas_text) != 0">
                        <span class="acas-footer">
                            <h1 style="background:{@acas_color};">
                                <font color="#ffffff"><xsl:value-of select="@acas_text" /></font>
                            </h1>
                        </span>
                    </xsl:if>
                </div>

                <div style="width: 1024px; box-sizing: border-box; text-align: center; font-size: 12px; color: #999; padding: 10px 0 20px 0; margin: 0 auto;">
                    &#169; <xsl:value-of select="@year" /> Tenable&#8482;, Inc. All rights reserved.
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template name="toc">
        <h5 style="font-size: 16px; font-weight: 700; margin-bottom: 20px;">TABLE OF CONTENTS</h5>

        <ul style="list-style-type: none; margin-bottom: 20px;">
            <xsl:for-each select="chapter">
                <li style="font-size: 14px;">
                    <a href="#{generate-id(.)}" style="font-weight: 700;"><xsl:value-of select="@name" /></a>

                    <ul style="list-style-type: disc; margin: 10px 0 0 20px;">
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
                            <li style="margin: 0 0 10px 0; color: {$sev};">
                                <a href="#{generate-id(.)}"><xsl:value-of select="@name" /></a>
                            </li>
                        </xsl:for-each>
                    </ul>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>

    <xsl:template match="chapter">
        <xsl:if test="not(@title)">
            <h6 id="{generate-id(.)}" style="padding: 20px 0; border-top: 1px dotted #ccc; border-bottom: 1px dotted #ccc; font-size: 20px; font-weight: 400; line-height: 20px;">
                <xsl:value-of select="@name" />

                <xsl:choose>
                    <xsl:when test="@toggle = 'false'"></xsl:when>
                    <xsl:otherwise>
                        <span onclick="toggleAll();" class="expand">Expand All</span>
                        <span class="expand-spacer"> | </span>
                        <span onclick="toggleAll(true);" class="expand">Collapse All</span>
                    </xsl:otherwise>
                </xsl:choose>
            </h6>
        </xsl:if>

        <xsl:if test="string-length(@table_desc) != 0">
            <div class="table-desc">
                <h5>
                    <xsl:value-of select="@table_desc" />
                </h5>
            </div>
        </xsl:if>

        <xsl:apply-templates select="section" />
    </xsl:template>

    <xsl:template match="section">
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
                <xsl:otherwise>#ffffff</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="off">
            <xsl:choose>
                <xsl:when test="@offline = '1'">offline</xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="@style = 'plugin-header'">
                <div id="{generate-id(.)}" style="box-sizing: border-box; width: 100%; margin: 0 0 10px 0; padding: 5px 10px; background: {$bgcolor}; font-weight: 700; font-size: 14px; line-height: 20px; color: #fff;" class="{$off}" onclick="toggleSection('{generate-id(.)}-container');" onmouseover="this.style.cursor='pointer'">
                    <xsl:value-of select="@name" />
                    <div id="{generate-id(.)}-toggletext" style="float: right; text-align: center; width: 8px;">
                        -
                    </div>
                </div>
                <div id="{generate-id(.)}-container" class="section-wrapper">
                    <xsl:apply-templates select="h1" />
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div id="{generate-id(.)}" style="font-size: 22px; font-weight: 700; padding: 10px 0;">
                    <xsl:value-of select="@name" />
                    <div class="clear" />
                </div>
                <xsl:apply-templates select="h1" />
            </xsl:otherwise>
        </xsl:choose>

        <xsl:if test="string-length(@table_desc) != 0">
            <div class="table-desc">
                <h5>
                    <xsl:value-of select="@table_desc" />
                </h5>
            </div>
        </xsl:if>

        <xsl:apply-templates select="table" />
    </xsl:template>

    <xsl:template match="h1">
        <xsl:choose>
            <xsl:when test="@style = 'vuln-table'"></xsl:when>
            <xsl:otherwise>
                <xsl:if test="@name">
                    <div class="details-header">
                        <xsl:value-of select="@name" />
                        <div class="clear" />
                    </div>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:apply-templates select="text" />
        <xsl:apply-templates select="table" />
        <xsl:apply-templates select="subsection" />
        <xsl:apply-templates select="h2" />
    </xsl:template>

    <xsl:template match="subsection">
        <h2 class="{@id}">
            <xsl:value-of select="@name" />
        </h2>

        <xsl:apply-templates select="h0" />
    </xsl:template>

    <xsl:template match="table">
        <xsl:variable name="display">
            <xsl:choose>
                <xsl:when test="@style = 'vuln-table'">none</xsl:when>
                <xsl:otherwise>block</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="css">
            <xsl:choose>
                <xsl:when test="@style = 'details'">details</xsl:when>
                <xsl:when test="@style = 'see-also'">see-also</xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:if test="@style = 'vuln-table'">
            <span id="{generate-id(.)}-show" onclick="toggle('{generate-id(.)}');" class="button">Show</span>
            <div class="clear" />
        </xsl:if>

        <div id="{generate-id(.)}" style="display: {$display};" class="table-wrapper {$css}">
            <table cellpadding="0" cellspacing="0">
                <thead>
                    <tr>
                        <xsl:for-each select="column">
                            <th width="{@size}"></th>
                        </xsl:for-each>
                    </tr>
                </thead>
                <tbody>
                    <xsl:apply-templates select="row" />
                </tbody>
            </table>

            <xsl:if test="@style = 'vuln-table'">
                <span onclick="toggle('{generate-id(.)}');" class="button" style="margin-top: 20px">Hide</span>
            </xsl:if>

            <div class="clear" />
        </div>

        <xsl:if test="@style = 'vuln-table'">
            <div style="height: 40px;" />
            <div class="clear" />
        </xsl:if>
    </xsl:template>

    <xsl:template match="row">
        <xsl:variable name="css">
            <xsl:choose>
                <xsl:when test="@style = 'plugin-header'">plugin-row-header</xsl:when>
                <xsl:when test="@style = 'plugin-row'">plugin-row</xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <tr class="{$css}">
            <xsl:apply-templates select="cell" />
        </tr>
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

        <xsl:variable name="twoup">
            <xsl:choose>
                <xsl:when test="@tworows = 'true'">line-height: 17px; vertical-align: middle; padding: 3px;</xsl:when>
                <xsl:otherwise></xsl:otherwise>
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

        <td class="{$sev}" style="{$twoup} {$noterow}" colspan="{$colspan}">
            <xsl:apply-templates select="text" />
            <xsl:apply-templates select="link" />

            <xsl:variable name="margin">
                <xsl:choose>
                    <xsl:when test="@position = '4'">0 0 0 2%</xsl:when>
                    <xsl:when test="@position = '3'">0 1%</xsl:when>
                    <xsl:when test="@position = '2'">0 1%</xsl:when>
                    <xsl:when test="@position = '1'">0 1%</xsl:when>
                    <xsl:otherwise>0</xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:choose>
                <xsl:when test="@style = 'severity-box'">
                    <div style="box-sizing: border-box; font-size: 45px; font-weight: 300; line-height: 80px; color: #fff; text-align: center; background: {$sev}; border-radius: 3px 3px 0 0; width: 98%; margin: {$margin};">
                        <xsl:value-of select="@name" />
                    </div>
                </xsl:when>
                <xsl:when test="@style = 'severity-desc'">
                    <div style="font-size: 10px; text-transform: uppercase; padding: 5px 0; text-align: center; width: 98%; box-sizing: border-box; border-left: 1px solid #ddd; border-right: 1px solid #ddd; border-bottom: 1px solid #ddd; border-radius: 0 0 3px 3px;  margin: {$margin}; margin-bottom: 15px;">
                        <xsl:value-of select="@name" />
                    </div>
                </xsl:when>
                <xsl:when test="@style = 'plugin-name-offline'">
                    <xsl:value-of select="@name" />
                    <span title="Detected during an offline scan." style="color: #999999;">
                        [Offline]
                    </span>
                </xsl:when>
                <xsl:when test="@tworows = 'true'">
                    <xsl:variable name="row1" select="substring-before(@name, ' ')" />
                    <xsl:variable name="row2" select="substring-after(@name, ' ')" />
                        <xsl:value-of select="$row1" />
                        <xsl:text disable-output-escaping="yes">&lt;br&gt;</xsl:text>
                        <xsl:value-of select="$row2" />
                </xsl:when>
                <xsl:when test="@sortcolumn = 'true'">
                    <div style="font-weight: 700">
                        <xsl:value-of select="@name" />
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@name" />
                </xsl:otherwise>
            </xsl:choose>
        </td>
    </xsl:template>

    <xsl:template match="h0">
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

        <xsl:variable name="off">
            <xsl:choose>
                <xsl:when test="@offline = '1'">offline</xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <div id="{generate-id(.)}" style="box-sizing: border-box; width: 100%; margin: 0 0 10px 0; padding: 5px 10px; background: {$sev}; font-weight: 700; font-size: 14px; line-height: 20px; color: #fff;" class="{$off}" onclick="toggleSection('{generate-id(.)}-container');" onmouseover="this.style.cursor='pointer'">
            <xsl:value-of select="@name" />
            <div id="{generate-id(.)}-toggletext" style="float: right; text-align: center; width: 8px;">
                -
            </div>
        </div>

        <div id="{generate-id(.)}-container" style="margin: 0 0 45px 0;" class="section-wrapper">
            <xsl:apply-templates select="h1" />
            <div class="clear" />
        </div>

        <div class="clear" />
    </xsl:template>

    <xsl:template match="h2">
        <h2><xsl:value-of select="@name" /></h2>
        <div class="clear" />

        <xsl:apply-templates select="pre" />
    </xsl:template>

    <xsl:template match="pre">
        <xsl:variable name="margin">
            <xsl:choose>
                <xsl:when test="@style = 'compliance'">40px</xsl:when>
                <xsl:otherwise>20px</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <div style="box-sizing: border-box; width: 100%; background: #eee; font-family: monospace; padding: 20px; margin: 5px 0 {$margin} 0;">
            <xsl:apply-templates select="br" />
            <div class="clear" />
        </div>

        <div class="clear" />
    </xsl:template>

    <xsl:template match="br">
        <xsl:value-of select="." />
        <xsl:if test="not(@last)">
            <br />
        </xsl:if>
    </xsl:template>

    <xsl:template match="link">
        <a href="{@href}" target="_blank"><xsl:value-of select="." /></a>
    </xsl:template>

    <xsl:template match="text">
        <xsl:variable name="sev">
            <xsl:choose>
                <xsl:when test="@severity = '0'">#67ACE1</xsl:when>
                <xsl:when test="@severity = '1'">#F8C851</xsl:when>
                <xsl:when test="@severity = '2'">#F18C43</xsl:when>
                <xsl:when test="@severity = '3'">#DD4B50</xsl:when>
                <xsl:when test="@severity = '4'">#91243E</xsl:when>
                <xsl:otherwise>#FFFFFF</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="@style = 'remediations-desc'">
                <div style="line-height: 20px; padding: 0 0 20px 0;">
                    <xsl:value-of select="." />
                    <div class="clear" />
                </div>
            </xsl:when>
            <xsl:when test="@style = 'plugin-badge'">
                <span style="display: inline-block; width: 60px; text-align: center; text-transform: uppercase; background: {$sev}; font-size: 10px; color: #fff; border-radius: 3px; line-height: 20px;">
                    <xsl:value-of select="." />
                </span>
            </xsl:when>
            <xsl:when test="@style = 'plugin-badge-offline'">
                <span title="Detected during an offline scan." style="display: inline-block; width: 60px; text-align: center; text-transform: uppercase; background: {$sev}; font-size: 10px; color: #fff; border-radius: 3px; line-height: 20px; background-image: -webkit-repeating-linear-gradient(135deg, transparent, transparent 5px, rgba(255, 255, 255, .2) 5px, rgba(255, 255, 255, .2) 10px); background-image: repeating-linear-gradient(135deg, transparent, transparent 5px, rgba(255, 255, 255, .2) 5px, rgba(255, 255, 255, .2) 10px);">
                    <xsl:value-of select="." />
                </span>
            </xsl:when>
            <xsl:when test="@style = 'plugin-details'">
                <div style="line-height: 20px; padding: 0 0 20px 0;">
                    <xsl:apply-templates select="br" />
                    <div class="clear" />
                </div>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="." />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
