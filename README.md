# MrCalc

A simple program to calculate `molecular mass` :)

## Note

The `molecular mass` of the atoms in `MrData.hs` is not complete
, do remember to modify `elementsData` in it.

## Usage

### Use Repl

``` sh
% runhaskell Repl.hs
Formula:
```

You can just run the `Repl.hs` file and start inputing formulas :)

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

More examples can be found in [`Example.hs`](Example.hs)
