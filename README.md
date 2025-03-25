# Simple iOS Calculator App using SwiftUI and MVVM 

The Calculator functionality is implemented similar to an API, such that every class has a single responsibility, thus making the Calculator model independent. The Calculator focuses only on receiving inputs, computing and returning the result.

The calculator will perform several "API" calls, corresponding to the press of one button: 
  * setDigit(_ digit: Digit)
  * setOperation(_ operation: Operation)
  * evaluate()
  * setDecimal()
  * allClear()
  * clear()
  * toggleSign()
  * setPercent()


