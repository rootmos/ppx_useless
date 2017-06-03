open Ast_mapper
open Asttypes
open Parsetree
open Longident

let useless_mapper argv =
  { default_mapper with
    structure = (fun mapper structure -> [%str let () = ()])
  }


let () = register "useless" useless_mapper
