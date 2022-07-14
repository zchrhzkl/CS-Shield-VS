<?xml version="1.0" encoding="utf-8"?>
<!--
 (C) 2011, Tenable Network Security, Inc.

 @ReadableName@ = "FO Transformation"
 @Extension@  = "html"
 @MinVersion@ = 5000
 @Hide@ = TRUE
 $Id: report2fo.xsl,v 1.111 2015/09/03 13:32:07 brian Exp $
!-->

<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:fo="http://www.w3.org/1999/XSL/Format">
	  
	<xsl:output method="xml" indent="yes" encoding="utf-8"/>
	
	<xsl:template match="report">
		<fo:root>
			<fo:layout-master-set>
				<fo:simple-page-master master-name="page"
										page-height="29.7cm" 
										page-width="21.0cm" 
										margin="2cm">
					<fo:region-body region-name="body"/>
					<fo:region-before region-name="header"/>
					<fo:region-after region-name="footer"/>
				</fo:simple-page-master>
			</fo:layout-master-set>
			
			<xsl:call-template name="bookmark"/>
			<xsl:call-template name="report_title"/>
			<xsl:call-template name="toc"/>
			
			<xsl:apply-templates select="chapter"/>
		</fo:root>
	</xsl:template>
	
	<xsl:template name="bookmark">
		<fo:bookmark-tree>
			<fo:bookmark internal-destination="table_of_content">
				<fo:bookmark-title font-weight="bold">Table Of Contents</fo:bookmark-title>
			</fo:bookmark>
			<xsl:for-each select="chapter">
				<fo:bookmark internal-destination="{generate-id(.)}">
					<fo:bookmark-title font-weight="bold">
						<xsl:value-of select="@name"/>
					</fo:bookmark-title>
					<xsl:for-each select="section">
						<fo:bookmark internal-destination="{generate-id(.)}">
							<fo:bookmark-title font-weight="bold">
								<xsl:value-of select="@name"/>
							</fo:bookmark-title>
						</fo:bookmark>
					</xsl:for-each>
				</fo:bookmark>
			</xsl:for-each>
		</fo:bookmark-tree>
	</xsl:template>
  
	<xsl:template name="report_title">
		<fo:page-sequence master-reference="page">
		  <xsl:call-template name="add_footer">
		    <xsl:with-param name="value"><xsl:value-of select="@footer"/></xsl:with-param>
		    <xsl:with-param name="color"><xsl:value-of select="@hf_color"/></xsl:with-param>
		  </xsl:call-template>
		  
		  <xsl:call-template name="add_header">
		    <xsl:with-param name="value"><xsl:value-of select="@header"/></xsl:with-param>
		    <xsl:with-param name="color"><xsl:value-of select="@hf_color"/></xsl:with-param>
		  </xsl:call-template>
		
			<fo:flow flow-name="body">
				<fo:block text-align-last="center"
						font-size="30px"
						font-family="Arial, Helvetica, sans-serif"
						font-weight="normal"
						color="#053958"
						space-after="10px">
					<xsl:text>Nessus Report</xsl:text>
				</fo:block>
				<fo:block text-align-last="center"
						font-size="20px"
						font-family="Arial, Helvetica, sans-serif"
						font-weight="normal"
						color="#053958"
					space-after="10px">
					<xsl:value-of select="@name"/>
				</fo:block>
				<fo:block text-align-last="center"
						font-size="20px"
						font-family="Arial, Helvetica, sans-serif"
						font-weight="normal"
						color="#053958"
						space-after="10px">
					<xsl:value-of select="@date"/>
				</fo:block>
				<xsl:if test="@type = 'HomeFeed'">
					<fo:block text-align-last="center"
							font-size="16px"
							font-family="Arial, Helvetica, sans-serif"
							font-weight="normal"
							color="#053958"
							space-before="20px"  
							space-after="10px">
						<xsl:text>Nessus Home: Commercial use of the report is prohibited</xsl:text>
					</fo:block>
					<fo:block text-align-last="left"
							font-size="12px"
							font-family="Arial, Helvetica, sans-serif"
							font-weight="normal"
							color="#69737b"
							space-after="10px">
						<xsl:text>Any time Nessus is used in a commercial environment you MUST maintain an active subscription to the Nessus Feed in order to be compliant with our license agreement: </xsl:text>
						<fo:basic-link external-destination="url(http://www.tenable.com/products/nessus)">
							<xsl:text>http://www.tenable.com/products/nessus</xsl:text>
						</fo:basic-link>
						
					</fo:block>
				</xsl:if>

			</fo:flow>
		</fo:page-sequence>
	</xsl:template>
  
	<xsl:template name="toc">		
		<fo:page-sequence master-reference="page" id="table_of_content">
		  <xsl:call-template name="add_footer">
		    <xsl:with-param name="value"><xsl:value-of select="@footer"/></xsl:with-param>
		    <xsl:with-param name="color"><xsl:value-of select="@hf_color"/></xsl:with-param>
		  </xsl:call-template>
		  
		  <xsl:call-template name="add_header">
		    <xsl:with-param name="value"><xsl:value-of select="@header"/></xsl:with-param>
		    <xsl:with-param name="color"><xsl:value-of select="@hf_color"/></xsl:with-param>
		  </xsl:call-template>
		
			<fo:flow flow-name="body">
				<fo:block text-align-last="center"
						font-size="20px"
						font-family="Arial, Helvetica, sans-serif"
						font-weight="normal"
						color="#053958"
						space-after="10px">
					<xsl:text>Table Of Contents</xsl:text>
				</fo:block>
			
				<xsl:for-each select="chapter">
					<fo:block text-align-last="justify"
						font-size="12px"
						font-family="Arial, Helvetica, sans-serif"
						font-weight="normal"
						color="#053958"
						space-before="4px"
						space-after="2px">
						<fo:basic-link internal-destination="{generate-id(.)}">
							<xsl:value-of select="@name"/>
							<fo:leader leader-pattern="dots"/> 
							<fo:page-number-citation ref-id="{generate-id(.)}"/>
						</fo:basic-link>
					</fo:block>
					<xsl:for-each select="section">
						<xsl:variable name="sev">
							<xsl:choose>
								<xsl:when test="@severity = '0'">#357abd</xsl:when>
								<xsl:when test="@severity = '1'">#4cae4c</xsl:when>
								<xsl:when test="@severity = '2'">#fdc431</xsl:when>
								<xsl:when test="@severity = '3'">#ee9336</xsl:when>
								<xsl:when test="@severity = '4'">#d43f3a</xsl:when>
								<xsl:otherwise>#69737b</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<fo:block text-align-last="justify"
							margin-left="2em"
							font-size="9px"
							font-family="Arial, Helvetica, sans-serif"
							font-weight="normal"
							color="#69737b">
							<fo:inline font-size="14px" color="{$sev}">&#x2022;</fo:inline>
							<fo:basic-link internal-destination="{generate-id(.)}">
								<xsl:value-of select="@name"/>
								<fo:leader leader-pattern="dots"/> 
								<fo:page-number-citation ref-id="{generate-id(.)}"/>
							</fo:basic-link>
						</fo:block>
					</xsl:for-each>
				</xsl:for-each>
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>
  
	<xsl:template match="chapter">
	
		<fo:page-sequence master-reference="page">
		  <xsl:call-template name="add_footer">
		    <xsl:with-param name="value"><xsl:value-of select="../@footer"/></xsl:with-param>
		    <xsl:with-param name="color"><xsl:value-of select="../@hf_color"/></xsl:with-param>
		  </xsl:call-template>
		  
		  <xsl:call-template name="add_header">
		    <xsl:with-param name="value"><xsl:value-of select="../@header"/></xsl:with-param>
		    <xsl:with-param name="color"><xsl:value-of select="../@hf_color"/></xsl:with-param>
		  </xsl:call-template>
		
			<fo:flow flow-name="body">
				<fo:block 
					id="{generate-id(.)}"
					space-after="1cm"
					font-size="20px"
					font-family="Arial, Helvetica, sans-serif"
					font-weight="bold"
                    			color="#ffffff" 
					text-align="center"
                    background-color="#053958">
					<xsl:value-of select="@name"/>
				</fo:block>
			</fo:flow>
		</fo:page-sequence>
	  
		<xsl:if test="section">
					<xsl:apply-templates select="section"/>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="section">
		<fo:page-sequence master-reference="page">
		
		<xsl:call-template name="add_footer">
		  <xsl:with-param name="value"><xsl:value-of select="../../@footer"/></xsl:with-param>
		  <xsl:with-param name="color"><xsl:value-of select="../../@hf_color"/></xsl:with-param>
		  <xsl:with-param name="page-number">on</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="add_header">
		  <xsl:with-param name="value"><xsl:value-of select="../../@header"/></xsl:with-param>
		  <xsl:with-param name="color"><xsl:value-of select="../../@hf_color"/></xsl:with-param>
		</xsl:call-template>
		
		<fo:flow flow-name="body">
		<xsl:variable name="sev">
			<xsl:choose>
				<xsl:when test="@bgcolor = 'off'">#053958</xsl:when>
                                     <xsl:when test="@severity = '0'">#357abd</xsl:when>
                                     <xsl:when test="@severity = '1'">#4cae4c</xsl:when>
                                     <xsl:when test="@severity = '2'">#fdc431</xsl:when>
                                     <xsl:when test="@severity = '3'">#ee9336</xsl:when>
                                     <xsl:when test="@severity = '4'">#d43f3a</xsl:when>
				<xsl:otherwise>#053958</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<fo:block 
			  id="{generate-id(.)}"
			  font-size="10px"
             		  font-family="Arial, Helvetica, sans-serif"
			  font-weight="bold"
			  color="#FFFFFF"
			  padding="0 10px"
			  margin-top="20px"
			  text-align="left"
			  height="25px"
			  background-color="{$sev}">
			<xsl:value-of select="@name"/>
		</fo:block>
		
		
		<xsl:apply-templates select="table"/>
		<xsl:apply-templates select="h1"/>
		
		<xsl:if test="@page-break = 'end'">
			<fo:block page-break-after="always"/>
		</xsl:if>

		</fo:flow>
		</fo:page-sequence>

	</xsl:template>
	
	<xsl:template name="add_footer">
	        <xsl:param name="color" />
	        <xsl:param name="value" />
	        <xsl:param name="page-number" />
		<fo:static-content flow-name="footer">
		    <xsl:if test="$page-number = 'on'">
			<fo:block font-size="10px"
					  font-family="Arial, Helvetica, sans-serif"
					  padding="5 10px"
					  margin-top="5px"
			          	  text-align="end"
					  height="25px"
					  color="grey"
					  border-top-color="grey"
					  border-top-style="solid"
					  border-top-width="thin">
				<fo:page-number/>
			</fo:block>
		    </xsl:if>
		    <fo:block font-size="10px"
					  font-family="Arial, Helvetica, sans-serif"
					  text-align="center"
					  font-weight="bold"
                    			  color="{$color}" 
					  >
		      <xsl:value-of select="$value"/>
		    </fo:block>
		</fo:static-content>
        </xsl:template>

	<xsl:template name="add_header">
	        <xsl:param name="color" />
	        <xsl:param name="value" />
		<fo:static-content flow-name="header">
		  <fo:block font-size="10px"
			    margin-top="-1cm"
			    font-family="Arial, Helvetica, sans-serif"
			    text-align="center"
			    font-weight="bold"
                    	    color="{$color}" 
			    >
		    <xsl:value-of select="$value"/>
		  </fo:block>
		</fo:static-content>
        </xsl:template>

	<xsl:template match="subsection">
		<xsl:variable name="sev">
			<xsl:choose>
                                     <xsl:when test="@severity = '0'">#357abd</xsl:when>
                                     <xsl:when test="@severity = '1'">#4cae4c</xsl:when>
                                     <xsl:when test="@severity = '2'">#fdc431</xsl:when>
                                     <xsl:when test="@severity = '3'">#ee9336</xsl:when>
                                     <xsl:when test="@severity = '4'">#d43f3a</xsl:when>
				<xsl:otherwise>#9ab3cc</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<fo:block font-size="10px"
				font-family="Arial, Helvetica, sans-serif"
				font-weight="bold"
				color="#FFFFFF"
				padding="0 10px"
				margin-top="2px"
				margin-bottom="0px"
				text-align="left"
				height="25px"
				background-color="{$sev}">
			<xsl:value-of select="@name"/>
		</fo:block>
		
		<xsl:apply-templates select="h0"/>

	</xsl:template>
	
	<xsl:template match="h0">
		<xsl:variable name="sev">
			<xsl:choose>
                                     <xsl:when test="@severity = '0'">#357abd</xsl:when>
                                     <xsl:when test="@severity = '1'">#4cae4c</xsl:when>
                                     <xsl:when test="@severity = '2'">#fdc431</xsl:when>
                                     <xsl:when test="@severity = '3'">#ee9336</xsl:when>
                                     <xsl:when test="@severity = '4'">#d43f3a</xsl:when>
				<xsl:when test="@severity = '99'">#dadada</xsl:when>
				<xsl:otherwise>#eef2f3</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<fo:block font-size="10px"
				font-family="Arial, Helvetica, sans-serif"
				font-weight="bold"
				color="#ffffff"
				padding="0 10px"
				margin-top="0px"
				margin-bottom="0px"
				text-align="left"
				height="25px"
				background-color="{$sev}">
			<xsl:value-of select="@name"/>
		</fo:block>
		
		<xsl:apply-templates select="h1"/>
	</xsl:template>
	
	<xsl:template match="h1">
		<xsl:variable name="sev">
			<xsl:choose>
                                     <xsl:when test="@severity = '0'">#357abd</xsl:when>
                                     <xsl:when test="@severity = '1'">#4cae4c</xsl:when>
                                     <xsl:when test="@severity = '2'">#fdc431</xsl:when>
                                     <xsl:when test="@severity = '3'">#ee9336</xsl:when>
                                     <xsl:when test="@severity = '4'">#d43f3a</xsl:when>
				<xsl:when test="@severity = '99'">#dadada</xsl:when>
				<xsl:otherwise>#eef2f3</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<fo:block font-size="10px"
				font-family="Arial, Helvetica, sans-serif"
				font-weight="bold"
				color="#053958"
				padding="0 10px"
				text-align="left"
				height="25px"
				background-color="{$sev}">
			<xsl:value-of select="@name"/>
		</fo:block>
		
		<xsl:apply-templates select="subsection"/>
		<xsl:apply-templates select="h2"/>
		<xsl:apply-templates select="text"/>
		<xsl:apply-templates select="table"/>
		<xsl:apply-templates select="link"/>
	</xsl:template>
	
	<xsl:template match="table">
		<fo:table  table-layout="fixed" width="100%">
			<xsl:apply-templates select="column"/>
		
			<fo:table-body>
				<xsl:apply-templates select="row"/>
			</fo:table-body>
		</fo:table>
	</xsl:template>
	
	<xsl:template match="column">
		<fo:table-column column-width="{@size}"/>
	</xsl:template>
	
	<xsl:template match="row">
		<fo:table-row 					  
		   border-bottom-color="white"
		   border-bottom-style="solid"
		   border-bottom-width="thick">
