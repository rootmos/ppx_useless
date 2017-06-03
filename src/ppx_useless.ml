open Ast_mapper
open Asttypes
open Parsetree
open Longident

let useless_mapper argv = default_mapper

let () = register "useless" useless_mapper
