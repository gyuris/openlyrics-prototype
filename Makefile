# XML_FILES := $(filter-out *.xsl.xml, $(wildcard *.xml))

SOURCEXML := songs/*.xml
SOURCEDIR := songs
EXPORTDIR := export-openlyrics-0.8

.PHONY: all
all: well-formed validate export-ol08 export-cho xsl pdf books clean

.PHONY: well-formed
well-formed: tools/openlyrics-0.9-to-openlyrics-0.8.xsl \
             stylesheets/openlyrics.xsl \
             stylesheets/book.xsl \
             stylesheets/xsl/openlyrics-0.8-chord.xsl \
             stylesheets/xsl/openlyrics-0.9-chord.xml \
             stylesheets/xsl/lang-en.xml \
             stylesheets/xsl/lang-hu.xml
	@echo "Checking..." $^
	@xmllint --noout $^

.PHONY: http
http:
	@python3 -m http.server

.PHONY: validate
validate: $(SOURCEXML)
	@cd songs && for file in *.xml; do \
		if grep -q 'version="0.8"' "$$file"; then echo -n "Validating (0.8)... " && xmllint --noout --relaxng ../openlyrics-0.8.rng "$$file"; fi; \
	done
# If 0.9

.PHONY: pretty
pretty: songs/*.xml
	@cd songs && for file in *.xml; do ../make-pretty "$$file" "../tools/xmlformat.conf"; done
	@cd books && for file in *.xml; do ../make-pretty "$$file" "../tools/xmlformat.conf"; done

.PHONY: export-ol08
export-ol08: songs/*.xml
	@cd export-openlyrics-0.8 && rm -f *.xml && cd ..
	@echo "Deleting export-openlyrics/*.xml files"
	@cd songs && for file in *.xml; do \
		if grep -q 'version="0.9"' "$$file"; then echo -n "Converting to OpenLyrics 0.8... $$file\n" \
		&& xsltproc --stringparam datetime `date --iso-8601=seconds` -o ../export-openlyrics-0.8/"$$file" ../tools/openlyrics-0.9-to-openlyrics-0.8.xsl "$$file"; fi; \
	done
	@cd export-openlyrics-0.8 && for file in *.xml; do \
		../make-pretty "$$file" "../tools/xmlformat.conf"; \
	done
	@cd export-openlyrics-0.8 && for file in *.xml; do \
		echo -n "Validating... " && xmllint --noout --relaxng ../openlyrics-0.8.rng "$$file"; \
	done

.PHONY: export-cho
export-cho: songs/*.xml
	@cd export-chordpro && rm -f *.cho && cd ..
	@echo "Deleting export-chordpro/*.cho files"
	@cd songs && for file in *.xml; do \
		echo -n "Converting to ChordPro... $$file\n" \
		&& xsltproc -o ../export-chordpro/"$$file.cho" ../tools/openlyrics-to-chordpro.xsl "$$file"; \
	done

.PHONY: xsl
xsl: songs/*.xml
	@cd songs && rm -f *.xsl.xml && cd ..
	@cd songs && for file in *.xml; do ../make-xsl "$$file" "."; done

.PHONY: pdf
pdf: songs/*.xml
	@cd songs && for file in *.xml; do ../make-pdf "$$file" "../export-pdf"; done

.PHONY: clean
clean:
	@rm -f songs/*.xsl.xml
	@rm -f books/*.xsl.xml

.PHONY: books
books: songs/*.xml books/*.xml
	@cd books && rm -f *.xsl.xml && cd ..
	@cd books && for file in *.xml; do ../make-xsl "$$file" "." "books"; done
	@cd books && for file in *.xsl.xml; do ../make-pdf "$$file" "."; done

.PHONY: help
help:
	@echo "Targets:"
	@echo "  all         - Perform all operations"
	@echo "  well-formed - Checks that transforming XSL and XML are well formed"
	@echo "  validate    - Validates presented OpenLyrics XML files against RelaxNG scheme"
	@echo "  xsl         - Generates XSL versions"
	@echo "  pdf         - Generates PDF files"
	@echo "  books       - Generates books XSL and PDF"
	@echo "  clean       - Removes all generated XSL version"
	@echo "  http        - Creates a light HTTP server. Stopping: Ctrl+C"
	@echo "  export-ol08 - Converts OpenLyrics 0.9 files to OpenLyrics 0.8"
	@echo "  export-cho  - Converts OpenLyrics files to ChordPro"
	@echo "  pretty      - Format OpenLyrics XML source"
