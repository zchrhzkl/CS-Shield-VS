<?xml version="1.0" encoding="utf-8"?>
<!--
 (C) 2011, Tenable Network Security, Inc.

 @ReadableName@ = "HTML Transformation"
 @Extension@  = "html"
 @MinVersion@ = 5000
 @Hide@ = TRUE
 $Id: report2html.xsl,v 1.110 2015/09/03 13:32:07 brian Exp $
!-->
<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	  
	<xsl:output method="html" indent="yes" encoding="utf-8"/>
	
	<xsl:template match="report">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
		<title><xsl:value-of select="@name"/></title>
		<style type="text/css" media="all">
	UL.ulist {padding: 0 10px; line-height:25px; margin-bottom:0px; margin-top:0px;};
	LI.list  {padding: 0 10px; line-height:25px; margin-bottom:0px; margin-top:0px; list-style: disc;}
	LI.list0 {padding: 0 10px; line-height:25px; margin-bottom:0px; margin-top:0px; list-style: disc; color:#357abd;}
	LI.list1 {padding: 0 10px; line-height:25px; margin-bottom:0px; margin-top:0px; list-style: disc; color:#4cae4c;}
	LI.list2 {padding: 0 10px; line-height:25px; margin-bottom:0px; margin-top:0px; list-style: disc; color:#fdc431;}
	LI.list3 {padding: 0 10px; line-height:25px; margin-bottom:0px; margin-top:0px; list-style: disc; color:#ee9336;}
	LI.list4 {padding: 0 10px; line-height:25px; margin-bottom:0px; margin-top:0px; list-style: disc; color:#d43f3a;}

	html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, embed, figure, figcaption, footer, header, hgroup, menu, nav, output, ruby, section, summary, time, mark, audio, video {
		margin: 0;
		padding: 0;
		border: 0;
		font-size: 100%;
		font: inherit;
		vertical-align: baseline;
		-webkit-text-size-adjust: none;
	}
    
	html, body {
		font-family: helvetica, arial, sans-serif;
		width: 100%;
		color: #263645;
		font-size: 12px;
		background: #efefef;
	}

	a, a:visited, a:active {
		color: #004a97;
	}

	a:hover {
		color: #00253d;
	}

	.container_16 {
		margin: 0 auto;
		padding: 0 14px 14px 14px;
		background: #fff;
		border-top: #425363 solid 7px;
		box-shadow: 0 2px 10px rgba(0, 0, 0, .2);
		margin-bottom: 20px;
		border-radius: 0 0 5px 5px;
	}

	#reportContent {
		width: 100%;
	}

	h1.classtitle {
		padding: 15px 0 10px 0;
		border-bottom: 1px dotted #ccc;
		margin: 0 0 15px 0;
	}

	h2.classtitle {
		color: #00a5b5;
		font-weight: normal;
		font-size: 22px;
		margin: 0;
		padding: 0;
	}
	
	h2.date {
		font-size: 14px;
		color: #768591;
		margin: 0;
		padding: 0;
		font-weight: normal;
	}
	
	.reportinfo {
		display: block;
		width: 100%;
		font-size: 16px;
		padding: 0 0 15px 0;
		margin: 0 0 5px 0;
		font-weight: normal;
		border-bottom: 1px dotted #ccc;
	}
	
	.reportpadding {
		padding: 15px 0 0 0 !important;
	}
	
	.classtoc {
		display: block;
		font-size: 18px;
		color: #777779;
		padding: 15px 0;
		margin: 15px 0 0 0;
	}

	h1.classchapter {
		background: #425363;
		color: #fff;
		font-weight: bold;
		font-size: 16px;
		padding: 6px 10px;
		margin: 10px 0 0 0;
		border-radius: 4px 4px 0 0;
	}

	h2.classsection {
		display: block;
		background: #425363;
		color: #fff;
		font-weight: bold;
		font-size: 14px;
		padding: 6px 10px;
		margin: 30px 0 0 0;
		border-radius: 4px 4px 0 0;
	}

	h2.classh1  {
		display: block;
		background: #efefef;
		font-weight: bold;
		font-size: 13px;
		padding: 6px 10px;
	}

	.classtext {
		font-size: 13px;
		line-height: 18px;
	}
	
	div#reportContent div span.classtext {
		padding: 6px 10px;
		display: inline-block;
	}

	h2.classsubsection {
		background: #768591;
		color: #fff;
		font-weight: bold;
		font-size: 13px;
		padding: 6px 10px;
	}
	
	.classheader h1 {
		color: #fff;
		font-weight: bold;
		font-size: 15px;
		padding: 0 10px;
		text-align: center;
	}
	
	.reportinfo b {
		font-weight: bold;
	}
	
	h3.classtitle  {
		color: #69737b;
		font-size: 16px;
		padding: 0 10px;
	}
	
	.classsection_sub tr, td {
		color: #053958;
		font-size: 13px;
		padding: 0 10px;
	}
	
	td {
		padding: 6px 10px;
	}
	
	h2.classsection, h2.classsection0, h2.classsection1, h2.classsection2, h2.classsection3, h2.classsection4 {
		background: #053958;
		color: #fff;
		font-weight: bold;
		font-size: 13px;
		padding: 6px 10px;
		margin-bottom: 0px;
		margin-top: 10px;
	}
	
	.classcell4, h2.classsection4 {
		background-color: #d43f3a;
	}

	.classcell3, h2.classsection3 {
		background-color: #ee9336;
	}

	.classcell2, h2.classsection2 {
		background-color: #fdc431;
	}

	.classcell1, h2.classsection1 {
		background-color: #4cae4c;
	}

	.classcell0, h2.classsection0 {
		background-color: #357abd;
	}

	
	#copyright {
		display: block;
		width: 100%;
		text-align: center;
		font-size: 12px;
		color: #A9A8A9;
		padding: 6px 0 20px 0;
	}
	
	#copyright a, #copyright a:visited, #copyright a:active {
		color: #A9A8A9;
	}
	
	div.icon {
		display: none;
	}
	
	.nopadding {
		padding: 0 !important;
	}
	
	body.email h2.classh1 {
		display: block;
		margin: 20px 0 0 0;
		background: #425363;
		color: #fff;
		font-weight: bold;
		font-size: 14px;
		padding: 6px 10px;
		border-radius: 4px 4px 0 0;
	}
	
	body.email div#reportContent div span.classtext {
		padding: 0;
		display: inline;
	}
	
	body.email h2.tips {
		background: #004a97 !important;
	}
	
	body.email h2.errors {
		background: #c00 !important;
	}
	
	body.email h2.classsection {
		display: none;
	}
	
	.classtoc1 a {
		font-size: 16px;
	}
				
	.classtoc2 a {
		font-size: 13px;
		padding: 0 20px;
	}
	
	h2.classh2  {
		background: #f8f8f8;
		font-weight: bold;
		font-size: 13px;
		padding: 6px 10px;
	}
	
	.classpre {
		display: block;
		font-size: 13px;
		font-family: Courier New, Courier, monospace;
		padding: 10px;
		color: #000;
	}
	
	.classh1_grey h2 {
		background: #eaeaea;
		color:#053958;
		font-size: 13px;
		padding: 0 10px;
		margin-top:0px;
		margin-bottom:2px;
	}
 	
	@media only screen and (max-device-width: 480px) {
		html, body {
			display: block;
			min-width: 480px;
			background: #fff;
		}
		
		table {
			table-layout: auto !important;
		}
		
		table td {
			word-wrap: break-word;
		}
		
		table.container_16 {
			width: 100%;
			padding: 0 4% 20px 4%;
			background: #fff;
			border-top: #425363 solid 7px;
			box-shadow: none !important;
			margin-bottom: 20px;
			border-radius: 0;
		}
		
		#copyright {
			display: block;
			width: 90%;
			text-align: center;
			font-size: 10px;
			color: #A9A8A9;
			padding: 5px 0 20px 0;
			border-top: 1px dotted #ccc;
			margin: 0 auto;
			line-height: 16px;
		}
		
		.classtitle img {
			display: block;
			margin: 0 auto;
		}
	}
