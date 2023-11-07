import SwiftUI
import SwiftData

struct MeasurementListView: View {
    @Query var records: [MeasuredRecord]
    
    @Environment(\.modelContext) var ctx
    
    var body: some View {
        NavigationStack {
            List(records, id: \.id) { record in
                NavigationLink {
                    MeasurementEditorView(record: record)
                } label: {
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            Text(record.measurement.title())
                            Spacer()
                            Text(record.measuredOn.formatted())
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
                }
            }
            
            
            .navigationTitle("Record List")
            .toolbar(content: {
                Button("Add Blood Pressure") {
                    let record = MeasuredRecord(
                        id: UUID(),
                        measuredOn: .now,
                        measurement: .bloodPressure(systolic: 120, diastolic: 70, heartRate: 72))
                    
                    ctx.insert(record)
                    do {
                        try ctx.save()
                    } catch {
                        print(error)
                    }
                }
                Button("Add Weight") {
                    let record = MeasuredRecord(
                        id: UUID(),
                        measuredOn: .now,
                        measurement: .weight(amount: 200, units: "lbs"))
                    
                    ctx.insert(record)
                    do {
                        try ctx.save()
                    } catch {
                        print(error)
                    }
                }
            })
        }
    }
}




