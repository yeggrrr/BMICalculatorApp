//
//  SaveDataViewController.swift
//  BMICalculatorApp
//
//  Created by YJ on 5/22/24.
//

import UIKit

class SaveDataViewController: UIViewController {
    @IBOutlet var saveDataTableView: UITableView!
    
    var dataList = DataStorage.shared.dataList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveDataTableView.dataSource = self
        saveDataTableView.delegate = self
    }
}

extension SaveDataViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SaveDataTableViewCell.identifier, for: indexPath) as? SaveDataTableViewCell else { return UITableViewCell() }
        
        let dateData = DataStorage.shared.dataList[indexPath.row].date
        let heightData = DataStorage.shared.dataList[indexPath.row].height
        let weightData = DataStorage.shared.dataList[indexPath.row].weight
        let bmiData = DataStorage.shared.dataList[indexPath.row].bmi
        
        cell.dateLabel.text = "\(dateData)"
        cell.dateLabel.textColor = .lightGray
        cell.dateLabel.font = .boldSystemFont(ofSize: 15)
        
        cell.heightLabel.text = "\(heightData)cm"
        cell.heightLabel.textColor = .darkGray
        cell.heightLabel.font = .boldSystemFont(ofSize: 17)
        
        cell.weightLabel.text = "\(weightData)kg"
        cell.weightLabel.textColor = .darkGray
        cell.weightLabel.font = .boldSystemFont(ofSize: 17)
        
        cell.bmiLabel.text = "\(bmiData)"
        cell.bmiLabel.textColor = .systemRed
        cell.bmiLabel.font = .boldSystemFont(ofSize: 17)
    
        return cell
    }
}
