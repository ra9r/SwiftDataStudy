//
//  WeightEditorView.swift
//  SwiftDataStudy
//
//  Created by Rodney Aiglstorfer on 11/7/23.
//

import SwiftUI
import SwiftData

struct WeightEditorView: View {
    @Environment(\.modelContext) var ctx
    @Environment(\.dismiss) var dismiss
    @State var vm: ViewModel
    
    
    init(_ record: MeasuredRecord? = nil) {
        self._vm = State(wrappedValue: ViewModel(record))
    }
    
    var body: some View {
        VStack(spacing:10) {
            Text("Weight: \(vm.amount) \(vm.units)")
                .font(.title)
            
            Button("Change Data") {
                if vm.isEditMode {
                    vm.amount += 1
                } else {
                    vm.amount = 180
                }
            }
            
            Button((vm.isEditMode) ? "Update" : "Save") {
                vm.saveOrUpdate(ctx) { error in
                    if let error {
                        print("Unabled to save weight: \(error.localizedDescription)")
                    }
                    dismiss()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle((vm.isEditMode) ? "Weight Editor" : "Add Weight")
        
    }
}


