//
//  AddNewListViewModel.swift
//  Reminders
//
//  Created by Albert on 31.10.22.
//

import Foundation
import CoreData
import SwiftUI

extension AddNewListView {
    class Viewmodel: ObservableObject {
        @Published var name: String = ""
        @Published var color: Color = .blue

        var context: NSManagedObjectContext

        init(context: NSManagedObjectContext) {
            self.context = context
        }

        func save() {
            let myList = MyList(context: context)
            myList.name = name
            myList.color = NSColor(color)
            do {
                try myList.save()
            } catch {
                fatalError("Could not save myList: \(error.localizedDescription)")
            }
        }
    }
}
