//
//  ViewController.swift
//  BMICalculatorApp
//
//  Created by YJ on 5/21/24.
//

import UIKit

class BMICalculatorViewController: UIViewController {
    enum BMIType {
        case random
        case userInput
    }
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var bmiImageView: UIImageView!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var randomCalculateButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    @IBOutlet var secretButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        configureUI()
    }

    func configureUI() {
        // label
        titleLabel.setUI("BMI Calculator", fontSize: .boldSystemFont(ofSize: 25))
        subTitleLabel.setUI("당신의 BMI 지수를 \n알려드릴게요!", fontSize: .systemFont(ofSize: 17))
        heightLabel.setUI("키가 어떻게 되시나요?", fontSize: .systemFont(ofSize: 16))
        weightLabel.setUI("몸무게가 어떻게 되시나요?", fontSize: .systemFont(ofSize: 16))

        // textField
        heightTextField.setUI()
        weightTextField.setUI()
        
        // button
        secretButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        secretButton.tintColor = .darkGray
        
        randomCalculateButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomCalculateButton.setTitleColor(.red, for: .normal)
        
        randomCalculateButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomCalculateButton.setTitleColor(.systemBrown, for: .normal)
        randomCalculateButton.backgroundColor = .clear
        
        resultButton.setTitle("결과 확인", for: .normal)
        resultButton.setTitleColor(.white, for: .normal)
        resultButton.backgroundColor = .systemPurple
        
        resultButton.layer.cornerRadius = 15
        resultButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
    }
    
     func getBMI(type: BMIType) {
         var weight: Double
         var height: Double
         
         switch type {
         case .random:
             height = Double.random(in: 140...200)
             weight = Double.random(in: 40...110)
         case .userInput:
             guard let heightText = heightTextField.text, let userHeight = Double(heightText) else {
                 showAlert(title: "입력값 오류", message: "키를 숫자로 입력해주세요.")
                 return
             }
             height = userHeight
             guard let weightText = weightTextField.text, let userWeight = Double(weightText) else {
                 showAlert(title: "입력값 오류", message: "몸무게를 숫자로 입력해주세요.")
                 return
             }
             weight = userWeight
         }
         
         let bmi = weight / sqrt(height * 100)
         var body = ""
         
         switch bmi {
         case 0..<18.6:
             body = "저체중"
         case 18.6..<24:
             body = "정상"
         case 24..<26:
             body = "과체중"
         case 26..<31:
             body = "비만"
         default:
             body = "고도비만"
         }
         
         let roundedHeight = String(format: "%.1f", height)
         let roundedWeight = String(format: "%.1f", weight)
         showAlert(title: "BMI 지수는?", message: "당신은 키: \(roundedHeight)cm, 몸무게: \(roundedWeight)kg의 bmi 지수는 '\(body)'입니다!")
         heightTextField.text = ""
         weightTextField.text = ""
     }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let openButton = UIAlertAction(title: "확인", style: .default)
        alert.addAction(openButton)
        present(alert, animated: true)
    }
    
    @IBAction func resultButtonClicked(_ sender: UIButton) {
        getBMI(type: .userInput)
    }
    
    @IBAction func randomButtonClicked(_ sender: UIButton) {
        getBMI(type: .random)
    }
    
    @IBAction func secretButtonClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        let isSecret = sender.isSelected
        weightTextField.isSecureTextEntry = isSecret
        
        if isSecret {
            secretButton.tintColor = .systemRed
        } else {
            secretButton.tintColor = .darkGray
        }
    }
    
    @IBAction func viewTouched(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension UILabel {
    func setUI(_ title: String, fontSize: UIFont) {
        text = title
        textColor = .black
        font = fontSize
        numberOfLines = 0
    }
}

extension UITextField {
    func setUI() {
        placeholder = " 숫자만 입력해주세요."
        layer.borderWidth = 1
        layer.cornerRadius = 20
        tintColor = .black
        keyboardType = .numberPad
        keyboardAppearance = .light
    }
}

extension BMICalculatorViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        return text.count < 3
    }
}
