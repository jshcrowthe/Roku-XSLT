<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:media="http://search.yahoo.com/mrss/"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs">
  <xsl:output method="xml" encoding="UTF-8" indent="yes" />
  <xsl:template name="rss" match="/">
    <rss xmlns:media="http://search.yahoo.com/mrss/">
      <xsl:for-each select="rss">
        <xsl:variable name="var1_channel" select="channel" />
        <xsl:attribute name="version">
          <xsl:value-of select="string(number(string(@version)))" />
        </xsl:attribute>
        <channel>
          <title>
            <xsl:value-of select="string($var1_channel/title)" />
          </title>
          <link>
            <xsl:value-of select="string($var1_channel/link)" />
          </link>
          <description>
            <xsl:value-of select="string($var1_channel/description)" />
          </description>
          <xsl:apply-templates name="item"
            select="channel/items/item" />
          </channel>
        </xsl:for-each>
      </rss>
    </xsl:template>
    <xsl:template name="item" match="item">
      <xsl:variable name="var1_content" select="content" />
      <xsl:variable name="var2_resultof_cast"
        select="string(title)" />
        <item>
          <title>
            <xsl:value-of select="$var2_resultof_cast" />
          </title>
          <link>
            <xsl:value-of select="string(link)" />
          </link>
          <xsl:for-each select="$var1_content">
            <media:content>
              <xsl:attribute name="url">
                <xsl:value-of select="concat('http:',substring-after(string(@url),':'))" />
              </xsl:attribute>
            </media:content>
          </xsl:for-each>
          <media:title>
            <xsl:value-of select="$var2_resultof_cast" />
          </media:title>
          <media:thumbnail>
            <xsl:attribute name="url">
              <xsl:value-of select="thumbnail/@url"/>
            </xsl:attribute>
          </media:thumbnail>
          <media:description>
            <xsl:value-of select="description" />
          </media:description>
          <media:keywords>
            <xsl:call-template name="implode">
              <xsl:with-param name="items"
                select="$var1_content/tags/tag" />
              </xsl:call-template>
            </media:keywords>
          </item>
        </xsl:template>
        <xsl:template name="implode">
          <xsl:param name="items" />
          <xsl:param name="separator" select="','" />
          <xsl:for-each select="$items">
            <xsl:if test="position() > 1">
              <xsl:value-of select="$separator" />
            </xsl:if>
            <xsl:value-of select="." />
          </xsl:for-each>
        </xsl:template>
      </xsl:stylesheet>