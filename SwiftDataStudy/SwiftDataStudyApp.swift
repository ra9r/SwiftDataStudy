//
//  SwiftDataStudyApp.swift
//  SwiftDataStudy
//
//  Created by Rodney Aiglstorfer on 10/21/23.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataStudyApp: App {
    var sharedModelContainer: ModelContainer
    
    init() {
        let schema = Schema([
            MeasuredRecord.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            sharedModelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }

    var body: some Scene {
        WindowGroup {
            MeasurementListView()
        }
//        .modelContainer(for: [MeasuredRecord.self])
        .modelContainer(sharedModelContainer)
    }
}
