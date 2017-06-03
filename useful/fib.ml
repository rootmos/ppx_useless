let rec fib = function
  | 0 -> 1
  | 1 -> 1
  | n -> fib (n - 1) + fib (n - 2)

let () =
  let open Array in
  let n = if length Sys.argv > 1 then Sys.argv.(1) |> int_of_string else 30 in
  init n (fun i -> i)
    |> map fib
    |> iter (fun x -> print_int x; print_newline ())
