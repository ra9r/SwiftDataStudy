import SwiftUI


struct MeasurementEditorView: View {
    @Environment(\.dismiss) var dismiss
    @State var record: MeasuredRecord
    
    @ViewBuilder
    var body: some View {
        VStack {
            switch record.measurement {
            case .weight(let amount, let units):
                Text("Weight: \(amount) \(units)")
            case .bloodPressure(let systolic, let diastolic, let heartRate):
                Text("Blood Pressure: \(systolic)/\(diastolic) \(heartRate) bps")
            }
            Button("Update Data") {
                switch record.measurement {
                case .weight(let amount, let units):
                    record.measurement = .weight(amount: amount + 1, units: units)
                case .bloodPressure(let systolic, let diastolic, let heartRate):
                    record.measurement = .bloodPressure(systolic: systolic + 1, diastolic: diastolic - 1, heartRate: heartRate - 1)
                }
            }
            Button("Done!") {
                dismiss()
            }
        }
    }
}
