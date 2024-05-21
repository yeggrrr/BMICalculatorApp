//
//  ViewController.swift
//  BMICalculatorApp
//
//  Created by YJ on 5/21/24.
//

import UIKit

class BMICalculatorViewController: UIViewController {
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
        
        configureUI()
        
    }

    func configureUI() {
        // label
        titleLabel.setUI("BMI Calculator", fontSize: .boldSystemFont(ofSize: 20))
        subTitleLabel.setUI("당신의 BMI 지수를 \n알려드릴게요!", fontSize: .systemFont(ofSize: 16))
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
    
    @IBAction func resultButtonClicked(_ sender: UIButton) {
        guard let height = heightTextField.text else { return }
        guard let weight = weightTextField.text else { return }
        
        guard let userHeight = Double(height) else { return }
        guard let userWeight = Double(weight) else { return }

        let bmi = (userWeight / (userHeight * userHeight)) * 10000
        
        var body = ""
        
        if bmi < 18.8 {
            body = "저체중"
        } else if bmi > 18.5 && bmi < 22.9 {
            body = "정상"
        } else if bmi > 23.0 && bmi < 24.9 {
            body = "과체중"
        } else {
            body = "비만"
        }
        
        let alert = UIAlertController(title: "BMI 지수는?", message: "당신은 '\(body)'입니다!", preferredStyle: .alert)
        let openButton = UIAlertAction(title: "확인", style: .default)
        alert.addAction(openButton)
        present(alert, animated: true)
    }
    
    @IBAction func secretButtonClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected {
            weightTextField.isSecureTextEntry = true
            secretButton.tintColor = .systemRed
        } else {
            weightTextField.isSecureTextEntry = false
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
