//
//  CalculatorViewController.swift
//  CalculatorNormal
//
//  Created by Dan Livingston  on 3/16/16.
//  Copyright © 2016 Some Peril. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var operandStack = [Double]()
    var operatorSymbol: String?
    var userIsInTheMiddleOfTypingANumber = false
    
    // not used for user typing, just calculations
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            // remove ".0" from display
            if newValue == floor(newValue) {
                display.text = "\(Int(newValue))"
            } else {
                display.text = "\(newValue)"
            }
            
            userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    // User taps a number
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
             display.text! += digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    // User taps an operator
    @IBAction func operate(sender: UIButton) {
        userIsInTheMiddleOfTypingANumber = false
        operatorSymbol = sender.currentTitle!
        operandStack.append(displayValue)
    }
    
    // User taps a equals sign (=)
    @IBAction func equals() {
        if operatorSymbol != nil {
            userIsInTheMiddleOfTypingANumber = false
            operandStack.append(displayValue)
            
            switch operatorSymbol! {
            case "+": performOperation() { $0 + $1 }
            case "−": performOperation() { $1 - $0 }
            case "×": performOperation() { $0 * $1 }
            case "÷": performOperation() { $1 / $0 }
                
            default: break
            }
            
            print("\(operandStack) " + operatorSymbol!)
        }
    }
    
    func performOperation( operation: (Double, Double) -> Double)  {
        displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
        operandStack.append(displayValue)
    }
    
    // User clears memory
    @IBAction func clear() {
        operandStack.removeAll()
        userIsInTheMiddleOfTypingANumber = false
        operatorSymbol = nil
        displayValue = 0
    }
}
