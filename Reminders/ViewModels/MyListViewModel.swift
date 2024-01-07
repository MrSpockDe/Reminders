//
//  MyListViewModel.swift
//  Reminders
//
//  Created by Albert on 31.10.22.
//

import Foundation
import CoreData
import SwiftUI

class MyObservalbleList: ObservableObject, Identifiable {
    @Published var theList: MyList
    var id: ObjectIdentifier

    init(theList: MyList) {
        self.theList = theList
        self.id = theList.id
    }
}

class MyListViewModel: ObservableObject, Identifiable {
    @Published var myList: MyObservalbleList
    @Published var myListItemVM: MyListItemsViewModel
    @Published var vmItems: [MyListItemViewModel] = []

    var onItemAdded: ItemAdded = nil
    var onItemDelete: ItemDelete = nil

    var context: NSManagedObjectContext

    init(myList: MyList, context: NSManagedObjectContext, onItemAdded: ItemAdded, onItemDelete: ItemDelete) {
        self.myList = MyObservalbleList(theList: myList)
        self.context = context
        self.myListItemVM = MyListItemsViewModel(
            items: [],
            onItemAdded: onItemAdded,
            onItemDelete: onItemDelete)
        setItems()
    }

    var id: NSManagedObjectID {
        myList.theList.objectID
    }

    var name: String {
        myList.theList.name ?? ""
    }

    var color: Color {
        Color(myList.theList.color ?? .clear)
    }

    var itemsCount: Int {
        vmItems.count
    }

    func setItems() {
        guard let newItems = myList.theList.items,
              let myItems = (newItems.allObjects as? [MyListItem])
        else {
            self.vmItems = []
            return
        }
        self.vmItems = myItems.filter { $0.isCompleted == false}.map(MyListItemViewModel.init)
        myListItemVM.updateItems(items: self.vmItems)
    }

    func onItemAddedFunc(title: String, dueDate: Date?) {
        self.saveTo(title: title, dueDate: dueDate)
    }

    func saveTo(title: String, dueDate: Date?) {
        let myListItem = MyListItem(context: context)
        myListItem.title = title
        myListItem.dueDate = dueDate
        myListItem.myList = MyList.byId(id: myList.theList.objectID)

        do {
            objectWillChange.send()
            try myListItem.save()
        } catch {
            print("could not save item: \(title). \(error.localizedDescription)")
        }
    }
}
