//
//  RemindersApp.swift
//  Reminders
//
//  Created by Albert on 31.10.22.
//

import SwiftUI

@main
struct RemindersApp: App {
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
        }
    }
}
