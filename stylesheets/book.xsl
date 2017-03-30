<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
 version="1.0"
 xmlns:ol="http://openlyrics.info/namespace/2009/song"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:str="http://exslt.org/strings"
 xmlns:xi="http://www.w3.org/2001/XInclude"
 xmlns:xhtml="http://www.w3.org/1999/xhtml">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>

  <xsl:param name="ol" select="'http://openlyrics.info/namespace/2009/song'"/>

  <xsl:template match="/">
    <xsl:processing-instruction name="xml-stylesheet">
      <xsl:text>href="stylesheets/openlyrics.css" type="text/css"</xsl:text>
    </xsl:processing-instruction>
    <xsl:text>&#x0A;</xsl:text>
    <book>
    <xsl:apply-templates />
    </book>
  </xsl:template>

  <xsl:template match="ol:toc">
    <ol:toc>
      <xsl:for-each select="//xi:include">
        <xsl:choose>
          <xsl:when test="system-property('xsl:vendor')='Transformiix'">
            <ol:entry><xhtml:a href="#{//ol:title/@id}-{@entry}"><xsl:value-of select="document(@href)/ol:song/ol:properties/ol:titles/ol:title[1]" /></xhtml:a></ol:entry>
          </xsl:when>
          <xsl:otherwise>
            <ol:entry><xhtml:a href="#{//ol:title/@id}-{@entry}"><xsl:value-of select="document(concat('../', str:encode-uri(@href, true())))/ol:song/ol:properties/ol:titles/ol:title[1]" /></xhtml:a></ol:entry>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </ol:toc>
  </xsl:template>

  <xsl:template match="xi:include">
    <xsl:choose>
      <xsl:when test="system-property('xsl:vendor')='Transformiix'">
        <xsl:element name="song" namespace="{$ol}">
          <xsl:attribute name="xml:lang"><xsl:value-of select="document(@href)/ol:song/@lang" /></xsl:attribute>
          <xsl:attribute name="lang"><xsl:value-of select="document(@href)/ol:song/@lang" /></xsl:attribute>
          <xsl:attribute name="version"><xsl:value-of select="document(@href)/ol:song/@version" /></xsl:attribute>
          <xsl:attribute name="createdIn"><xsl:value-of select="document(@href)/ol:song/@createdIn" /></xsl:attribute>
          <xsl:attribute name="modifiedIn"><xsl:value-of select="document(@href)/ol:song/@modifiedIn" /></xsl:attribute>
          <xsl:attribute name="modifiedDate"><xsl:value-of select="document(@href)/ol:song/@modifiedDate" /></xsl:attribute>
          <xsl:attribute name="id"><xsl:value-of select="concat(//ol:title/@id, '-', @entry)" /></xsl:attribute>
          <xsl:copy-of select="document(@href)/ol:song/ol:properties" />
          <xsl:copy-of select="document(@href)/ol:song/ol:lyrics" />
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="song" namespace="{$ol}">
          <xsl:attribute name="xml:lang"><xsl:value-of select="document(concat('../', str:encode-uri(@href, true())))/ol:song/@lang" /></xsl:attribute>
          <xsl:attribute name="lang"><xsl:value-of select="document(concat('../', str:encode-uri(@href, true())))/ol:song/@lang" /></xsl:attribute>
          <xsl:attribute name="version"><xsl:value-of select="document(concat('../', str:encode-uri(@href, true())))/ol:song/@version" /></xsl:attribute>
          <xsl:attribute name="createdIn"><xsl:value-of select="document(concat('../', str:encode-uri(@href, true())))/ol:song/@createdIn" /></xsl:attribute>
          <xsl:attribute name="modifiedIn"><xsl:value-of select="document(concat('../', str:encode-uri(@href, true())))/ol:song/@modifiedIn" /></xsl:attribute>
          <xsl:attribute name="modifiedDate"><xsl:value-of select="document(concat('../', str:encode-uri(@href, true())))/ol:song/@modifiedDate" /></xsl:attribute>
          <xsl:attribute name="id"><xsl:value-of select="concat(//ol:title/@id, '-', @entry)" /></xsl:attribute>
          <xsl:copy-of select="document(concat('../', str:encode-uri(@href, true())))/ol:song/ol:properties" />
          <xsl:copy-of select="document(concat('../', str:encode-uri(@href, true())))/ol:song/ol:lyrics" />
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="ol:title|ol:foreword">
    <xsl:copy-of select="."/>
  </xsl:template>
</xsl:stylesheet>

