<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
 version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:ol="http://openlyrics.info/namespace/2009/song"
 xmlns="http://www.w3.org/1999/xhtml">
<xsl:output method="html" encoding="utf-8" indent="yes" doctype-system="about:legacy-compat" />

  <!-- Locale-specific content -->
  <xsl:param name="lang" select="//@xml:lang"/>
  <xsl:variable name="locale-strings">
    <xsl:text>openlyrics.lang.</xsl:text>
    <xsl:value-of select="$lang"/>
    <xsl:text>.xml</xsl:text>
  </xsl:variable>
  <xsl:variable name="locale" select="document ($locale-strings)/locale"/>

  <xsl:template match="/">
    <html lang="{//@xml:lang}" data-ol-version="{//@version}">
      <head>
        <title><xsl:value-of select="//ol:song/ol:properties/ol:titles/ol:title[1]/text()"/></title>
        <meta charset="UTF-8" />
        <link rel="stylesheet" href="css/openlyrics_xsl.css" />
      </head>
      <body>
        <xsl:apply-templates/>
        <!--<header id="header">
        </header>
        <section id="tartalom">
            <article id="lenyeg">
            </article>
        </section>
        <footer>
        </footer>-->
      </body>
    </html>
  </xsl:template>

  <xsl:template match="ol:properties">
    <xsl:apply-templates select="ol:titles"/>
    <header class="{local-name()}">
      <xsl:apply-templates select="ol:songbooks"/>
    </header>
  </xsl:template>
  
  <xsl:template match="ol:title[1]">
      <h1><xsl:value-of select="."/></h1>
  </xsl:template>
  
  <xsl:template match="ol:songbook">
    <div class="{local-name()}" title="{$locale/properties/songbook/text()}">
      <span class="songbook_name">
        <xsl:value-of select="@name"/>
      </span>
      <span class="songbook_entry">
        <xsl:text> </xsl:text><xsl:value-of select="@entry"/><xsl:text>.</xsl:text>
      </span>
    </div>
  </xsl:template>

  <xsl:template match="ol:lyrics">
    <section class="{local-name()}">
      <xsl:apply-templates/>
    </section>
  </xsl:template>

  <xsl:template match="ol:chord[not(ol:chord)]">
    <div class="chord-box">
      <div class="chord">
        <xsl:call-template name="chords">
          <xsl:with-param name="this" select="." />
        </xsl:call-template>
      </div>
      <xsl:if test="string-length(text())!=0">
        <div class="text"><xsl:value-of select="text()"/></div>
      </xsl:if>
    </div>
  </xsl:template>

  <xsl:template name="chords">
    <xsl:param name = "this" />
    <span class="chord-base"><xsl:value-of select="$this/@base|$this/@name"/></span>
    <xsl:if test="string-length($this/@ext)!=0">
      <span class="chord-ext"><xsl:value-of select="$this/@ext"/></span>
    </xsl:if>
    <xsl:if test="string-length($this/@bass)!=0">
      <span class="chord-bass">/<xsl:value-of select="$this/@bass"/></span>
    </xsl:if>
    <xsl:if test="local-name($this/..) = 'chord'">
      <xsl:call-template name="chords">
        <xsl:with-param name="this" select="$this/.." />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template match="ol:br">
    <xsl:element name="br"/>
  </xsl:template>

</xsl:stylesheet>

