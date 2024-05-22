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
    @IBOutlet var changeNicknameButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    @IBOutlet var secretButton: UIButton!
    @IBOutlet var searchListButton: UIButton!
    @IBOutlet var deleteListButton: UIButton!
    
    let defautls = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        initializeDataList(removeAll: false)
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializeDataList(removeAll: false)
        configureUI()
    }
    
    func initializeDataList(removeAll: Bool) {
        // BMI 데이터 초기화
        if removeAll {
            defautls.removeObject(forKey: "newData")
        }
        let decodedData = fetchDecodedBMIData()
        DataStorage.shared.dataList = decodedData
        
        // 닉네임 초기화
        if let savedNickname = defautls.string(forKey: "nickname") {
            DataStorage.shared.nickname = "'\(savedNickname)'님"
        }
        else {
            DataStorage.shared.nickname = "당신"
        }
    }
    
    func configureUI() {
        // label
        titleLabel.setUI("BMI Calculator", fontSize: .boldSystemFont(ofSize: 25))
        subTitleLabel.setUI("\(DataStorage.shared.nickname)의 BMI 지수를 \n알려드릴게요!", fontSize: .systemFont(ofSize: 17))
        heightLabel.setUI("키가 어떻게 되시나요?", fontSize: .systemFont(ofSize: 16))
        weightLabel.setUI("몸무게가 어떻게 되시나요?", fontSize: .systemFont(ofSize: 16))
        
        // textField
        heightTextField.setUI()
        weightTextField.setUI()
        
        // button
        secretButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        secretButton.tintColor = .darkGray

        randomCalculateButton.setUI("랜덤으로 BMI 계산하기", .systemOrange, background: .clear)
        
        changeNicknameButton.setUI("닉네임 변경하기", .systemOrange, background: .clear)
        
        resultButton.setUI("결과 확인", .white, background: .systemPurple)
        resultButton.layer.cornerRadius = 15
        resultButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        searchListButton.setUI("이전 결과 리스트", .darkGray, background: .clear)
        searchListButton.layer.borderWidth = 1
        searchListButton.layer.cornerRadius = 10
        searchListButton.titleLabel?.font = .systemFont(ofSize: 15)
        
        deleteListButton.setUI("리스트 비우기", .systemRed, background: .clear)
        deleteListButton.layer.borderWidth = 1
        deleteListButton.layer.cornerRadius = 10
        deleteListButton.titleLabel?.font = .systemFont(ofSize: 15)
    }
    
    func getBMI(type: BMIType) {
        var weight: Double
        var height: Double
        
        switch type {
        case .random:
            height = Double.random(in: 80...200)
            weight = Double.random(in: 30...110)
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
        
        let bmi = weight / pow(height * 0.01, 2)
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
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDate = formatter.string(from: Date())
        
        let newData = DataStorage.BMIData(
            date: currentDate,
            height: roundedHeight,
            weight: roundedWeight,
            bmi: body)
        DataStorage.shared.dataList.append(newData)
        
        let encoder = JSONEncoder()
        let newDataList = DataStorage.shared.dataList
        
        do {
            let result = try encoder.encode(newDataList)
            defautls.setValue(result, forKey: "newData")
        }
        catch {
            print("encoding error: \(error)")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let openButton = UIAlertAction(title: "확인", style: .default)
        alert.addAction(openButton)
        present(alert, animated: true)
    }
    
    func fetchDecodedBMIData() -> [DataStorage.BMIData] {
        guard let bmiData = defautls.object(forKey: "newData") as? Data else { return [] }
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode([DataStorage.BMIData].self, from: bmiData)
            print("decoded data: \(result)")
            return result
        } catch {
            print("decode error: \(error)")
        }
        
        return []
    }
    
    @IBAction func resultButtonClicked(_ sender: UIButton) {
        getBMI(type: .userInput)
    }
    
    @IBAction func randomButtonClicked(_ sender: UIButton) {
        getBMI(type: .random)
    }
    
    @IBAction func changeNicknameButtonClicked(_ sender: UIButton) {
        guard let nicknameVC = self.storyboard?.instantiateViewController(identifier: "NicknameVC") as? NicknameViewController else { return }
        self.present(nicknameVC, animated: true)
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
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        initializeDataList(removeAll: true)
        showAlert(title: "결과 리스트 비우기 성공!", message: "")
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

extension UIButton {
    func setUI(_ title: String, _ color: UIColor, background: UIColor) {
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        backgroundColor = background
    }
}

extension BMICalculatorViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 3
    }
}
