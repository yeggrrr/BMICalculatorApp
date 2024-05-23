//
//  NicknameViewController.swift
//  BMICalculatorApp
//
//  Created by YJ on 5/22/24.
//

import UIKit

class NicknameViewController: UIViewController {
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        guard let parentVC = self.presentingViewController as? BMICalculatorViewController else { return }
        parentVC.initializeDataList(removeAll: false)
        parentVC.configureUI()
    }
    
    func configureUI() {
        descriptionLabel.text = "닉네임 변경하기"
        descriptionLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        nicknameTextField.placeholder = "닉네임을 입력하세요"
        
        saveButton.setUI("저장하기", .white, background: .systemPurple)
        saveButton.layer.cornerRadius = 15
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        
        resetButton.setUI("리셋하기", .white, background: .systemOrange)
        resetButton.layer.cornerRadius = 15
        resetButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let openButton = UIAlertAction(title: "확인", style: .default)
        alert.addAction(openButton)
        present(alert, animated: true)
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        guard let text = nicknameTextField.text else { return }
        UserDefaults.standard.setValue(text, forKey: "nickname")
        
        showAlert(title: "닉네임이 '\(text)'으로 변경되었습니다.", message: "")
    }
    
    @IBAction func resetButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "nickname")
        
        showAlert(title: "닉네임 리셋 성공!", message: "")
    }
}
