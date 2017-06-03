open Ast_mapper
open Asttypes
open Parsetree
open Longident

let sign = function
  | 0 -> 1
  | n -> n / (abs n)

let int_to_constant i =
  {
    pexp_desc = Pexp_constant (Pconst_integer (string_of_int i, None));
    pexp_loc = Location.none; pexp_attributes = []
  }

let nondeterministic_mapper argv =
  { default_mapper with
    expr = (fun mapper expr -> match expr with
      | {pexp_desc = Pexp_constant (Pconst_integer (n_str, None))} ->
          let n = int_of_string n_str in
          if (n = 0) then [%expr [%e int_to_constant 0]] else
            let order_of_magnitue = 10 * abs n in
            [%expr (let () = Random.self_init () in
              [%e sign n |> int_to_constant] * Random.int [%e order_of_magnitue |> int_to_constant])]
      | x -> default_mapper.expr mapper x)
  }

let () = register "nondeterministic" nondeterministic_mapper
