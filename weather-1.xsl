<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:functx="http://www.functx.com">

    <!-- FUNCTIONS FOR DATE AND DAYS - START -->
    <xsl:function name="functx:day-of-week" as="xs:integer?"
                  xmlns:functx="http://www.functx.com">
        <xsl:param name="date" as="xs:anyAtomicType?"/>

        <xsl:sequence select="
  if (empty($date))
  then ()
  else xs:integer((xs:date($date) - xs:date('1901-01-06'))
          div xs:dayTimeDuration('P1D')) mod 7
 "/>
    </xsl:function>

    <xsl:function name="functx:day-of-week-name-en" as="xs:string?"
                  xmlns:functx="http://www.functx.com">
        <xsl:param name="date" as="xs:anyAtomicType?"/>
        <xsl:sequence
                select="('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday') [functx:day-of-week($date) + 1]"/>
    </xsl:function>
    <!-- FUNCTIONS FOR DATE AND DAYS - END -->

    <!-- FUNCTION TO PRINT THE DAY AND DATE - START -->
    <xsl:function name="functx:getDay" as="xs:string">
        <xsl:param name="inpString" as="xs:string" />
        <xsl:variable name="dt" as="xs:dateTime"
                      select="xs:dateTime(substring($inpString, 1, 19))"/>
        <xsl:variable name="dayOfWeekName" as="xs:string" select="functx:day-of-week-name-en(xs:dateTime($dt))"/>
        <xsl:variable name="dateFormat" as="xs:string" select="format-dateTime($dt,' [D1] [MNn]')"/>
        <xsl:value-of select="concat($dayOfWeekName, $dateFormat)"/>
    </xsl:function>
    <!-- FUNCTION TO PRINT THE DAY AND DATE - END -->

    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="style.css" />
            </head>
            <body>
                <h1>NSW and ACT Weather</h1>
                <div class="main effect">
                    <div class="climate">
                        <h3><span>Forcast for the rest of</span>
                            <xsl:value-of select="functx:getDay(product/forecast/area/forecast-period[@index='0']/@start-time-local)"/></h3>
                        <br/>

                        <xsl:value-of select="product/forecast/area/forecast-period[@index='0']/text[@type='forecast']"/>

                    </div>
                </div>
                <h1>Canberra Weather</h1>

                <xsl:variable name="extDoc1" select="document('IDN10035.xml')"/>
                <xsl:variable name="description" select="'Canberra'"/>

                <xsl:for-each select="$extDoc1/product/forecast/area[@description=$description][@type='metropolitan']/forecast-period[@index!=0]">

                    <xsl:if test="(xs:integer(substring(@start-time-local, 9, 2)) &lt;= 29) and  (xs:integer(substring(@start-time-local, 9, 2)) >= 27) ">
                        <div class="main effect">
                            <div class="climate">
                                <p>
                                    <xsl:variable name="pos" select="position()"/>
                                    <h3><span>Forcast for</span>
                                        <xsl:value-of select="functx:getDay(@start-time-local)"/></h3>
                                    <br/>
                                    <xsl:value-of
                                            select="text[@type='forecast']"/>
                                    <br/>
                                    <br/>
                                    <div class="shades">
                                        <h3><xsl:value-of select="$extDoc1/product/forecast/area[@description=$description][@type='location']/forecast-period[@index=$pos]/element[@type='air_temperature_minimum']"/>°<span>MIN</span></h3>

                                        <ul>
                                            <li></li><li></li><li></li><li></li><li></li><li></li>
                                            <div class="clear"></div>
                                        </ul>
                                        <h3><xsl:value-of select="$extDoc1/product/forecast/area[@description=$description][@type='location']/forecast-period[@index=$pos]/element[@type='air_temperature_maximum']"/>°<span>MAX</span></h3>
                                        <div class="clear"></div>
                                    </div>
                                </p>
                            </div>
                        </div>
                    </xsl:if>

                </xsl:for-each>

                <h1>Sydney Weather</h1>
                <xsl:variable name="extDoc1" select="document('IDN11050.xml')"/>
                <xsl:variable name="extDoc2" select="document('IDN11060.xml')"/>
                <xsl:variable name="description" select="'Sydney'"/>
                <xsl:for-each select="$extDoc1/product/forecast/area[@description=$description][@type='metropolitan']/forecast-period[@index!=0]">

                    <xsl:if test="(xs:integer(substring(@start-time-local, 9, 2)) &lt;= 29) and  (xs:integer(substring(@start-time-local, 9, 2)) >= 27) ">
                        <div class="main effect">
                            <div class="climate">
                                <p>
                                    <xsl:variable name="pos" select="position()"/>
                                    <h3><span>Forcast for</span>
                                        <xsl:value-of select="functx:getDay(@start-time-local)"/></h3>
                                    <br/>
                                    <xsl:value-of
                                            select="text[@type='forecast']"/>
                                    <br/>
                                    <br/>
                                    <div class="shades">
                                        <h3><xsl:value-of select="$extDoc2/product/forecast/area[@description=$description][@type='location']/forecast-period[@index=$pos]/element[@type='air_temperature_minimum']"/>°<span>MIN</span></h3>
                                        <ul>
                                            <li></li><li></li><li></li><li></li><li></li><li></li>
                                            <div class="clear"></div>
                                        </ul>
                                        <h3><xsl:value-of select="$extDoc2/product/forecast/area[@description=$description][@type='location']/forecast-period[@index=$pos]/element[@type='air_temperature_maximum']"/>°<span>MAX</span></h3>
                                    </div>
                                    <div class="clear"></div>
                                </p>
                            </div>
                        </div>
                    </xsl:if>
                </xsl:for-each>

                <h1>Snowy Mountains District Weather</h1>
                <xsl:variable name="extDoc1" select="document('IDN11032.xml')"/>
                <xsl:variable name="aacSorted" as="element(area)+">
                    <xsl:perform-sort select="$extDoc1/product/forecast/area[@type='location']">
                        <xsl:sort select="@description"/>
                    </xsl:perform-sort>
                </xsl:variable>

                <xsl:variable name="description" select="'Snowy Mountains'"/>
                <xsl:for-each select="$extDoc1/product/forecast/area[@description=$description][@type='public-district']/forecast-period[@index!=0]">
                    <div class="main effect">
                        <div class="climate">
                            <xsl:variable name="pos" select="position()"/>
                            <h3><span>Forcast for</span>
                                <xsl:value-of select="functx:getDay(@start-time-local)"/></h3>
                            <br/>
                            <xsl:value-of
                                    select="text[@type='forecast']"/>
                            <br/>
                            <br/>Snow at&#160;
                            <xsl:value-of select="element[@type='snow_elevation_3']"/>
                            m:&#160;
                            <xsl:value-of select="element[@type='probability_of_snow_at_elevation_3']"/>
                            <table>
                                <xsl:for-each select="$extDoc1/product/forecast/area[@type='location']">
                                    <xsl:variable name="pos2" select="position()"/>
                                    <tr>
                                        <th><xsl:value-of select="$aacSorted[$pos2]/@description"/></th>
                                        &#160;
                                        <th><xsl:value-of select="$aacSorted[$pos2]/forecast-period[@index=$pos]/text"/></th>
                                        <th>Min&#160;<xsl:value-of select="$aacSorted[$pos2]/forecast-period[@index=$pos]/element[@type='air_temperature_minimum']"/></th>
                                        <th>Max&#160;<xsl:value-of select="$aacSorted[$pos2]/forecast-period[@index=$pos]/element[@type='air_temperature_maximum']"/></th>
                                    </tr>
                                    <br/>
                                </xsl:for-each>
                            </table>
                        </div>
                    </div>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
