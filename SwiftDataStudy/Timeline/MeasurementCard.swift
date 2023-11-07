//
//  MeasurementCard.swift
//  SwiftDataStudy
//
//  Created by Rodney Aiglstorfer on 11/7/23.
//

import SwiftUI

struct MeasurementCard: View {
    @State var record: MeasuredRecord
    
    @Environment(\.modelContext) var ctx
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(record.measurement.title())
                Spacer()
                Text(record.measuredOn.formatted())
                    .font(.caption)
            }
            .font(.headline)
            Group {
                switch record.measurement {
                    case .weight(let amount, let units):
                        Text("\(amount) \(units)")
                    case .bloodPressure(let systolic, let diastolic, let heartRate):
                        Text("\(systolic)/\(diastolic) \(heartRate)bps")
                }
            }
            .font(.title)
        }
        .swipeActions {
            Button() {
                ctx.delete(record)
            } label: {
                Image(systemName: "trash.fill")
                
            }
            .tint(.red)
            .foregroundColor(.white)
        }
    }
}
