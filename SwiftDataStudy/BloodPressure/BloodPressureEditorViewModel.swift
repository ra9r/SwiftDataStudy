//
//  BloodPressureEditorViewModel.swift
//  SwiftDataStudy
//
//  Created by Rodney Aiglstorfer on 11/7/23.
//

import Foundation
import SwiftData

extension BloodPressureEditorView {
    
    @Observable
    class ViewModel {
        var record: MeasuredRecord? = nil
        var measuredOn: Date = Date.now
        var systolic: String = "0"
        var diastolic: String = "0"
        var heartRate: String = "0"
        
        var isEditMode: Bool = false
        
        init(_ record: MeasuredRecord? = nil) {
            self.record = record
            if let record {
                if case BioMeasurement.bloodPressure(let systolic, let diastolic, let heartRate) = record.measurement {
                    self.systolic = "\(systolic)"
                    self.diastolic = "\(diastolic)"
                    self.heartRate = "\(heartRate)"
                } else {
                    fatalError("Unsupported measurement expecting Measurement.bloodpressure")
                }
                self.measuredOn = record.measuredOn
                self.isEditMode = true
            }
        }
        
        func saveOrUpdate(_ ctx: ModelContext, completion: @escaping (Error?) -> Void) {
            do {
                let measurement = BioMeasurement.bloodPressure(
                    systolic: Int(self.systolic) ?? 0,
                    diastolic: Int(self.diastolic) ?? 0,
                    heartRate: Int(self.heartRate) ?? 0)
                if let record = self.record {
                    record.measurement = measurement
                    record.measuredOn = self.measuredOn
                } else {
                    let record = MeasuredRecord(id: UUID(), measuredOn: Date.now, measurement: measurement)
                    ctx.insert(record)
                    try ctx.save()
                }
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
}
