<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:import href="../utilities/date-time.xsl" />

<xsl:output
	method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="yes"
/>

<xsl:template match="/">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="author" content="Adrian Kummerländer" />
	<meta name="description" content="Seite von Adrian Kummerländer über Linux, Open Source und anderes"/> 
	<meta name="robots" content="all"/>
	<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
	
	<title>/home/adrian</title>
	<link rel="stylesheet" type="text/css" href="{$workspace}/main.css" />
	<xsl:comment><![CDATA[[if lte IE 8]><link rel="stylesheet" type="text/css" href="]]><xsl:value-of select="$workspace"/><![CDATA[/dirty.css" /><![endif]]]></xsl:comment>
	<link rel="shortcut icon" type="image/x-icon" href="{$root}/favicon.ico" />
	<meta name="google-site-verification" content="H-CBt2da-t_5xp0y1pA9l-IrRZymCFwizuyYKj3ufeA" />
</head>
<body>
	<div id="wrapper">
		<div id="content">
			<div id="nav_wrap">
				<h1>/home/adrian</h1>
				<ul>
					<li><a href="{$root}">Start</a></li>
					<li><a href="{$root}/archiv">Archiv</a></li>
					<li><a href="{$root}/projekte">Projekte</a></li>
					<li><a href="{$root}/seiten/kontakt">Kontakt</a></li>
					<li class="last_item"><a href="{$root}/rss">RSS</a></li>
				</ul>
			</div>
			<div id="main" class="archiv">
					<div class="left articlelist archivlist">
						Bisherige Artikel:
						<ol>
							<xsl:apply-templates select="/data/articles-archiv/year" />
						</ol>
					</div>
					<div class="right taglist archivtag">
						<div class="articlelist commentlist">
							Zuletzt kommentiert:
							<ol>
								<xsl:apply-templates select="/data/articles-comments/entry[@comments != 0][position() &lt;= 5]" />
							</ol>
						</div>
						<div>
							Schlagwörter:
							<xsl:call-template name="tag-cloud">
								<xsl:with-param name="tags" select="data/articlesschema/*[name()='tags']//option" />
							</xsl:call-template>
						</div>
						<div>
							<a href="https://twitter.com/#!/KnairdA">Microblog:</a>
							<ul class="tweetlist">
								<xsl:apply-templates select="/data/twitter/tweets/item[substring(text, 1, 1) != '@'][position() &lt;= 7]" />
							</ul>
						</div>
					</div>
				</div>
				<div id="last_line">
					<a href="http://symphony-cms.com/">Gemacht mit Symphony</a>
					<ul>
						<li><a href="{$root}/seiten/kontakt">Kontakt</a></li>
						<li class="last_item"><a href="{$root}/rss">RSS</a></li>
					</ul>
				</div>
			</div>
	</div>
</body>
</html>
</xsl:template>
  
<xsl:template match="/data/articles-comments/entry">
	<li><a href="{$root}/artikel/{title/@handle}">
		<xsl:value-of select="title"/> (<xsl:value-of select="@comments"/>)
	</a></li>
</xsl:template>
  
<xsl:template match="/data/twitter/tweets/item">
	<li><em>»</em>
		<a href="{link}">
			<xsl:value-of select="text" disable-output-escaping="yes" />
		</a>
	</li>
</xsl:template>

<xsl:template match="/data/articles-archiv/year">
	<xsl:apply-templates select="month">
		<xsl:with-param name="year" select="@value"/>
	</xsl:apply-templates>
</xsl:template>
  
<xsl:template match="year/month">
	<xsl:param name="year" />

	<li class="dateitem">
		<xsl:variable name="complete_date">
			<xsl:call-template name="date-concat">
				<xsl:with-param name="year" select="$year" />
				<xsl:with-param name="month" select="@value" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:call-template name="format-date">
			<xsl:with-param name="date" select="$complete_date" />
			<xsl:with-param name="format" select="'M'" />
		</xsl:call-template>&#160;<xsl:value-of select="$year" />
	</li>

	<xsl:apply-templates select="entry" />
</xsl:template>

<xsl:template match="entry">
	<li>
		<a href="{$root}/artikel/{title/@handle}">
			<xsl:value-of select="title" />
		</a>
	</li>
</xsl:template>
  
<xsl:template name="date-concat">
	<xsl:param name="year" />
	<xsl:param name="month" />
	<xsl:value-of select="concat($year, '-', $month, '01')" />
</xsl:template>
  
<xsl:template name="tag-cloud">
	<xsl:param name="tags" />
	<ul>
		<xsl:for-each select="$tags">
			<li>
				<a href="{$root}/tag/{.}">
					<xsl:value-of select="." />
				</a>
			</li>
		</xsl:for-each>
	</ul>
</xsl:template>
  
</xsl:stylesheet>
