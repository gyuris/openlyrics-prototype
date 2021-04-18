# openlyrics-prototype

Prototype for [openlyrics single-source](https://github.com/openlyrics/openlyrics/issues/29) project
to display OpenLyrics XML on screen and print media with pure CSS or XSLT(+CSS).

## Requirements

- [GNU Make](https://www.gnu.org/software/make/) (for building)
- [xmllint](http://xmlsoft.org/xmllint.html) (for checking XML files and OpenLyrics validity)
- [xsltproc](http://xmlsoft.org/XSLT/xsltproc.html) (for XSLT transformations)
- [xmlformat](http://www.kitebird.com/software/xmlformat/) (to make pretty printed OpenLyrics XML)
- [Prince](https://www.princexml.com/) or [WeasyPrint](https://weasyprint.org/) or [Paged.js](https://www.pagedjs.org/) (to create PDF
output): Prince supports XML and HTML output, WeasyPrint and Paged.js supports only HTML version. Prince is the default tool.


## Concept

Main goal is to use OpenLyrics XML as single source for lyrics projection (OpenLP) and creating
chordsheets for web browsers and for print media (PDF) as well as printed songbooks. This project adds an CSS or XSLT stylesheet
to OpenLyrics (not part of the standard) to display OpenLyrics with web browsers (XML or HTML) or PDF readers.
By design XML+CSS output is for OpenLyrics editors, and XSLT(HTML)+CSS version is for publishers
to create songbooks.

## Usage

Download and open XML files with Firefox or Chrome. Pay atteintion on [local file security
policy](https://developer.mozilla.org/hu/docs/Web/HTTP/CORS/Errors/CORSRequestNotHttp),
use `make http`. For available actions see `make help`. For building install prerequisites and run 'make'.

Two diplay method:

- Pure CSS: display XML with CSS (for editors)
- XSLT ("xsl" in the file name): convert XML with XSLT transformation to HTML and display with HTML+CSS (for publishers)

Parts:

- /songs: Sample OpenLyrics (0.8 and 0.9) source files (can be viewed with web browsers)
- /books: Generated songbooks from OpenLyrics source files
- /stylesheets: CSS and XSLT stylesheets for individual OL files and for books
- /tool: tools for converting
- /export-chordpro: Converted OpenLyrics files to ChordPro
- /export-openlyrics-0.8: Converted OpenLyrics files back to 0.8
- /export-pdf: Converted OpenLyrics file to PDF

## OpenLyrics 0.9

We use unreleased 0.9 version of OpenLyrics. During this project we have designed and developed   new elements and attributes for OpenLyrics  0.9, which have already been [included](https://github.com/openlyrics/openlyrics/pull/56):

- [Processing instructions]( https://github.com/openlyrics/openlyrics/issues/31) for CSS or XSL
- song/@version: 0.9
- [song/@xml:lang](https://github.com/openlyrics/openlyrics/issues/32): Language of the file (not only for lyrics) Optional, default is 'en'
- song/@chordNotation: Chord notation, possible values: english, english-b, german, dutch, hungarian, neolatin
- [song/lyrics/instrument](https://github.com/openlyrics/openlyrics/issues/35): Intrumental parts: intro, middle, outro and solo
- [song/lyrics/instrument/beat](https://github.com/openlyrics/openlyrics/issues/36): For instrumenta
- [song/lyrics/verse/lines/@repeat](https://github.com/openlyrics/openlyrics/issues/37): Repeating for lines
- [//chord/@root, //chord/@structure, //chord/@bass](https://github.com/openlyrics/openlyrics/issues/52) + New chord [non empty notation](https://github.com/openlyrics/openlyrics/issues/54)

There are a simple converter to current wide used OpenLyrics 0.8 and ChordPro standards.
