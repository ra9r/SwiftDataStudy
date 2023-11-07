import SwiftUI
import SwiftData
import Foundation

@Model
class MeasuredRecord {
    var id: UUID = UUID()
    var measuredOn: Date = Date.now
    var measurement: BioMeasurement = BioMeasurement.weight(amount: 0, units: "--")
    
    init(id: UUID, measuredOn: Date, measurement: BioMeasurement) {
        self.id = id
        self.measuredOn = measuredOn
        self.measurement = measurement
    }
}
