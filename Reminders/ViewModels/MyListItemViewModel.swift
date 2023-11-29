//
//  MyListItemViewModel.swift
//  Reminders
//
//  Created by Albert on 27.11.22.
//

import Foundation
import CoreData

struct MyListItemViewModel: Identifiable {
    private let myListItem: MyListItem

    let id = UUID()

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
}
