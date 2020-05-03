# XML_FILES := $(filter-out *.xsl.xml, $(wildcard *.xml))

.PHONY: all
all: well-formed validate convert08 xsl pdf clean

.PHONY: well-formed
well-formed: openlyrics-09-to-openlyrics-08.xsl \
              stylesheets/openlyrics.xsl \
              stylesheets/book.xsl \
              stylesheets/xsl/openlyrics.08chords.xsl \
              stylesheets/xsl/openlyrics.09chords.xml \
              stylesheets/xsl/openlyrics.lang.en.xml \
              stylesheets/xsl/openlyrics.lang.hu.xml
	xmllint --noout $^

.PHONY: http
http:
	python3 -m http.server

.PHONY: validate
validate: *.xml
	@for file in *.xml; do \
		if grep -q 'version="0.8"' "$$file"; then echo -n "Validating... " && xmllint --noout --relaxng openlyrics-0.8.rng "$$file"; fi; \
	done
# If 0.9

.PHONY: convert08
convert08: *.xml
	cd converted && rm -f *.xml && cd ..
	@for file in *.xml; do \
		if grep -q 'version="0.9"' "$$file"; then echo -n "Converting to OpenLyrics 0.8... $$file\n" && xsltproc -o converted/"$$file" openlyrics-09-to-openlyrics-08.xsl "$$file"; fi; \
	done
	@for file in converted/*.xml; do \
		echo -n "Validating... " && xmllint --noout --relaxng openlyrics-0.8.rng "$$file"; \
	done


.PHONY: xsl
xsl: *.xml
	rm -f *.xsl.xml
	@for file in *.xml; do ./make-xsl "$$file"; done

.PHONY: pdf
pdf: *.xml
	@for file in *.xml; do ./make-pdf "$$file"; done

.PHONY: clean
clean:
	rm -f *.xsl.xml

.PHONY: help
help:
	@echo "Targets:"
	@echo "  all         - Perform all operations"
	@echo "  well-formed - Checks that transforming XSL and XML are well formed"
	@echo "  validate    - Validates presented OpenLyrics XML files against RelaxNG scheme"
	@echo "  xsl         - Generates XSL versions"
	@echo "  pdf         - Generates PDF files"
	@echo "  clean       - Removes all generated XSL version"
	@echo "  http        - Creates a light HTTP server. See: https://developer.mozilla.org/hu/docs/Web/HTTP/CORS/Errors/CORSRequestNotHttp Stopping: Ctrl+C"
	@echo "  convert08   - Converts OpenLyrics 0.9 files to OpenLyrics 0.8"
