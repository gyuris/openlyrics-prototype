#!/bin/bash

# Replace xml-stylesheet from CSS to XSL and save an another file
for file in *.xml
do
  if [[ "$file" =~ \.xsl\.xml$ ]] ; then
    echo "Skipping: $file"
  else
    echo "-> $file"
    sed -s 's/href="stylesheets\/openlyrics\.css" type="text\/css"/href="stylesheets\/openlyrics\.xsl" type="text\/xsl"/' "$file" &>"$(basename "$file" .xml).xsl.xml"
  fi
done
