#!/bin/bash
for file in *.xml
do
 echo "-> $file"
 prince "$file" -o "pdf/$(basename "$file" .txt).pdf"
done
