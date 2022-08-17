//
//  ViewController.swift
//  HomeWork12_Karina (calculator)
//
//  Created by Karina Kovaleva on 15.08.22.
//

import UIKit

class ViewController: UIViewController {
    
    var firstInput = true
    var firstNumber: Double = 0
    var secondNumber: Double = 0
    var operationTitle = ""
    
    var input: Double {
        get {
            return Double(labelForResult.text!)!
        }
        set {
            labelForResult.text = "\(newValue)"
            firstInput = true
        }
    }
    
    @IBOutlet var zeroButton: UIButton!
    @IBOutlet var oneButton: UIButton!
    @IBOutlet var twoButton: UIButton!
    @IBOutlet var threeButton: UIButton!
    @IBOutlet var fourButton: UIButton!
    @IBOutlet var fiveButton: UIButton!
    @IBOutlet var sixButton: UIButton!
    @IBOutlet var sevenButton: UIButton!
    @IBOutlet var eightButton: UIButton!
    @IBOutlet var nineButton: UIButton!
    
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var plusMinusButton: UIButton!
    @IBOutlet var percentButton: UIButton!
    @IBOutlet var divideButton: UIButton!
    @IBOutlet var multiplyButton: UIButton!
    @IBOutlet var subtractionButton: UIButton!
    @IBOutlet var additionButton: UIButton!
    @IBOutlet var dotButton: UIButton!
    @IBOutlet var equalButton: UIButton!
    
    @IBOutlet var verticalStackView: UIStackView!
    @IBOutlet var firstStackView: UIStackView!
    @IBOutlet var secondStackView: UIStackView!
    @IBOutlet var thirdStackView: UIStackView!
    @IBOutlet var fourthStackView: UIStackView!
    @IBOutlet var fifthStackView: UIStackView!
    
    @IBOutlet var viewForLabel: UIView!
    
    @IBOutlet var labelForResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = .black
        viewForLabel.backgroundColor = .black
        let arrayOfAllButtons: [UIButton] = [oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton, zeroButton, deleteButton, plusMinusButton, percentButton, divideButton, multiplyButton, subtractionButton, additionButton, dotButton, equalButton]
        let arrayOfAllHorizontalStackView: [UIStackView] = [firstStackView, secondStackView, thirdStackView, fourthStackView, fifthStackView]
        let arrayOfOrangeButtons: [UIButton] = [divideButton, multiplyButton, subtractionButton, equalButton, additionButton]
        let arrayOfLightGrayButtons: [UIButton] = [deleteButton, plusMinusButton, percentButton]
        
        buttonAppearance(buttons: arrayOfAllButtons)
        arrayOfOrangeButtons.forEach { $0.backgroundColor = .orange }
        arrayOfLightGrayButtons.forEach { $0.backgroundColor = .lightGray }
        arrayOfLightGrayButtons.forEach { $0.tintColor = .black }
        zeroButton.titleLabel?.textAlignment = .right
        stackViewAppearance(stackView: arrayOfAllHorizontalStackView)
        verticalStackView.spacing = 10
        verticalStackView.distribution = .fillEqually
    }
    
    @IBAction func digitsButtonPressed(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if firstInput == true {
            labelForResult.text = digit
            if input == 0 {
                firstInput = true
            } else {
            firstInput = false
            }
        } else if labelForResult.text!.count < 10 {
            labelForResult.text = labelForResult.text! + digit
        }
        sender.shortChangeBackground(with: UIColor(red: 1, green: 1, blue: 1, alpha: 0.6))
    }
    
    @IBAction func operationWithTwoNumbers(_ sender: UIButton) {
        operationTitle = sender.currentTitle!
        firstNumber = input
        firstInput = true
        if sender.isTouchInside {
            sender.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            sender.tintColor = .orange
        }
    }
    
    @IBAction func equalOperation(_ sender: Any) {
        let arrayOfOrangeButtons: [UIButton] = [divideButton, multiplyButton, subtractionButton, equalButton, additionButton]
        if firstInput == false {
            secondNumber = input
        }
        switch operationTitle {
        case "+":
            operateWithTwoNumbers {$0 + $1}
        case "-":
            operateWithTwoNumbers {$0 - $1}
        case "×":
            operateWithTwoNumbers {$0 * $1}
        case "÷":
            if secondNumber == 0 {
                let alert = UIAlertController(title: "Alert", message: "Invalid Action!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
            operateWithTwoNumbers {$0 / $1}
            }
        default: break
    }
        secondNumber = 0
        arrayOfOrangeButtons.forEach { $0.backgroundColor = .orange }
        arrayOfOrangeButtons.forEach { $0.tintColor = .white }
}
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        let arrayOfOrangeButtons: [UIButton] = [divideButton, multiplyButton, subtractionButton, equalButton, additionButton]
        labelForResult.text = "0"
        firstInput = true
        firstNumber = 0
        secondNumber = 0
        arrayOfOrangeButtons.forEach { $0.backgroundColor = .orange }
        arrayOfOrangeButtons.forEach { $0.tintColor = .white }
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: Any) {
        if input != 0 {
            input = -input
        } else {
            let alert = UIAlertController(title: "Alert", message: "Invalid Action!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func percentButtonPressed(_ sender: UIButton) {
        if firstNumber == 0 {
            input = input / 100
        } else {
            secondNumber = firstNumber * input / 100
        }
    }
    
    func buttonAppearance (buttons: [UIButton]) {
        buttons.forEach { $0.layer.cornerRadius =
        firstStackView.frame.height / 2.1 }
        buttons.forEach { $0.backgroundColor = .darkGray }
        buttons.forEach { $0.tintColor = .white }
        buttons.forEach { $0.titleLabel?.font = UIFont(name: "Helvetica Light", size: 35)}
    }
   
    func stackViewAppearance (stackView: [UIStackView]) {
        stackView.forEach { $0.spacing = 10 }
        stackView.forEach { $0.distribution = .fillEqually }
    }
    
    func operateWithTwoNumbers(operation: (Double, Double) -> Double) {
        input = operation(firstNumber, secondNumber)
        firstInput = true
    }
}

extension UIButton {
    func shortChangeBackground(with color: UIColor) {
        let originalColor = self.backgroundColor
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = color
        }
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = originalColor
        }
    }
}
