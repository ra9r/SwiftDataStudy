//
//  Measurement.swift
//  SwiftDataStudy
//
//  Created by Rodney Aiglstorfer on 11/7/23.
//

import Foundation

enum BioMeasurement : Codable {
         
    case weight(amount: Int = 0, units: String = "lbs")
    case bloodPressure(systolic: Int = 0, diastolic: Int = 0, heartRate: Int = 0)
    
    func title() -> String {
        switch self {
            case .bloodPressure:
                "Blood Pressure"
            case .weight:
                "Weight"
        }
    }
}
