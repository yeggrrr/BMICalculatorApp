//
//  SaveDataTableViewCell.swift
//  BMICalculatorApp
//
//  Created by YJ on 5/22/24.
//

import UIKit

class SaveDataTableViewCell: UITableViewCell {
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var bmiLabel: UILabel!
    
    static let identifier = "SaveDataTableViewCell"
}
