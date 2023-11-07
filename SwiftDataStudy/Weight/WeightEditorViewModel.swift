//
//  WeightEditorViewModel.swift
//  SwiftDataStudy
//
//  Created by Rodney Aiglstorfer on 11/7/23.
//

import Foundation
import SwiftData

extension WeightEditorView {
    
    @Observable
    class ViewModel {
        var record: MeasuredRecord? = nil
        var measuredOn: Date = Date.now
        var amount: Int = 0
        var units: String = "lbs"
        
        var isEditMode: Bool = false
        
        init(_ record: MeasuredRecord? = nil) {
            self.record = record
            if let record {
                if case BioMeasurement.weight(let amount, let units) = record.measurement {
                    self.amount = amount
                    self.units = units
                } else {
                    fatalError("Unsupported measurement expecting Measurement.weight")
                }
                self.measuredOn = record.measuredOn
                self.isEditMode = true
            }
        }
        
        func saveOrUpdate(_ ctx: ModelContext, completion: @escaping (Error?) -> Void) {
            do {
                let measurement = BioMeasurement.weight(amount: self.amount, units: self.units)
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
