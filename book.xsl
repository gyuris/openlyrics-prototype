<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
 version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:ol="http://openlyrics.info/namespace/2009/song"
 xmlns:xi="http://www.w3.org/2001/XInclude"
 xmlns:str="http://exslt.org/strings"
 xmlns="http://www.w3.org/1999/xhtml">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"/>
  <xsl:template match="/">
    <xsl:processing-instruction name="xml-stylesheet">
      <xsl:text>type="text/css" href="stylesheets/openlyrics.css"</xsl:text>
    </xsl:processing-instruction>
    <xsl:text>&#x0A;</xsl:text>
    <book>
    <xsl:apply-templates />
    </book>
  </xsl:template>
  <xsl:template match="xi:include">
    <!--<bookentry id="song{document(@href)/ol:song/ol:properties/ol:songbooks/ol:songbook[@name='Szent András énekfüzet' ]/@entry}">-->
    <xsl:copy-of select="document(@href)/ol:song" />
    <!--</bookentry>-->
  </xsl:template>
  <xsl:template match="ol:title|ol:foreword">
    <xsl:copy-of select="."/>
  </xsl:template>
</xsl:stylesheet>

