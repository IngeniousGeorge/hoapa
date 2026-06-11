TEXDIR := ../communication_drafts
BUILDDIR := $(TEXDIR)/build
TEX := $(wildcard $(TEXDIR)/*.tex)
PDF := $(TEX:.tex=.pdf)

.PHONY: all pdf clean

all: pdf

pdf: $(PDF)

$(TEXDIR)/%.pdf: $(TEXDIR)/%.tex
	mkdir -p $(BUILDDIR)
	latexmk -pdf -interaction=nonstopmode -halt-on-error -file-line-error \
		-outdir=$(BUILDDIR) $<
	cp $(BUILDDIR)/$*.pdf $@

clean:
	rm -rf $(BUILDDIR)
