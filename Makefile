SOURCEDIR   := songs
SOURCEXML   := songs/*.xml
BOOKDIR     := books
BOOKXML     := books/*.xml
EXPORT_OL08 := export-openlyrics-0.8
EXPORT_CHO  := export-chordpro
EXPORT_PDF  := export-pdf
TOOL        ?= prince

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
	@for file in $(SOURCEXML); \
		do \
			if grep -q 'version="0.8"' "$$file"; \
			then \
				echo -n "Validating (0.8)... " && \
				xmllint \
					--noout \
					--relaxng openlyrics-0.8.rng \
					"$$file"; \
			fi; \
			if grep -q 'version="0.9"' "$$file"; \
			then \
				echo -n "Validating (0.9)... " && \
				xmllint \
					--noout \
					--relaxng openlyrics-0.9.rng \
					"$$file"; \
			fi; \
		done

.PHONY: pretty
pretty: $(SOURCEXML) $(BOOKXML)
	@for file in $(SOURCEXML); \
		do \
			./make-pretty "$$file"; \
		done
	@for file in $(BOOKXML); \
		do \
			./make-pretty "$$file"; \
		done

.PHONY: export-ol08
export-ol08: songs/*.xml
	@rm -f $(EXPORT_OL08)/*.xml
	@echo "Deleting $(EXPORT_OL08)/*.xml files"
	@for file in $(SOURCEXML); \
		do \
			if grep -q 'version="0.9"' "$$file"; \
			then \
				echo -n "Converting to OpenLyrics 0.8... $$file\n" && \
				name=$${file##*/} && \
				xsltproc \
					--output $(EXPORT_OL08)/"$$name" \
					tools/openlyrics-0.9-to-openlyrics-0.8.xsl \
					"$$file"; \
			fi; \
		done
	@for file in $(EXPORT_OL08)/*.xml; \
		do \
			./make-pretty "$$file"; \
		done
	@for file in $(EXPORT_OL08)/*.xml; \
		do \
			echo -n "Validating... " && \
			xmllint \
				--noout \
				--relaxng openlyrics-0.8.rng \
				"$$file"; \
		done

.PHONY: export-cho
export-cho: $(SOURCEXML)
	@rm -f $(EXPORT_CHO)/*.cho
	@echo "Deleting $(EXPORT_CHO)/*.cho files"
	@for file in $(SOURCEXML); \
		do \
			name=$${file%.xml}.cho && \
			echo -n "Converting to ChordPro... $${name}\n" && \
			name=$${name##*/} && \
			xsltproc \
				--output "$(EXPORT_CHO)/$${name}" \
				tools/openlyrics-to-chordpro.xsl \
				"$$file"; \
		done

.PHONY: xsl
xsl: $(SOURCEXML)
	@rm -f $(SOURCEDIR)/*.xsl.xml
	@for file in $(SOURCEXML); \
		do \
			./make-xsl "$$file"; \
		done

.PHONY: pdf
pdf: $(SOURCEXML)
	@for file in $(SOURCEXML); \
		do \
			./make-pdf -p ../$(EXPORT_PDF) -t "$(TOOL)" "$$file"; \
		done

.PHONY: clean
clean:
	@rm -f $(SOURCEDIR)/*.xsl.xml
	@echo "Deleting $(SOURCEDIR)/*.xsl.xml files"
	@rm -f $(BOOKDIR)/*.xsl.xml
	@echo "Deleting $(BOOKDIR)/*.xsl.xml files"

.PHONY: books
books: $(SOURCEXML) $(BOOKXML)
	@cd $(BOOKDIR) && \
	rm -f *.xsl.xml
	@./make-books
	@for file in  $(BOOKXML); \
		do \
			./make-xsl "$$file" "books"; \
		done
	@for file in $(BOOKDIR)/*.xsl.xml; \
		do \
			./make-pdf -p ../$(BOOKDIR) -t "$(TOOL)" -b public "$$file"; \
			./make-pdf -p ../$(BOOKDIR) -t "$(TOOL)" -b band   "$$file"; \
		done

.PHONY: help
help:
	@echo "Targets:"
	@echo "  all         - Perform all operations."
	@echo "  well-formed - Checks that transforming XSL and XML are well formed."
	@echo "  validate    - Validates presented OpenLyrics XML files against RelaxNG scheme."
	@echo "  xsl         - Generates XSL versions."
	@echo "  pdf         - Generates PDF files. Optional TOOL parameter specifies the tool: prince, weasyprint or pagedjs. Example: make pdf TOOL=weasyprint. Prince is the default tool."
	@echo "  books       - Generates books XSL and PDF. Optional TOOL parameter specifies the tool: prince, weasyprint or pagedjs. Example: make books TOOL=pagedjs. Prince is the default tool."
	@echo "  clean       - Removes all generated XSL version."
	@echo "  http        - Creates a light HTTP server. Stopping: Ctrl+C."
	@echo "  export-ol08 - Converts OpenLyrics 0.9 files to OpenLyrics 0.8."
	@echo "  export-cho  - Converts OpenLyrics files to ChordPro."
	@echo "  pretty      - Format OpenLyrics XML source."
