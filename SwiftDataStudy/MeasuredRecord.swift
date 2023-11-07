import SwiftUI
import SwiftData
import Foundation

@Model
class MeasuredRecord {
    var id: UUID = UUID()
    var measuredOn: Date = Date.now
    var measurement: Measurement = Measurement.weight(amount: 0, units: "--")
    
    init(id: UUID, measuredOn: Date, measurement: Measurement) {
        self.id = id
        self.measuredOn = measuredOn
        self.measurement = measurement
    }
}

enum Measurement : Codable, Equatable {
    case weight(amount: Int, units: String)
    case bloodPressure(systolic: Int, diastolic: Int, heartRate: Int)
    
    func title() -> String {
        switch self {
        case .bloodPressure:
            "Blood Pressure"
        case .weight: 
            "Weight"
        }
    }
}