>
			<xsl:apply-templates select="cell"/>
		</fo:table-row>
	</xsl:template>
	
	<xsl:template match="cell">
		<xsl:variable name="sev">
			<xsl:choose>
                                     <xsl:when test="@severity = '0'">#357abd</xsl:when>
                                     <xsl:when test="@severity = '1'">#4cae4c</xsl:when>
                                     <xsl:when test="@severity = '2'">#fdc431</xsl:when>
                                     <xsl:when test="@severity = '3'">#ee9336</xsl:when>
                                     <xsl:when test="@severity = '4'">#d43f3a</xsl:when>
				<xsl:otherwise>#ffffff</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<fo:table-cell>
			<xsl:if test="@background">
				<xsl:attribute name="background-color"><xsl:value-of select="@background"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@severity">
				<xsl:attribute name="background-color"><xsl:value-of select="$sev"/></xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="pre"/>
			<xsl:apply-templates select="text"/>
			<xsl:apply-templates select="link"/>
		</fo:table-cell>
	</xsl:template>
	
	<xsl:template match="h2">
		<xsl:variable name="color">
			<xsl:choose>
				<xsl:when test="@color"><xsl:value-of select="@color"/></xsl:when>
				<xsl:otherwise>#053958</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
	
		<fo:block font-size="10px"
			  font-family="Arial, Helvetica, sans-serif"
			  font-weight="bold"
			  color="{$color}"
			  padding="0 10px"
			  text-align="left"
			  height="25px"
			  background-color="#f8f8f8">
			<xsl:value-of select="@name"/>
		</fo:block>
		
		<xsl:apply-templates select="pre"/>
	</xsl:template>
	
	<xsl:template match="text">
		<xsl:variable name="color">
			<xsl:choose>
				<xsl:when test="@color"><xsl:value-of select="@color"/></xsl:when>
				<xsl:otherwise>#053958</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="weight">
			<xsl:choose>
				<xsl:when test="@type"><xsl:value-of select="@type"/></xsl:when>
				<xsl:otherwise>normal</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<fo:block font-size="9px"
				font-family="Arial, Helvetica, sans-serif"
				font-weight="{$weight}"
				color="{$color}"
				padding="0 10px"
				margin-left="1px"
				margin-top="5px"
				margin-bottom="5px"
				text-align="left"
				height="20px">
		    <xsl:choose>
		    <xsl:when test="@br">
			<xsl:apply-templates select="br"/>
		    </xsl:when>
		    <xsl:otherwise>
		        <xsl:value-of select="."/>
		    </xsl:otherwise>
		    </xsl:choose>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="pre">
		<fo:block font-size="8px"
              font-family="Courier New, Courier, monospace"
			  font-weight="normal"
			  color="black"
			  padding="0 10px"
			  margin-left="1px"
			  margin-top="5px"
			  margin-bottom="5px"
			  text-align="left"
			  height="20px"
			  white-space-treatment="preserve"
			  white-space-collapse="false">
			<xsl:apply-templates select="br"/>
		</fo:block>
	</xsl:template>


	<xsl:template match="br">
		<xsl:value-of select="."/>
		<xsl:if test="not(@last)">
			<fo:block />
		</xsl:if>
	</xsl:template>
 
	<xsl:template match="link">
		<fo:block font-size="9px"
				font-family="Arial, Helvetica, sans-serif"
				font-weight="normal"
				color="#69737b"
				padding="0 10px"
				margin-left="1px"
				margin-top="5px"
				margin-bottom="5px"
				text-align="left"
				height="20px">
			<fo:basic-link external-destination="url({@href})">
				<xsl:value-of select="."/>
			</fo:basic-link>
		</fo:block>
	</xsl:template>
	
	
	
</xsl:stylesheet>
