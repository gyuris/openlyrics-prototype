<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
 version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:ol="http://openlyrics.info/namespace/2009/song"
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
        <xsl:apply-templates select="ol:variant"/>
        <xsl:apply-templates select="ol:copyright"/>
        <xsl:apply-templates select="ol:comments"/>
      </p>
      <p class="properties-main">
        <xsl:apply-templates select="ol:key"/>
        <xsl:apply-templates select="ol:tempo"/>
        <xsl:apply-templates select="ol:transposition"/>
        <xsl:apply-templates select="ol:ccliNo"/>
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
          <!-- why not works? $locale/languages/*[local-name()=@lang/text() -->
          <xsl:variable name="language" select="@lang" />
          (<xsl:value-of select="$locale/languages/*[local-name()=$language]/text()"/>)
        </xsl:if>
      </span>
  </xsl:template>
  <xsl:template match="ol:title[position()>1][not(@original)]">
      <span class="{local-name()}" title="{$locale/properties/subtitle/text()}">
        <em><xsl:value-of select="$locale/properties/subtitle/text()"/>: </em>
        <xsl:value-of select="."/>
        <xsl:if test="@lang">
          <!-- why not works? $locale/languages/*[local-name()=@lang/text() -->
          <xsl:variable name="language" select="@lang" />
          (<xsl:value-of select="$locale/languages/*[local-name()=$language]/text()"/>)
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
      <!-- why not works? $locale/properties/*[local-name()=@type]/text() -->
      <xsl:variable name="type" select="@type" />
      <span class="{local-name()} {@type}" title="{$locale/properties/*[local-name()=$type]/text()}">
        <em><xsl:value-of select="$locale/properties/*[local-name()=$type]/text()"/>: </em>
        <xsl:value-of select="."/>
      </span>
  </xsl:template>

  <xsl:template match="ol:author[@type='translation']">
      <!-- why not works? $locale/properties/*[local-name()=@type]/text() -->
      <xsl:variable name="type" select="@type" />
      <span class="{local-name()} {@type}" title="{$locale/properties/*[local-name()=$type]/text()}">
        <em><xsl:value-of select="$locale/properties/*[local-name()=$type]/text()"/>: </em>
        <xsl:value-of select="."/>
        <xsl:if test="@lang">
          <!-- why not works? $locale/languages/*[local-name()=@lang/text() -->
          <xsl:variable name="language" select="@lang" />
          (<xsl:value-of select="$locale/languages/*[local-name()=$language]/text()"/>)
        </xsl:if>
      </span>
  </xsl:template>

  <xsl:template match="ol:released">
      <span class="{local-name()}" title="{$locale/properties/released/text()}">
        <em><xsl:value-of select="$locale/properties/released/text()"/>: </em>
        <xsl:value-of select="."/>
      </span>
      <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="ol:variant">
      <span class="{local-name()}" title="{$locale/properties/variant/text()}">
        <em><xsl:value-of select="$locale/properties/variant/text()"/>: </em>
        <xsl:value-of select="."/>
      </span>
      <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="ol:copyright">
      <span class="{local-name()}" title="{$locale/properties/copyright/text()}">
        <em><xsl:value-of select="$locale/properties/copyright/text()"/>: </em>
        <xsl:value-of select="."/>
      </span>
      <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="ol:properties/ol:comment">
      <span class="{local-name()}" title="{$locale/properties/comment/text()}">
        <em><xsl:value-of select="$locale/properties/comment/text()"/>: </em>
        <xsl:value-of select="."/>
      </span>
      <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="ol:key">
      <span class="{local-name()}" title="{$locale/properties/key/text()}">
        <em><xsl:value-of select="$locale/properties/key/text()"/>: </em>
        <xsl:value-of select="."/>
      </span>
      <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="ol:tempo">
      <span class="{local-name()}" title="{$locale/properties/tempo/text()}">
        <em><xsl:value-of select="$locale/properties/tempo/text()"/>: </em>
        <xsl:value-of select="."/>
      </span>
      <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="ol:transposition">
      <span class="{local-name()}" title="{$locale/properties/transposition/text()}">
        <em><xsl:value-of select="$locale/properties/transposition/text()"/>: </em>
        <xsl:value-of select="."/>
      </span>
      <xsl:text> </xsl:text>
  </xsl:template>
  
  <xsl:template match="ol:ccliNo">
      <span class="{local-name()}" title="{$locale/properties/ccliNo/text()}">
        <em><xsl:value-of select="$locale/properties/ccliNo/text()"/>: </em>
        <xsl:value-of select="."/>
      </span>
      <xsl:text> </xsl:text>
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
    <section class="{local-name()}">
      <xsl:apply-templates/>
    </section>
  </xsl:template>

  <xsl:template match="ol:verse|ol:instrument">
    <article class="{local-name()}" id="{@name}">
      <xsl:apply-templates/>
    </article>
  </xsl:template>

  <xsl:template match="ol:lines"><!-- TODO: @part -->
    <p class="{local-name()}">
      <xsl:if test="@repeat">
        ‖:<xsl:text> </xsl:text>
      </xsl:if>
      <xsl:apply-templates/>
      <xsl:if test="@repeat">
        <xsl:text> </xsl:text>:‖×<xsl:value-of select="@repeat"/>
      </xsl:if>
    </p>
  </xsl:template>

  <xsl:template match="ol:song[@version='0.8']//ol:lines/ol:chord"> <!-- chords 0.8 -->
    <span class="chord">
      <xsl:value-of select="@name"/>
    </span>
  </xsl:template>
  <xsl:template match="ol:song[@version='0.8']//ol:lines[ol:chord]/text()">
    <span class="segment">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>
<!--<xsl:template match="ol:song[@version='0.8']//ol:lines[ol:chord]/text()">
    <span class="segment">
      <xsl:choose>
        <xsl:when test="local-name(preceding-sibling::ol:chord[1]|preceding-sibling::text()[1])='chord'">
          <span class="lyrics">
            <xsl:value-of select="."/>
          </span>
        </xsl:when>
        <xsl:otherwise>
          <span class="chord">
            <xsl:value-of select="preceding-sibling::ol:chord[1]/@name"/>
          </span>
          <span class="lyrics">
            <xsl:value-of select="."/>
          </span>
        </xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>
  <xsl:template match="ol:song[@version='0.8']//ol:chord">
    <span class="segment">
      <span class="chord">
        <span class="chord-name">
          <xsl:value-of select="@name"/>
        </span>
      </span>
      <span class="lyrics">
       <xsl:choose>
        <xsl:when test="local-name(following-sibling::text()[1]|following-sibling::*[1])='chord'">
          <xsl:text> </xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="following-sibling::text()[1]"/>
        </xsl:otherwise>
       </xsl:choose>
      </span>
    </span>
  </xsl:template>
  <xsl:template match="ol:song[@version='0.8']//ol:lines[ol:chord]/text()"></xsl:template>-->

  <xsl:template match="ol:song[@version='0.9']//ol:chord[not(ol:chord)]"> <!-- chords 0.9 -->
    <xsl:variable name="linebreak">
      <xsl:if test="ol:br">
        <xsl:text> linebreak</xsl:text>
      </xsl:if>
    </xsl:variable>
    <span class="segment{$linebreak}">
      <span class="chord">
        <xsl:call-template name="chords0.9">
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
  <xsl:template name="chords0.9">
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
      <xsl:call-template name="chords0.9">
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

