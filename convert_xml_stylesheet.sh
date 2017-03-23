#!/bin/bash

# Replace xml-stylesheet from CSS to XSL, remove tweaks and save an another file
for file in *.xml
do
  if [[ "$file" =~ \.xsl\.xml$ ]] ; then
    echo "Skipping: $file"
  else
    echo "-> $file"
    sed -e 's/href="stylesheets\/openlyrics\.css" type="text\/css"/href="stylesheets\/openlyrics\.xsl" type="text\/xsl"/' \
        -e 's/ tweak="nested"//' \
        -e 's/ tweak="linebreak"//' \
        "$file" &>"$(basename "$file" .xml).xsl.xml"
  fi
done
