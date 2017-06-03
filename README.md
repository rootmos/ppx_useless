ppx_useless
===========
*Disclaimer* This project is a joke and should be taken seriously only by people without humor.

This project provides the `ppx_useless` [OCaml](https://ocaml.org/) compiler extension, that
replaces the code with the following statement:
```ocaml
let () = ()
```
Now this might seem controversial to the casual, but there are benefits to be had.

Useless features:
* Reduces compile errors
* Reduces runtime errors
* Reduces binary size
* Simplifies debugging
* Increases speed
* Decreases memory usage (both at compile-time and run-time)

Useful features:
* Wastes CPU cycles, which in turn heats your room
* There's at least a possibility that the program produces the
  desired output, which means that any input would suffice as
  a solution, which in turn saves time for the programmer.

However, some programs are not expected to terminate (e.g. server programs)
and for those kinds of programs the `ppx_diverge` is provided that replaces
every expression with:
```ocaml
let rec diverge () = diverge () in diverge ()
```
which provides the desired non-termination.
An added benefit here is that there's no longer any need for messing about
with configuration files!

Here the observant reader interjects: "But even a trivial but deterministic program can be useful (e.g. /bin/true)!"
True, `true` is a very useful program and to address that the `ppx_nondeterministic` extension is provided.
Here's a sample session from `utop`:
```
> 2+2;;
- : int = 4

> 2+2;;
- : int = 3

> 2+2;;
- : int = 5
```
Observe here that there is a possibility of obtaining the expected result.

Usage
-----
The provided `Makefile` contains instructions on how to build the
different useless extensions, but the impatient can invoke [utop](https://github.com/diml/utop)
like so:
* for useless programs: `make useless-utop`
* for non-terminating programs: `make diverge-utop`
* for non-deterministic programs: `make nondeterministic-utop`
