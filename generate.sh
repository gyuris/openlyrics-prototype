#!/bin/bash

# OpenLyrics prototype: generate PDF
# Prerequisites:
# - xsltproc
# - prince (v12): https://www.princexml.com

# Generate book
################
echo "BOOK XML mod: book.xml"
# Book needs extra xslt tranlsation to do xi:includes but without --xinclude param
xsltproc book.xml &> book.xsl.xml
# Replace CSS with XSL and remove CSS tweaks
sed -i -e 's/href="stylesheets\/openlyrics\.css" type="text\/css"/href="stylesheets\/openlyrics\.xsl" type="text\/xsl"/g' \
    -e 's/ tweak="nested"//g' \
    -e 's/ tweak="linebreak"//g' \
    book.xsl.xml

# Generate XML with another xml-stylesheet
###########################################
for file in *.xml
do
  if [[ $file == 'book.xml' ]] || [[ "$file" =~ \.xsl\.xml$ ]] ; then
    # Nothing to do
    echo "Skip      : $file"
  else
    # Modify XML source
    echo "XML mod   : $file"
    # Replace CSS with XSL and remove CSS tweaks, save it in another file
    sed -e 's/href="stylesheets\/openlyrics\.css" type="text\/css"/href="stylesheets\/openlyrics\.xsl" type="text\/xsl"/g' \
        -e 's/ tweak="nested"//g' \
        -e 's/ tweak="linebreak"//g' \
        "$file" &>"$(basename "$file" .xml).xsl.xml"
  fi
done

# Generate PDF-s
#################
for file in *.xml
do
  if [[ "$file" =~ \.xsl\.xml$ ]] ; then
    # XSLT version: XML->HTML->PDF
    echo " XML->HTML: $file"
    # Generate HTML
    xsltproc "$file"  &> "$(basename "$file" .xml).html"
    echo "HTML->PDF : $file"
    # Generate PDF
    prince "$(basename "$file" .xml).html" -o "pdf/$(basename "$file" .xml).pdf" --pdf-author="Gyuris Gellért" --pdf-title="$(basename "$file" .xml)"
    # Remove HTML
    rm "$(basename "$file" .xml).html"
  else
    # CSS version: XML->PDF
    echo " XML->PDF : $file"
    # Generate PDF
    prince --javascript --script=stylesheets/css/xml/openlyrics-0.9-chord.xml.js "$file" -o "pdf/$(basename "$file" .xml).pdf" --pdf-author="Gyuris Gellért" --pdf-title="$(basename "$file" .xml)"
  fi
done
