#!/bin/bash

# Generate PDF from pure XML and width XSLT
for file in *.xml
do
  if [[ "$file" =~ \.xsl\.xml$ ]] ; then
    echo "XML->HTML: $file"
    xsltproc xsl/openlyrics.xsl "$file"  &>"$(basename "$file" .xml).html"
  else
    echo "Generate PDF: $file"
    prince "$file" -o "pdf/$(basename "$file" .xml).pdf"
  fi
done

for file in *.html
do
 echo "Generate PDF: $file"
 prince "$file" -o "pdf/$(basename "$file" .html).pdf"
 rm "$file"
done
