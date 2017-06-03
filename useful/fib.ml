let rec fib = function
  | 0 -> 1
  | 1 -> 1
  | n -> fib (n - 1) + fib (n - 2)

let () =
  let open Array in
  init 30 (fun i -> i)
    |> map fib
    |> iter (fun x -> print_int x; print_newline ())
