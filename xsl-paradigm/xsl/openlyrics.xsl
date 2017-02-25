<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
 version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:ol="http://openlyrics.info/namespace/2009/song"
 xmlns:str="http://exslt.org/strings"
 xmlns="http://www.w3.org/1999/xhtml">
<xsl:output method="html" encoding="utf-8" indent="yes" doctype-system="about:legacy-compat" />

  <!-- Locale-specific content -->
  <xsl:variable name="locale-strings">
    <xsl:text>openlyrics.lang.</xsl:text>
    <xsl:value-of select="//@xml:lang"/>
    <xsl:text>.xml</xsl:text>
  </xsl:variable>
  <xsl:variable name="locale" select="document ($locale-strings)/locale"/>

  <!-- Main -->
  <xsl:template match="/">
    <html lang="{//@xml:lang}" data-ol-version="{//@version}">
      <head>
        <title><xsl:value-of select="//ol:song/ol:properties/ol:titles/ol:title[1]/text()"/></title>
        <meta charset="UTF-8" />
        <link rel="stylesheet" href="css/openlyrics_xsl.css" />
      </head>
      <body>
        <xsl:apply-templates/>
        <footer>
          <p id="root-properties">
            OpenLyrics <xsl:value-of select="//@version"/>
            <xsl:if test="//@createdIn">
              • <xsl:value-of select="$locale/properties/creator/text()"/>: <xsl:value-of select="//@createdIn"/>
            </xsl:if>
            <xsl:if test="//@xml:lang">
              • <xsl:value-of select="$locale/properties/language/text()"/>: <xsl:value-of select="$locale/languages/*[local-name()=//@xml:lang]/text()"/>
            </xsl:if>
          </p>
        </footer>
      </body>
    </html>
  </xsl:template>

  <!-- Header properties -->
  <xsl:template match="ol:properties">
    <header>
      <xsl:apply-templates select="ol:titles"/>
    </header>
    <section class="{local-name()}">
      <p class="properties-authors">
      <xsl:apply-templates select="ol:authors"/>
      </p>
      <p class="properties-other">
        <xsl:apply-templates select="ol:released"/>
        <xsl:apply-templates select="ol:version"/>
        <xsl:apply-templates select="ol:variant"/>
        <xsl:apply-templates select="ol:publisher"/>
        <xsl:apply-templates select="ol:copyright"/>
        <xsl:apply-templates select="ol:comments"/>
        <xsl:apply-templates select="ol:keywords"/>
      </p>
      <p class="properties-main">
        <xsl:apply-templates select="ol:key"/>
        <xsl:apply-templates select="ol:tempo"/>
        <xsl:apply-templates select="ol:transposition"/>
        <xsl:apply-templates select="ol:ccliNo"/>
      </p>
      <p class="properties-themes">
        <xsl:apply-templates select="ol:themes"/>
      </p>
      <p class="properties-songbooks">
        <xsl:apply-templates select="ol:songbooks"/>
      </p>
    </section>
  </xsl:template>
  
  <xsl:template match="ol:title[1]">
    <h1 title="{$locale/properties/title/text()}"><xsl:value-of select="."/></h1>
  </xsl:template>
  <xsl:template match="ol:title[@original]">
    <span class="{local-name()} {name(@original)}" title="{$locale/properties/originalTitle/text()}">
      <em><xsl:value-of select="$locale/properties/originalTitle/text()"/>: </em>
      <xsl:value-of select="."/>
      <xsl:if test="@lang">
        (<xsl:value-of select="$locale/languages/*[local-name()=current()/@lang]/text()"/>)
      </xsl:if>
    </span>
  </xsl:template>
  <xsl:template match="ol:title[position()>1][not(@original)]">
    <span class="{local-name()}" title="{$locale/properties/subtitle/text()}">
      <em><xsl:value-of select="$locale/properties/subtitle/text()"/>: </em>
      <xsl:value-of select="."/>
      <xsl:if test="@lang">
        (<xsl:value-of select="$locale/languages/*[local-name()=current()/@lang]/text()"/>)
      </xsl:if>
    </span>
  </xsl:template>

  <xsl:template match="ol:author[not(@type)]">
    <span class="{local-name()}" title="{$locale/properties/author/text()}">
      <em><xsl:value-of select="$locale/properties/author/text()"/>: </em>
      <xsl:value-of select="."/>
    </span>
  </xsl:template>
  <xsl:template match="ol:author[@type='words']|ol:author[@type='music']">
    <span class="{local-name()} {@type}" title="{$locale/properties/*[local-name()=current()/@type]/text()}">
      <em><xsl:value-of select="$locale/properties/*[local-name()=current()/@type]/text()"/>: </em>
      <xsl:value-of select="."/>
    </span>
  </xsl:template>
  <xsl:template match="ol:author[@type='translation']">
      <span class="{local-name()} {@type}" title="{$locale/properties/*[local-name()=current()/@type]/text()}">
        <em><xsl:value-of select="$locale/properties/*[local-name()=current()/@type]/text()"/>: </em>
        <xsl:value-of select="."/>
        <xsl:if test="@lang">
          (<xsl:value-of select="$locale/languages/*[local-name()=current()/@lang]/text()"/>)
        </xsl:if>
      </span>
  </xsl:template>

  <xsl:template match="ol:released|ol:version|ol:variant|ol:publisher|ol:copyright|ol:comment|ol:keywords|ol:key|ol:transposition|ol:ccliNo">
      <span class="{local-name()}" title="{$locale/properties/*[local-name()=local-name(current())]/text()}">
        <em><xsl:value-of select="$locale/properties/*[local-name()=local-name(current())]/text()"/>: </em>
        <xsl:value-of select="."/>
      </span>
      <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="ol:tempo">
      <span class="{local-name()}" title="{$locale/properties/tempo/text()}">
        <em><xsl:value-of select="$locale/properties/tempo/text()"/>: </em>
        <xsl:value-of select="."/>
        <xsl:if test="string(number(.))!='NaN'">
          <xsl:text> BMP</xsl:text>
        </xsl:if>
      </span>
      <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="ol:themes">
    <span class="{local-name()}" title="{$locale/properties/themes/text()}">
      <em><xsl:value-of select="$locale/properties/themes/text()"/>: </em>
      <xsl:for-each select="ol:theme">
        <xsl:if test="not(@lang)">
          <xsl:value-of select="."/>, <xsl:text/>
        </xsl:if>
        <xsl:if test="@lang">
          <xsl:value-of select="."/>
          (<xsl:value-of select="$locale/languages/*[local-name()=current()/@lang]/text()"/>)<xsl:if test="position()!=last()">, <xsl:text/></xsl:if>
        </xsl:if>
      </xsl:for-each>
    </span>
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

  <!-- Lyrics and chords -->
  <xsl:template match="ol:lyrics">
    <aside class="verse-order">
      <xsl:apply-templates select="//ol:verseOrder"/>
    </aside>
    <section class="{local-name()}">
      <xsl:apply-templates/>
    </section>
  </xsl:template>

  <xsl:template match="ol:verseOrder">
    <span class="{local-name()}" title="{$locale/properties/verseOrder/text()}">
      <em><xsl:value-of select="$locale/properties/verseOrder/text()"/>: </em>
      <div>
        <xsl:for-each select="str:tokenize(.,' ')">
          <xsl:call-template name="displayVerseName">
            <xsl:with-param name="name" select="."/>
          </xsl:call-template>
          <br/>
        </xsl:for-each>
      </div>
    </span>
  </xsl:template>

  <xsl:template name="displayVerseName">
    <xsl:param name="name" />
    <xsl:variable name="verseName" select="substring($name,1,1)" />
    <xsl:variable name="verseNum"  select="substring($name,2,string-length(-1))" />
    <xsl:if test="$verseNum!='' and $locale/lyrics/verseNumber[@position='before']">
      <xsl:value-of select="$verseNum" />
      <xsl:value-of select="$locale/lyrics/verseNumber/@separator" />
    </xsl:if>
    <xsl:value-of select="$locale/lyrics/verseNames/*[local-name()=$verseName]/text()"/>
    <xsl:if test="$verseNum!='' and $locale/lyrics/verseNumber[@position='after']">
      <xsl:value-of select="$locale/lyrics/verseNumber/@separator" />
      <xsl:value-of select="$verseNum" />
    </xsl:if>
  </xsl:template>

  <xsl:template match="ol:verse|ol:instrument">
    <xsl:variable name="verseName" select="substring(@name,1,1)" />
    <xsl:variable name="verseNum"  select="substring(@name,2,string-length(-1))" />
    <article class="{local-name()}" id="{@name}" data-verse-name="{$verseName}" data-verse-num="{$verseNum}">
      <xsl:if test="@name">
        <div class="verse-name">
          <xsl:call-template name="displayVerseName">
            <xsl:with-param name="name" select="@name"/>
          </xsl:call-template>
        </div>
      </xsl:if>
      <xsl:apply-templates/>
    </article>
  </xsl:template>

  <xsl:template match="ol:lines">
    <p class="{local-name()}">
      <xsl:if test="@part">
        <div class="line-part" title="{$locale/lyrics/part/text()}">
          <em><xsl:value-of select="$locale/lyrics/part/text()"/>: </em>
          <xsl:value-of select="@part"/>
          </div>
      </xsl:if>
      <xsl:if test="@repeat">
        ‖:<xsl:text> </xsl:text>
      </xsl:if>
      <xsl:apply-templates/>
      <xsl:if test="@repeat">
        <xsl:text> </xsl:text>:‖×<xsl:value-of select="@repeat"/>
      </xsl:if>
    </p>
  </xsl:template>

   <!-- Chords support for OpenLyrics 0.8 is in separated file -->
  <xsl:include href="openlyrics.08chords.xsl" />

  <xsl:template match="ol:song[@version='0.9']//ol:chord[not(ol:chord)]">
    <xsl:variable name="linebreak">
      <xsl:if test="ol:br">
        <xsl:text> linebreak</xsl:text>
      </xsl:if>
    </xsl:variable>
    <span class="segment{$linebreak}">
      <span class="chord">
        <xsl:call-template name="chords">
          <xsl:with-param name="this" select="." />
        </xsl:call-template>
      </span>
      <xsl:if test="string-length(text())!=0">
        <span class="lyrics">
          <xsl:apply-templates select="text()|ol:br"  />
        </span>
      </xsl:if>
    </span>
  </xsl:template>
  <xsl:template name="chords">
    <xsl:param name="this" />
    <code>{</code>
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
    <code>}</code>
  </xsl:template>

  <xsl:template match="ol:br">
    <xsl:element name="br"/>
  </xsl:template>

  <xsl:template match="ol:lyrics//ol:comment">
    <!-- TODO -->
  </xsl:template>

</xsl:stylesheet>

