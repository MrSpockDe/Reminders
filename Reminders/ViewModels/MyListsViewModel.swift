//
//  MyListsViewModel.swift
//  Reminders
//
//  Created by Albert on 31.10.22.
//

import Foundation
import SwiftUI
import CoreData

extension MyListsView {
    class Viewmodel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {

        @Published var myLists = [MyListViewModel]()
        @Published var dummyItems = [MyListItem]()

        private let fetchedResultsController: NSFetchedResultsController<MyList>
        private let itemFetchedResultsController: NSFetchedResultsController<MyListItem>
        private var context: NSManagedObjectContext

        init(context: NSManagedObjectContext) {
            self.context = context
            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: MyList.all,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil)
            let itemFetchRequest = MyListItem.fetchRequest()
            itemFetchRequest.sortDescriptors = []
            itemFetchedResultsController = NSFetchedResultsController(
                fetchRequest: itemFetchRequest,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil)
            super.init()
            fetchedResultsController.delegate = self
            itemFetchedResultsController.delegate = self
            fetchAll()
            fetchItems()
        }

        func delete(_ myList: MyListViewModel) {
            let myList: MyList? = MyList.byId(id: myList.id)
            if let myList = myList {
                try? myList.delete()
            }
        }

        func deleteItem(_ item: MyListItemViewModel) {
            let myListItem: MyListItem? = MyListItem.byId(id: item.listItemId)
            if let myListItem = myListItem {
                try? myListItem.delete()
            }
        }

        func saveTo(myList: MyList, title: String, dueDate: Date?) {
            let myListItem = MyListItem(context: context)
            myListItem.title = title
            myListItem.dueDate = dueDate
            myListItem.myList = myList

            do {
                objectWillChange.send()
                try myListItem.save()
            } catch {
                print("could not save item: \(title). \(error.localizedDescription)")
            }
        }

        private func fetchAll() {
            do {
                try fetchedResultsController.performFetch()
                guard let myLists = fetchedResultsController.fetchedObjects else {
                    return
                }
                let mysortedList = myLists.sorted(by: { $0.name! < $1.name! })
                self.myLists = []
                for myList in mysortedList {
                    self.myLists.append(MyListViewModel.init(
                        myList: myList,
                        context: context,
                        onItemAdded: { title, dueDate in
                            self.saveTo(myList: myList, title: title, dueDate: dueDate)
                        },
                        onItemDelete: { myItem in
                            self.deleteItem(myItem)
                        }))
                }
            } catch {
                fatalError("Could not perform fetch: \(error.localizedDescription)")
            }
        }

        private func fetchItems() {
            do {
                try itemFetchedResultsController.performFetch()
                guard let items = itemFetchedResultsController.fetchedObjects else {
                    return
                }
                self.dummyItems = items
            } catch {
                fatalError("Could not perform fetch: \(error.localizedDescription)")
            }
        }

        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            if let myLists = controller.fetchedObjects as? [MyList] {
                let mysortedList = myLists.sorted(by: { $0.name! < $1.name! })
                self.myLists = []
                for myList in mysortedList {
                    self.myLists.append(MyListViewModel.init(
                        myList: myList,
                        context: context,
                        onItemAdded: { title, dueDate in
                            self.saveTo(myList: myList, title: title, dueDate: dueDate)
                        },
                        onItemDelete: { myItem in
                            self.deleteItem(myItem)
                        }))
                }
            }

            if controller.fetchedObjects is [MyListItem] {
                fetchAll()
            }
        }
    }
}
