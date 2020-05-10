# XML_FILES := $(filter-out *.xsl.xml, $(wildcard *.xml))

SOURCEXML := openlyrics/*.xml
SOURCEDIR := openlyrics
EXPORTDIR := export-openlyrics-0.8

.PHONY: all
all: well-formed validate export08 xsl pdf clean

.PHONY: well-formed
well-formed: openlyrics-0.9-to-openlyrics-0.8.xsl \
             stylesheets/openlyrics.xsl \
             stylesheets/book.xsl \
             stylesheets/xsl/openlyrics.08chords.xsl \
             stylesheets/xsl/openlyrics.09chords.xml \
             stylesheets/xsl/openlyrics.lang.en.xml \
             stylesheets/xsl/openlyrics.lang.hu.xml
	@echo "Checking..." $^
	@xmllint --noout $^

.PHONY: http
http:
	@python3 -m http.server

.PHONY: validate
validate: $(SOURCEXML)
	@cd openlyrics && for file in *.xml; do \
		if grep -q 'version="0.8"' "$$file"; then echo -n "Validating (0.8)... " && xmllint --noout --relaxng ../openlyrics-0.8.rng "$$file"; fi; \
	done
# If 0.9

.PHONY: pretty
pretty: openlyrics/*.xml
	@cd openlyrics && for file in *.xml; do ../make-pretty "$$file" "../make-pretty.conf"; done

.PHONY: export08
export08: openlyrics/*.xml
	@cd export-openlyrics-0.8 && rm -f *.xml && cd ..
	@echo "Deleting export-openlyrics/.xml files"
	@cd openlyrics && for file in *.xml; do \
		if grep -q 'version="0.9"' "$$file"; then echo -n "Converting to OpenLyrics 0.8... $$file\n" && xsltproc -o ../export-openlyrics-0.8/"$$file" ../openlyrics-0.9-to-openlyrics-0.8.xsl "$$file"; fi; \
	done
	@cd export-openlyrics-0.8 && for file in *.xml; do \
		../make-pretty "$$file" "../make-pretty.conf"; \
	done
	@cd export-openlyrics-0.8 && for file in *.xml; do \
		echo -n "Validating... " && xmllint --noout --relaxng ../openlyrics-0.8.rng "$$file"; \
	done

.PHONY: xsl
xsl: openlyrics/*.xml
	@cd openlyrics && rm -f *.xsl.xml && cd ..
	@cd openlyrics && for file in *.xml; do ../make-xsl "$$file" "."; done

.PHONY: pdf
pdf: openlyrics/*.xml
	@cd openlyrics && for file in *.xml; do ../make-pdf "$$file" "../export-pdf"; done

.PHONY: clean
clean:
	@rm -f openlyrics/*.xsl.xml

.PHONY: help
help:
	@echo "Targets:"
	@echo "  all         - Perform all operations"
	@echo "  well-formed - Checks that transforming XSL and XML are well formed"
	@echo "  validate    - Validates presented OpenLyrics XML files against RelaxNG scheme"
	@echo "  xsl         - Generates XSL versions"
	@echo "  pdf         - Generates PDF files"
	@echo "  clean       - Removes all generated XSL version"
	@echo "  http        - Creates a light HTTP server. Stopping: Ctrl+C"
	@echo "  export08    - Converts OpenLyrics 0.9 files to OpenLyrics 0.8"
	@echo "  pretty      - Format OpenLyrics XML source"
