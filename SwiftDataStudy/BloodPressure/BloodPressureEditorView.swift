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
        List {
            HStack {
                Text("Systolic").font(.headline)
                Spacer()
                TextField("Systolic", text:$vm.systolic, prompt: Text("e.g. 120"))
                    .padding(.all)
                    .keyboardType(.numberPad)
            }
            HStack {
                Text("Diastolic").font(.headline)
                Spacer()
                TextField("Diastolic", text:$vm.diastolic, prompt: Text("e.g. 80"))
                    .padding(.all)
                    .keyboardType(.numberPad)
            }
            HStack {
                Text("Heart Rate").font(.headline)
                Spacer()
                TextField("Heart Rate", text:$vm.heartRate, prompt: Text("65"))
                    .padding(.all)
                    .keyboardType(.numberPad)
            }
            DatePicker("MeasuredOn", selection: $vm.measuredOn)
            
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
        .navigationTitle((vm.isEditMode) ? "BloodPressure Editor" : "Add BloodPressure")
        
    }
}

