#!/bin/bash

# Generate PDF from pure XML and width XSLT
for file in *.xml
do
  if [[ "$file" =~ \.xsl\.xml$ ]] ; then
    echo "XML->HTML: $file"
    xsltproc "$file"  &>"$(basename "$file" .xml).html"
  else
    echo "Generate PDF from XML: $file"
    prince "$file" -o "pdf/$(basename "$file" .xml).pdf" --pdf-author="Gyuris Gellért"
  fi
done

for file in *.html
do
 echo "Generate PDF from HTML: $file"
 prince "$file" -o "pdf/$(basename "$file" .html).pdf" --pdf-author="Gyuris Gellért"
 rm "$file"
done
