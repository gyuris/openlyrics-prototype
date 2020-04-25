# XML_FILES := $(filter-out *.xsl.xml, $(wildcard *.xml))

.PHONY: all
all: validate-xsl validate-ol pdf clean

.PHONY: validate-xsl
validate-xsl: stylesheets/openlyrics.xsl \
              stylesheets/book.xsl \
              stylesheets/xsl/openlyrics.08chords.xsl \
              stylesheets/xsl/openlyrics.09chords.xml \
              stylesheets/xsl/openlyrics.lang.en.xml \
              stylesheets/xsl/openlyrics.lang.hu.xml
	xmllint --noout $^

.PHONY: validate-ol
validate-ol: *.xml
	for file in *.xml; do ./validate-ol "$$file"; done

.PHONY: pdf
pdf: *.xml
	for file in *.xml; do ./make-pdf "$$file"; done

.PHONY: clean
clean:
	rm -f *.xsl.xml

.PHONY: help
help:
	@echo "Targets:"
	@echo "   pdf    - Generate pdf files"
	@echo "   clean  - Remove all generated XML source with XSL version"
