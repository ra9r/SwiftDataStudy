//
//  BloodPressureEditorView.swift
//  SwiftDataStudy
//
//  Created by Rodney Aiglstorfer on 11/7/23.
//

import SwiftUI
import SwiftData

struct BloodPressureEditorView: View {
    @Environment(\.modelContext) var ctx
    @Environment(\.dismiss) var dismiss
    @State var vm: ViewModel
    
    init(_ record: MeasuredRecord? = nil) {
        self._vm = State(wrappedValue: ViewModel(record))
    }
    
    var body: some View {
        VStack {
            Text("Blood Pressure: \(vm.systolic)/\(vm.diastolic) \(vm.heartRate) bps")
                .font(.title)
            
            Button("Change Data") {
                if vm.isEditMode {
                    vm.systolic += 1
                    vm.diastolic -= 1
                    vm.heartRate -= 1
                } else {
                    vm.systolic = 120
                    vm.diastolic = 70
                    vm.heartRate = 65
                }
            }
            
            Button((vm.isEditMode) ? "Update Data" : "Add Data") {
                vm.saveOrUpdate(ctx) { error in
                    if let error {
                        print("Unabled to save bloodpressure: \(error.localizedDescription)")
                    }
                    dismiss()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle((vm.isEditMode) ? "Weight Editor" : "Add Weight")
        
    }
}

