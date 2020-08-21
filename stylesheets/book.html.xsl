<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
 version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:str="http://exslt.org/strings"
 xmlns:db="http://docbook.org/ns/docbook"
 xmlns:ol="http://openlyrics.info/namespace/2009/song"
 xmlns:xhtml="http://www.w3.org/1999/xhtml"
 xmlns="http://www.w3.org/1999/xhtml">
<xsl:output method="html" encoding="utf-8" indent="yes" doctype-system="about:legacy-compat" />

  <xsl:param name="book-type" select="string('public')"/><!-- value passed from outside, possible values: 'public', 'band' -->

  <!-- reuse openlyrics.xsl -->
  <xsl:include href="openlyrics.xsl"/> 

  <!-- overwrite root from openlyrics.xsl: import 2nd CSS -->
  <xsl:template match="/">
    <html lang="{@xml:lang}">
      <head>
        <title><xsl:value-of select="ol:song/ol:properties/ol:titles/ol:title[1]/text()"/></title>
        <meta charset="UTF-8" />
        <link rel="stylesheet" href="../stylesheets/css/html.css" />
        <link rel="stylesheet" href="../stylesheets/css/book.html.css" />
        <xsl:if test="$book-type='public'">
          <link rel="stylesheet" href="../stylesheets/css/book-public.html.css" />
        </xsl:if>
      </head>
      <body class="{$book-type}">
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <!-- book related declarations -->
  <xsl:template match="db:title">
    <h1><xsl:value-of select="text()" /></h1>
  </xsl:template>
  <xsl:template match="db:foreword">
    <p><xsl:value-of select="text()" /></p>
  </xsl:template>
  <xsl:template match="db:toc">
    <nav class="toc">
      <ul>
        <xsl:apply-templates/>
      </ul>
    </nav>
  </xsl:template>
  <xsl:template match="db:entry">
    <li><a href="{xhtml:a/@href}"><xsl:value-of select="xhtml:a/text()" /></a></li>
  </xsl:template>
  <xsl:template match="db:chapter">
    <section id="songs">
      <xsl:apply-templates />
    </section>
  </xsl:template>

</xsl:stylesheet>

