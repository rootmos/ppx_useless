open Ast_mapper
open Asttypes
open Parsetree
open Longident

let diverge_mapper argv =
  { default_mapper with
    expr = (fun mapper expr -> [%expr let rec diverge () = diverge () in diverge ()])
  }

let () = register "diverge" diverge_mapper
