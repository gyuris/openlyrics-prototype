#!/bin/bash
for file in *.xml
do
 echo "XML->HTML: $file"
 xsltproc xsl/openlyrics.xsl "$file"  &>"$(basename "$file" .xml).html"
done

for file in *.html
do
 echo "HTML->PDF: $file"
 prince "$file" -o "pdf/$(basename "$file" .html).pdf"
 rm "$file"
done
