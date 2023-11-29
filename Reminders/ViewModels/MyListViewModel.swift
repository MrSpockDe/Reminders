//
//  MyListViewModel.swift
//  Reminders
//
//  Created by Albert on 31.10.22.
//

import Foundation
import CoreData
import SwiftUI

struct MyListViewModel: Identifiable {
    private let myList: MyList

    init(myList: MyList) {
        self.myList = myList
    }

    var id: NSManagedObjectID {
        myList.objectID
    }

    var name: String {
        myList.name ?? ""
    }

    var color: Color {
        Color(myList.color ?? .clear)
    }

    var items: [MyListItemViewModel] {
        guard let items = myList.items,
              let myItems = (items.allObjects as? [MyListItem])
        else {
            return []
        }

        return myItems.filter { $0.isCompleted == false}.map(MyListItemViewModel.init)
    }

    var itemsCount: Int {
        items.count
    }
}
