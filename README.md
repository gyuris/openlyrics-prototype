# openlyrics-prototype
Prototype for [openlyrics single-source](https://github.com/openlyrics/openlyrics/issues/29) project to display OpenLyrics on screen and print media with pure CSS or XSLT.

Usage
=====

Download and open XML files with Firefox.

There are two version:

- Simple: display with pure CSS
- "xsl" in the file name: display with XSLT transformation and CSS

OpenLyrics 0.9 new elements
===========================

- Processing instructions - https://github.com/openlyrics/openlyrics/issues/31
- song/@version : 0.9
- song/@xml:lang : Language of the file (not only for lyrics) - https://github.com/openlyrics/openlyrics/issues/32
- song/@chordnotation : Chordnotation, possible values: english, german, dutch, hungarian, neolatin
- song/lyrics/instrument : Intrumental parts: intro, middle, outro and solo. - https://github.com/openlyrics/openlyrics/issues/35
- song/lyrics/instrument/beat : For instrumental - https://github.com/openlyrics/openlyrics/issues/36
- song/lyrics/verse/lines@repeat : Repeating for lines - https://github.com/openlyrics/openlyrics/issues/37
