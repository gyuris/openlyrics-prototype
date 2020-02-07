# XML_FILES := $(filter-out *.xsl.xml, $(wildcard *.xml))

.PHONY: all
all: pdf clean

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
