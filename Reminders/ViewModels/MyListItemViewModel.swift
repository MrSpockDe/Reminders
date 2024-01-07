//
//  MyListItemViewModel.swift
//  Reminders
//
//  Created by Albert on 27.11.22.
//

import Foundation
import CoreData

class MyListItemViewModel: ObservableObject, Identifiable {
    @Published var myListItem: MyListItem

    var id = UUID()

    init(myListItem: MyListItem) {
        self.myListItem = myListItem
    }

    var listItemId: NSManagedObjectID {
        myListItem.objectID
    }

    var title: String {
        myListItem.title ?? ""
    }

    var dueDate: DueDate? {
        if let date = myListItem.dueDate {
            return DueDate.from(value: date)
        } else {
            return nil
        }
    }

    var isComleted: Bool {
        myListItem.isCompleted
    }

    func updateItem(title: String, dueDate: Date?) {
        myListItem.title = title
        myListItem.dueDate = dueDate
        do {
            try myListItem.save()
        } catch {
            print("Could not save \(myListItem.title ?? "unknown title")")
        }
    }
}
