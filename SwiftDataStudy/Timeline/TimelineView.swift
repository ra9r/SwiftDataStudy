import SwiftUI
import SwiftData

struct TimelineView: View {
    @Environment(\.modelContext) var ctx
    @Query(sort: [SortDescriptor(\MeasuredRecord.measuredOn, order: .reverse)]) var records: [MeasuredRecord]
    @State var selectedMenuOption: MenuOption? = nil
    
    
    var body: some View {
        NavigationStack {
            List(records, id: \.id) { record in
                NavigationLink {
                    editor(record)
                } label: {
                    MeasurementCard(record: record)
                }
            }
            .navigationTitle("Record List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: { menu })
            }
            .listStyle(.plain)
            .sheet(isPresented: Binding(value: $selectedMenuOption)) {
                switch selectedMenuOption {
                    case .weight:
                        WeightEditorView()
                    case .bloodPressure:
                        BloodPressureEditorView()
                    case .none:
                        fatalError() // should not be possible
                }
            }
        }
    }
}

// MARK: -
extension TimelineView {
    enum MenuOption : String, CaseIterable {
        case weight = "Body Weight"
        case bloodPressure = "Blood Pressure"
    }
    
    @ViewBuilder
    func editor(_ record: MeasuredRecord) -> some View {
        switch record.measurement {
            case .weight:
                WeightEditorView(record)
            case .bloodPressure:
                BloodPressureEditorView(record)
        }
    }
    var menu: some View {
        Menu {
            ForEach(MenuOption.allCases, id: \.self) { option in
                Button(option.rawValue) {
                    self.selectedMenuOption = option
                }
            }
        } label: {
            Image(systemName: "plus")
        }
    }
}

