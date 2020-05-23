# MrCalc

A simple program to calculate `molecular mass` :)

## Note

The `molecular mass` of the atoms in `MrData.hs` is not complete
, do remember to modify `elementsData` in it.

## Usage

### Compile and Run

``` sh
% ghc -o MrCalc Main.hs Calc.hs MrData.hs -O2
% ./MrCalc
```

### Use Repl

``` sh
% runhaskell Main.hs
Mr Calculator
Formula>
```

You can just run the `Main.hs` file and start inputing formulas :)

> Options:  
> `:h` to show help
> `:q` to quit  
> `:e` for examples

### Load them to GHCi

First load them to GHCi

``` haskell
Prelude> :l Calc.hs MrData.hs
```

Then use the function `getSum` to get the result.
The following is an example.

``` haskell
*Calc> getSum "H2O"
Just 18.0
```
