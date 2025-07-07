//
//  PFCCheckerSwiftApp.swift
//  PFCCheckerSwift
//
//  Created by なたてここ on 2025/07/05.
//

import SwiftUI

@main
struct PFCCheckerSwiftApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
