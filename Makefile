SRC=$(shell git ls-files .)

ppx_useless.native: $(SRC)
	ocamlbuild -use-ocamlfind $@

%.useless: %.ml ppx_useless.native
	ocamlfind ocamlc -o $@ -ppx ./ppx_useless.native $<

%.useless.ml: %.ml ppx_useless.native
	ocamlfind ppx_tools/rewriter ./ppx_useless.native $<

%.useful: %.ml
	ocamlfind ocamlc -o $@ $<

%.parsetree: %.ml
	ocamlc -dparsetree $< 2>&1
	rm $*.cm*

.PHONY: utop
utop:
	utop -ppx ./ppx_useless.native

.PHONY: clean
clean:
	ocamlbuild -clean
