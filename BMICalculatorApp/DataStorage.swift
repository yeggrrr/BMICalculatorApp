//
//  DataStorage.swift
//  BMICalculatorApp
//
//  Created by YJ on 5/22/24.
//

import Foundation

class DataStorage {
    static let shared = DataStorage()
    
    struct BMIData: Codable {
        var date: String
        var height: String
        var weight: String
        var bmi: String
    }
    
    var dataList: [BMIData] = []
}


