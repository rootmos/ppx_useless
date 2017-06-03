let pow n exp =
  let rec go acc = function
    | 0 -> 1
    | 1 -> n*acc
    | e -> go (n*acc) (e-1) in
  go 1 exp

let a n = (2*(pow n 4) + 4*(pow n 3) + 10*(pow n 2) + 8*n + 3)/3

let () =
  let open Array in
  let n = if length Sys.argv > 1 then Sys.argv.(1) |> int_of_string else 30 in
  init n (fun i -> i)
    |> map a
    |> iter (fun x -> print_int x; print_newline ())
