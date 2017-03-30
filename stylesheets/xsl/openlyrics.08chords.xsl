<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
 version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:ol="http://openlyrics.info/namespace/2009/song"
 xmlns="http://www.w3.org/1999/xhtml">
<xsl:output method="html" encoding="utf-8" indent="yes" doctype-system="about:legacy-compat" />

   <xsl:template match="ol:song[@version='0.8']//ol:lines/ol:chord"> <!-- chords 0.8 -->
    <span class="chord">
      <code>{</code>
      <xsl:value-of select="@name"/>
      <code>}</code>
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

</xsl:stylesheet>

