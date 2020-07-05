<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
 version="1.0"
 xmlns="http://openlyrics.info/namespace/2009/song"
 xmlns:ol="http://openlyrics.info/namespace/2009/song"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:func="http://exslt.org/functions"
 xmlns:custom="http://www.inkscape.org/namespaces/xslt"
 extension-element-prefixes="func custom">
  <xsl:output method="text" encoding="utf-8" omit-xml-declaration="yes" indent="no"/>

  <!-- Whiteapce handling -->
  <xsl:preserve-space elements="ol:lines ol:chords"/>
  <xsl:strip-space elements="*"/>
  <func:function name="custom:normalize-without-trimming">
    <xsl:param name="string"/>
    <func:result>
      <xsl:value-of select="substring(normalize-space(concat('.',$string,'.')), 2, string-length(normalize-space(concat('.',$string,'.'))) - 2)"/> 
    </func:result>
  </func:function>
  <func:function name="custom:strip-leading-whitespace">
    <xsl:param name="string"/>
    <func:result>
      <xsl:choose>
        <xsl:when test="starts-with($string, ' ') or starts-with($string, '&#xD;') or starts-with($string, '&#xA;')">
          <xsl:value-of select="custom:strip-leading-whitespace(substring($string, 2, string-length(.)))"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$string"/>
        </xsl:otherwise>
      </xsl:choose>
    </func:result>
  </func:function>

  <!-- Standard tags: https://www.chordpro.org/chordpro/ChordPro-Directives.html
       Non standard tags: https://onsongapp.com/docs/features/formats/chordpro/ -->

  <!-- Properties -->
  <xsl:template match="ol:title[1]">
    <xsl:value-of select="concat('{title: ', ., '}&#10;')"/>
  </xsl:template>
  <xsl:template match="ol:title[position()>1]">
    <xsl:value-of select="concat('{subtitle: ', ., '}&#10;')"/>
  </xsl:template>
  <xsl:template match="ol:author[not(@type)]|ol:author[@type='music']">
    <xsl:value-of select="concat('{composer: ', ., '}&#10;')"/>
  </xsl:template>
  <xsl:template match="ol:author[@type='words']">
    <xsl:value-of select="concat('{lyricist: ', ., '}&#10;')"/>
  </xsl:template>
  <xsl:template match="ol:author[@type='translation']">
    <xsl:value-of select="concat('# {translator: ', ., '}&#10;')"/>
  </xsl:template>
  <xsl:template match="ol:copyright">
    <xsl:value-of select="concat('{copyright: ', ., '}&#10;')"/>
  </xsl:template>
  <xsl:template match="ol:ccliNo">
    <xsl:value-of select="concat('{ccli: ', ., '}&#10;')"/>
  </xsl:template>
  <xsl:template match="ol:songbook">
    <xsl:value-of select="concat('# {book: ', @name, '}&#10;')"/>
    <xsl:value-of select="concat('# {number: ', @entry, '}&#10;')"/>
  </xsl:template>
  <xsl:template match="ol:released">
    <xsl:value-of select="concat('{year: ', ., '}&#10;')"/>
  </xsl:template>
  <xsl:template match="ol:key">
    <xsl:value-of select="concat('{key: ', ., '}&#10;')"/>
  </xsl:template>
  <xsl:template match="ol:tempo">
    <xsl:value-of select="concat('{tempo: ', ., '}&#10;')"/>
  </xsl:template>
  <xsl:template match="ol:transposition">
    <xsl:value-of select="concat('{capo: ', ., '}&#10;')"/>
  </xsl:template>
  <xsl:template match="ol:keywords">
    <xsl:value-of select="concat('{keywords: ', ., '}&#10;')"/>
  </xsl:template>
  <xsl:template match="ol:version|ol:variant|ol:publisher|ol:comment|ol:ccliNo|ol:themes|ol:verseOrder"/>

  <!-- Lyrics (whitespace handling in lyrics) -->
  <xsl:template match="ol:instrument"/>
  <xsl:template match="ol:br">
    <xsl:text>&#10;</xsl:text>
  </xsl:template>
  <xsl:template match="ol:lines/text()[1]">
    <xsl:value-of select="custom:strip-leading-whitespace(.)"/>
  </xsl:template>
  <xsl:template match="ol:lines/text()">
    <xsl:choose>
      <xsl:when test="string-length(normalize-space(.))>0"><!-- if there are not only whitespaces (RegExp: \S) -->
        <xsl:choose>
          <xsl:when test="position()=1 or local-name(preceding-sibling::*[1])='br'"><!-- if preceded by <br>: real linebreak  -->
            <xsl:value-of select="custom:strip-leading-whitespace(.)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="custom:normalize-without-trimming(.)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test=".=' ' or .='&#13;' or .='&#10;' or .='&#09;' or .='&#xa;'">
        <xsl:text> </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="normalize-space(.)"/><!-- can simple remove -->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="ol:chord/text()">
    <xsl:value-of select="normalize-space(.)"/>
  </xsl:template>
  <xsl:template match="ol:lines[following-sibling::ol:lines[1]]">
    <xsl:apply-templates/>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:template name="displayVerseName">
    <xsl:param name="name" />
    <xsl:param name="type" />
    <xsl:variable name="verseName" select="substring($name,1,1)" />
    <xsl:variable name="verseNum"  select="substring($name,2,string-length(-1))" />
    <xsl:text>{</xsl:text>
    <xsl:value-of select="$type"/>
    <xsl:text>_of_</xsl:text>
    <xsl:choose>
      <xsl:when test="$verseName='c'">chorus: Chorus</xsl:when>
      <xsl:when test="$verseName='v'">verse: Verse</xsl:when>
      <xsl:when test="$verseName='b'">bridge: Bridge</xsl:when>
      <xsl:when test="$verseName='p'">prechorus: Pre-chorus</xsl:when>
      <xsl:when test="$verseName='e'">part: Part</xsl:when>
    </xsl:choose>
    <xsl:if test="$verseNum!=''"><xsl:value-of select="concat(' ', $verseNum)"/></xsl:if>
    <xsl:text>}</xsl:text>
  </xsl:template>
  <xsl:template match="ol:verse">
    <xsl:text>&#10;</xsl:text>
    <xsl:call-template name="displayVerseName">
      <xsl:with-param name="name" select="@name"/>
      <xsl:with-param name="type" select="string('start')"/>
    </xsl:call-template>
    <xsl:text>&#10;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&#10;</xsl:text>
    <xsl:call-template name="displayVerseName">
      <xsl:with-param name="name" select="@name"/>
      <xsl:with-param name="type" select="string('end')"/>
    </xsl:call-template>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <!-- Chords -->
  <xsl:variable name="chordNotation" select="document('../stylesheets/xsl/openlyrics-0.9-chord.xml')/chordNotation"/>
  <xsl:variable name="notation">
    <xsl:choose>
      <xsl:when test="//ol:song/@chordNotation">
        <xsl:value-of select="//ol:song/@chordNotation"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>english</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:template name="chordname">
    <xsl:param name="this" />
    <xsl:value-of select="$chordNotation/notation[@id=$notation]/name[@class=$this/@root]/text()"/>
    <xsl:value-of select="$chordNotation/structure[@id=$this/@structure]/text()|$chordNotation/structure[@shorthand=$this/@structure]/text()"/>
    <xsl:if test="string-length($this/@bass)!=0">
      <xsl:text>/</xsl:text>
      <xsl:value-of select="$chordNotation/notation[@id=$notation]/name[@class=$this/@bass]/text()"/>
    </xsl:if>
  </xsl:template>
  <xsl:template match="ol:song[@version='0.8']//ol:chord">
    <xsl:text>[</xsl:text>
    <xsl:value-of select="@name"/>
    <xsl:text>]</xsl:text>
  </xsl:template>
  <xsl:template match="ol:song[@version='0.9']//ol:chord">
    <xsl:text>[</xsl:text>
    <xsl:call-template name="chordname"><xsl:with-param name="this" select="."/></xsl:call-template>
    <xsl:text>]</xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

</xsl:stylesheet>
