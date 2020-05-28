//
//  ViewController.swift
//  My Calculator
//
//  Created by Safiya Mufti on 2020-05-09.
//  Copyright © 2020 Safiya Mufti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var holder: UIView!
    
    // need to create 3 variables to whole numbers during calculations
    
    var firstNumber = 0
    var resultNumber = 0
    var currentOperations: Operation?
    
    // create an enum Operations
    enum Operation {
        case add, subtract, multiply, divide
    }
    
    // create result label
    private var resultLabel: UILabel = {
    let label = UILabel()
    label.text = "0"
        label.textColor = .white
        label.backgroundColor = .black
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 90)
        return label
       
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupNumberPad()
     
    }
    private func setupNumberPad() {
        let buttonSize : CGFloat = view.frame.size.width / 4
        // you want height to be relative to the holder not to the entire screen
        
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - buttonSize, width: buttonSize*3, height: buttonSize))
        
        // add title to the button (what u will see on screen)
        zeroButton.setTitle("0", for: .normal)
        
        // change title colour]
        zeroButton.setTitleColor(.black , for: .normal)
        
        // add bg colour
        zeroButton.backgroundColor = .white
        
        // add value to the button
        zeroButton.tag = 1
        
        // need to add target or nothing will happen
        zeroButton.addTarget(self, action: #selector(zeroTapped), for: .touchUpInside)
        
        // now add this button tp the holder (ur iboutlet variable)
        holder.addSubview(zeroButton)
        
        // now we create a for loop to create buttons 1,2,3
        
        for x in 0..<3  {
            
            let button1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*2), width: buttonSize, height: buttonSize))
            
            button1.setTitleColor(.black , for: .normal)
        
            button1.backgroundColor = .white
            
            button1.setTitle("\(x+1)", for: .normal)
            
            button1.tag = x + 2
            
            button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)

            holder.addSubview(button1)
            
        }
        
        // now we create a for loop to create buttons 4,5,6
        for x in 0..<3  {
            
            let button2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*3), width: buttonSize, height: buttonSize))
            
            button2.setTitleColor(.black , for: .normal)
        
            button2.backgroundColor = .white
            
            button2.setTitle("\(x+4)", for: .normal)
            
            button2.tag = x + 5
            
            button2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)

            holder.addSubview(button2)
            
        }
        
        // now we create a for loop to create buttons 7,8,9
        for x in 0..<3  {
            
            let button3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*4), width: buttonSize, height: buttonSize))
            
            button3.setTitleColor(.black , for: .normal)
        
            button3.backgroundColor = .white
            
            button3.setTitle("\(x+7)", for: .normal)
            
            button3.tag = x + 8
            
            button3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)

            holder.addSubview(button3)
            
        }
        
        // now we create the clear button
            
            let clearButton = UIButton(frame: CGRect(x:0, y: holder.frame.size.height-(buttonSize*5), width: view.frame.size.width - buttonSize, height: buttonSize))
            
            clearButton.setTitleColor(.black , for: .normal)
        
            clearButton.backgroundColor = .lightGray
            
            clearButton.setTitle("CLEAR ALL", for: .normal)

            holder.addSubview(clearButton)
            
            // create an array called operations (building bottom up)
            
        let operations = ["=", "+", "-", "x", "/"]
        
         for x in 0..<5  {
            let button4 = UIButton(frame: CGRect(x: buttonSize * 3, y: holder.frame.size.height-(buttonSize*CGFloat(x+1)), width: buttonSize, height: buttonSize))
        
            button4.setTitleColor(.white , for: .normal)
            
            button4.backgroundColor = .orange
            
            button4.setTitle(operations[x], for: .normal)
            
            button4.tag = x + 1
            
            button4.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
            
            holder.addSubview(button4)
            
        }
        // configure frame for label
        resultLabel.frame = CGRect(x: 20, y: clearButton.frame.origin.y - 110.0, width: view.frame.size.width-40, height: 100.0)
        holder.addSubview(resultLabel)
        
        // ACTIONS
        
        clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
        
    }
    // we create an objc C func bc that's how selectors get called
    @objc func clearResult() {
        resultLabel.text = "0"
        currentOperations = nil
        firstNumber = 0
        
    }
    
    @objc func zeroTapped() {
        if resultLabel.text != "0" {
            if let text = resultLabel.text {
                resultLabel.text = "\(text)\(0)"
            }
        }
    }
    
    
    @objc func numberPressed(_ sender: UIButton) {
        let tag = sender.tag - 1 // subtract 1 bc we dont include the 0 in any of the tags
        if resultLabel.text == "0" {
            resultLabel.text = "\(tag)"
            
        }
        else if let text = resultLabel.text {
            resultLabel.text = "\(text)\(tag)"
        }
    }
    
    @objc func operationPressed(_ sender: UIButton) {
        let tag = sender.tag
        // if the first number is not already set, then :
        
        if let text = resultLabel.text, let value = Int(text), firstNumber == 0 {
            firstNumber = value
            resultLabel.text = "0"
        }
        
        if tag == 1 {
            if let operation = currentOperations { // proceed if only there is an operation
                var secondNumber = 0
                if let text = resultLabel.text, let value = Int(text) {
                    secondNumber = value
                }
                
                switch operation {
                case .add:
                    let result = firstNumber + secondNumber
                    resultLabel.text = "\(result)"
                    break
                    
                case .subtract:
                    let result = firstNumber - secondNumber
                    resultLabel.text = "\(result)"
                    break
                    
                case .multiply:
                    let result = firstNumber * secondNumber
                    resultLabel.text = "\(result)"
                    break
                    
                case .divide:
                    assert(secondNumber == 0, "Division by zero!")
                    let result = firstNumber / secondNumber
                    resultLabel.text = "\(result)"
                    break
                    }
                    
            }
            
        }
        else if tag == 2 {
            currentOperations = .add
            
        }
        else if tag == 3 {
            currentOperations = .subtract   
            
        }
        else if tag == 4 {
            currentOperations = .multiply
            
        }
        else if tag == 5 {
            currentOperations = .divide
            
        }
        
    }
    
}

