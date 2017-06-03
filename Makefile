SRC=$(shell git ls-files .)

ppx_useless.native: $(SRC)
	ocamlbuild -use-ocamlfind $@

%.useless.ml: %.ml ppx_useless.native
	ocamlfind ppx_tools/rewriter ./ppx_useless.native $< | tee $@

%.parsetree: %.ml
	ocamlc -dparsetree $< 2>&1 | tee $@
	rm $*.cm*

.PHONY: dumpast
dumpast:
	ocamlfind ppx_tools/dumpast snippet.ml

.PHONY: clean
clean:
	ocamlbuild -clean
