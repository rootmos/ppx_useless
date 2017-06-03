SRC=$(shell git ls-files .)

%.native: $(SRC)
	ocamlbuild -use-ocamlfind $@

%.useless: %.ml ppx_useless.native
	ocamlfind ocamlc -o $@ -ppx ./ppx_useless.native $<

%.useless.ml: %.ml ppx_useless.native
	ocamlfind ppx_tools/rewriter ./ppx_useless.native $<

%.diverge: %.ml ppx_diverge.native
	ocamlfind ocamlc -o $@ -ppx ./ppx_diverge.native $<

%.useful: %.ml
	ocamlfind ocamlc -o $@ $<

%.parsetree: %.ml
	ocamlc -dparsetree $< 2>&1
	rm $*.cm*

useless-utop: ppx_useless.native
	utop -ppx ./$<

diverge-utop: ppx_diverge.native
	utop -ppx ./$<

clean:
	ocamlbuild -clean
	find . -name "*.cmo" -delete -or -name "*.cmi" -delete