</style>

<xsl:if test="@toc = 'on'">
	<script type="text/javascript">
		<xsl:text>
		function toggle(divId) {
			var divObj = document.getElementById(divId);
			if (divObj) {
				var displayType = divObj.style.display;
				if (displayType == "" || displayType == "block") {
					divObj.style.display = "none";
				} else {
					divObj.style.display = "block";
				}
			}
		}

		function ceall(flag) {
			var divs = document.getElementsByTagName("div");
			var i = 0;
			for (i = 0; i &lt; divs.length; i++) {
				if (divs[i].getAttribute("id") != null &amp;&amp; divs[i].getAttribute("id").match('btag-')) {
					if (flag == 0) {
						divs[i].style.display = "none";
					} else {
						divs[i].style.display = "block";
					}
				}
			}
		}
		</xsl:text>
	</script>
</xsl:if>
		</head>
		<xsl:variable name="bodyStyle">
			<xsl:choose>
				<xsl:when test="@toc = 'on'"></xsl:when>
				<xsl:otherwise>email</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<body class="{$bodyStyle}">
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
				<tr>
					<td align="center" valign="top" class="nopadding" style="vertical-align: top">
						<table cellpadding="0" cellspacing="0" border="0" width="80%" bgcolor="#FFFFFF" class="container_16">
							<tr>
								<td>
									<xsl:if test="string-length(@header) != 0"><span class="classheader"><h1 style="background:{@hf_color};"><font color="#ffffff"><xsl:value-of select="@header"/></font></h1></span></xsl:if>
									<xsl:call-template name="report_title"/>
									<div id="reportContent">
										<xsl:if test="@toc = 'on'">
											<xsl:call-template name="toc"/>
										</xsl:if>
										<xsl:apply-templates select="chapter"/>
									</div>
									<xsl:if test="string-length(@footer) != 0"><span class="classheader"><h1 style="background:{@hf_color};"><xsl:value-of select="@footer"/></h1></span></xsl:if>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<div id="copyright">
				<xsl:apply-templates select="copyright"/>
			</div>
		</body>
		</html>
	</xsl:template>
	
	<xsl:template name="report_title">
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<td class="nopadding"><h1 class="classtitle"><img src="{@logo}" width="247" height="68" border="0" alt="Nessus Report" style="display: block;" /></h1></td>
			</tr>
			<tr>
				<td class="nopadding"><h2 class="classtitle"><xsl:value-of select="@name"/></h2></td>
			</tr>
			<tr>
				<td class="nopadding"><h2 class="date"><xsl:value-of select="@date"/></h2></td>
			</tr>
			<tr>
				<td class="reportpadding">
					<div class="reportinfo">
						<xsl:apply-templates select="report_info"/>
					</div>
				</td>
			</tr>
			<xsl:if test="@type = 'HomeFeed'">
				<tr>
					<td>
						<h2 class="classtitle"><xsl:text>Nessus Home: Commercial use of the report is prohibited</xsl:text></h2>
						<h3 class="classtitle">
							<xsl:text>Any time Nessus is used in a commercial environment you MUST maintain an active subscription to the Nessus Feed in order to be compliant with our license agreement.</xsl:text>
							<a href="http://www.tenable.com/products/nessus" target="_blank"><xsl:text>http://www.tenable.com/products/nessus</xsl:text></a>
						</h3>
					</td>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>
	
	<xsl:template name="toc">
		<span class="classtoc">
			<xsl:text>Table Of Contents</xsl:text>
		</span>
		
		<table>
			<xsl:for-each select="chapter">
				<tr>
					<td>
						<span class="classtoc1"><a href="#{generate-id(.)}"><xsl:value-of select="@name"/></a></span>
					</td>
				</tr>
				<tr>
					<td>
						<table>
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
								<tr>
									<td width="5%">
										<table style="table-layout: fixed;" width="10px" height="10px" >
											<tr>
												<td class="nopadding {$sev}"></td>
											</tr>
										</table>
									</td>
									<td width="95%">
										<a href="#{generate-id(.)}">
											<xsl:value-of select="@name"/>
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
			<h1 class="classchapter" id="{generate-id(.)}"><xsl:value-of select="@name"/></h1>
			<table>
				<tr  width="100%" onclick="ceall(0)" onmouseover="this.style.cursor='pointer'" title="Collapse">
					<td align="left" width="100%">[-] Collapse All</td>
				</tr>
				<tr  width="100%" onclick="ceall(1)" onmouseover="this.style.cursor='pointer'" title="Expand">
					<td align="left" width="100%">[+] Expand All</td>
				</tr>
			</table>
		</xsl:if>
		<xsl:apply-templates select="section"/>
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
		<h2 class="{$sev}" id="{generate-id(.)}"><xsl:value-of select="@name"/></h2>
		<xsl:apply-templates select="table"/>
		<xsl:apply-templates select="h1"/>
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

		<h2 class="{$sev} {@id}">
			<xsl:value-of select="@name"/>
		</h2>

		<xsl:apply-templates select="h0"/>
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
		<xsl:variable name="id"><xsl:text>btag-</xsl:text><xsl:value-of select="../../../@name"/>-<xsl:value-of select="../@name"/>-<xsl:value-of select="substring-before(@name,'-')"/></xsl:variable>

		<span class="classh1_grey">
			<h2>
				<span class="classsection_sub">
					<table width="100%">
						<tr  width="100%" onclick="toggle('{$id}')" onmouseover="this.style.cursor='pointer'" title="Collapse/Expand">
							<td width="5%" height="50%">
								<table style="table-layout: fixed;" width="30px" height="15px">
									<tr width="100%">
										<td width="100%" class="{$sev}"></td>
									</tr>
								</table>
							</td>
							<td align="left" width="85%"><xsl:value-of select="@name"/></td>
							<td align="right" width="10%"><xsl:text>[-/+]</xsl:text></td>
						</tr>
					</table>
				</span>
			</h2>
		</span>
		<div id="{$id}" style="display: none;">
			<xsl:apply-templates select="h1"/>
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
		
		<h2 class="{$sev} {@id}" style="vertical-align: middle;">
			<xsl:text disable-output-escaping="yes">&lt;!--[if mso]&gt;</xsl:text>
				<img src="cid:#" width="1" height="25" border="0" style="display: block; float: left;" /> &#160;
			<xsl:text disable-output-escaping="yes">&lt;![endif]]]--&gt;</xsl:text>
			
			<xsl:if test="@id = 'tips' or @id = 'errors'">
				<img src="{@img}" width="20" height="20" border="0" style="display: block; float: left; margin: -2px 10px 0 0;" />
			</xsl:if>
			<xsl:value-of select="@name"/>
		</h2>
			
		<xsl:apply-templates select="subsection"/>
		<xsl:apply-templates select="h2"/>
		<xsl:apply-templates select="text"/>
		<xsl:apply-templates select="table"/>
	</xsl:template>

	<xsl:template match="h1[@id='remediations']/table">
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<xsl:apply-templates select="row"/>
		</table>
	</xsl:template>
	
	<xsl:template match="h1[@id='hosts']/table">
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<xsl:apply-templates select="row"/>
		</table>
	</xsl:template>
	
	<xsl:template match="h1[@id='tips']/table">
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<xsl:apply-templates select="row"/>
		</table>
	</xsl:template>
	
	<xsl:template match="h1[@id='plugins']/table">
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<xsl:apply-templates select="row"/>
		</table>
	</xsl:template>
	
	<xsl:template match="table">
		<table width="100%">
			<xsl:apply-templates select="row"/>
		</table>
	</xsl:template>
	
	<xsl:template match="h1[@id='remediations']/text">
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<td style="padding: 10px 0 10px 10px !important; margin: 0 0 5px 0; font-weight: bold; font-size: 13px; border-bottom: 1px dotted #ddd;">
					<xsl:value-of select="."/>
				</td>
			</tr>
		</table>
	</xsl:template>
	
	<xsl:template match="h1[@id='remediations']/table/row[@class='number']">
		<xsl:variable name="ledger">
			<xsl:choose>
				<xsl:when test="position() mod 2 = 0">#eeeeee</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<tr bgcolor="{$ledger}">
			<xsl:apply-templates select="cell"/>
		</tr>
	</xsl:template>
	
	<xsl:template match="h1[@id='hosts']/table/row">
		<xsl:variable name="ledger">
			<xsl:choose>
				<xsl:when test="position() mod 2 = 0">#eeeeee</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<tr bgcolor="{$ledger}">
			<xsl:apply-templates select="cell"/>
		</tr>
	</xsl:template>
	
	<xsl:template match="h1[@id='tips']/table/row">
		<xsl:variable name="ledger">
			<xsl:choose>
				<xsl:when test="position() mod 2 = 0">#eeeeee</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<tr bgcolor="{$ledger}">
			<xsl:apply-templates select="cell"/>
		</tr>
	</xsl:template>
	
	<xsl:template match="h1[@id='plugins']/table/row">
		<xsl:variable name="ledger">
			<xsl:choose>
				<xsl:when test="position() mod 2 = 0">#eeeeee</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<tr bgcolor="{$ledger}">
			<xsl:apply-templates select="cell"/>
		</tr>
	</xsl:template>
	
	<xsl:template match="h1[@id='remediations']/table/row/cell">
		<td width="{@width}" valign="top" style="padding: 10px 10px !important; border-bottom: 1px dotted #ddd;">
			<xsl:apply-templates select="text"/>
		</td>
	</xsl:template>
	
	<xsl:template match="h1[@id='hosts']/table/row/cell">
		<td width="{@width}" valign="top" style="padding: 6px 10px !important; border-bottom: 1px dotted #ddd;">
			<xsl:apply-templates select="pre"/>
			<xsl:apply-templates select="text"/>
			<xsl:apply-templates select="link"/>
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
		<td width="{@width}" valign="top" class="{$sev}" style="padding: 6px 10px !important; border-bottom: 1px dotted #ddd;">
			<xsl:apply-templates select="pre"/>
			<xsl:apply-templates select="text"/>
			<xsl:apply-templates select="link"/>
		</td>
	</xsl:template>
	
	<xsl:template match="row">
		<tr>
			<xsl:apply-templates select="cell"/>
		</tr>
	</xsl:template>
	
	<xsl:template match="h1[@id='tips']/table/row/cell">
		<td width="{@width}" valign="top" style="padding: 6px 10px !important; border-bottom: 1px dotted #ddd;">
			<xsl:choose>
				<xsl:when test="@severity">
					<xsl:apply-templates select="text"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="tip"/>
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
		<td width="{@width}" valign="top" class="{$sev}">
			<xsl:apply-templates select="pre"/>
			<xsl:apply-templates select="text"/>
			<xsl:apply-templates select="link"/>
		</td>
	</xsl:template>
	
	<xsl:template match="h2">
		<xsl:variable name="color">
			<xsl:choose>
				<xsl:when test="@color"><xsl:value-of select="@color"/></xsl:when>
				<xsl:otherwise>#263645</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
	
		<h2 class="classh2" style="color: {$color}"><xsl:value-of select="@name"/></h2>
		
		<xsl:apply-templates select="pre"/>
	</xsl:template>
	
	<xsl:template match="pre">
		<span class="classpre">
			<xsl:apply-templates select="br"/>
		</span>
	</xsl:template>

	<xsl:template match="br">
		<xsl:value-of select="."/>
		<xsl:if test="not(@last)">
			<br />
		</xsl:if>
	</xsl:template>

	<xsl:template match="link">
		<xsl:text> </xsl:text><a href="{@href}" target="_blank"><xsl:value-of select="."/></a>
	</xsl:template>
	
	<xsl:template match="text">
		<xsl:variable name="color">
			<xsl:choose>
				<xsl:when test="@color"><xsl:value-of select="@color"/></xsl:when>
				<xsl:otherwise>#263645</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="weight">
			<xsl:choose>
				<xsl:when test="@type = 'bold'">font-weight: bold !important;</xsl:when>
				<xsl:when test="@type = 'italic'">font-style: italic !important;</xsl:when>
				<xsl:otherwise>font-weight: normal;</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<span class="classtext" style="color: {$color}; {$weight}">
			<xsl:choose>
				<xsl:when test="@br">
					<xsl:apply-templates select="br"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</span>
	</xsl:template>
	
	<xsl:template match="copyright/text">
		<xsl:choose>
			<xsl:when test="@br">
				<xsl:value-of select="."/><br />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="report_info/text">
		<xsl:choose>
			<xsl:when test="@type = 'bold'">
				<b><xsl:value-of select="."/></b>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
