# Simple iOS Calculator App using SwiftUI and MVVM 

The Calculator functionality is implemented similar to an API, such that every class has a single responsibility, thus making the Calculator model independent. The Calculator focuses only on receiving inputs, computing and returning the result.

## The Calculator API

The calculator will perform several "API" calls, corresponding to the press of one button: 
  * setDigit(_ digit: Digit)
  * setOperation(_ operation: Operation)
  * evaluate()
  * setDecimal()
  * allClear()
  * clear()
  * toggleSign()
  * setPercent()

![Simulator Screenshot - iPhone 15 Pro - 2025-03-25 at 11 03 32](https://github.com/user-attachments/assets/78307bff-b480-4fde-9f77-5d4f5b3755e4)

## TODO

Update the **CalculatorView** with the partial result and an overview of the current operation.
