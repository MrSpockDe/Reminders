//
//  MyListsViewModel.swift
//  Reminders
//
//  Created by Albert on 31.10.22.
//

import Foundation
import SwiftUI
import CoreData

class MyListsViewModel: NSObject, ObservableObject {

    @Published var myLists = [MyListViewModel]()

    private let fetchedResultsController: NSFetchedResultsController<MyList>
    private var context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: MyList.all,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        super.init()
        fetchedResultsController.delegate = self

        print("MLV init called -> fetchAll")
        fetchAll()
    }

    func delete(_ myList: MyListViewModel) {
        let myList: MyList? = MyList.byId(id: myList.id)
        if let myList = myList {
            try? myList.delete()
        }
    }

    private func fetchAll() {
        do {
            try fetchedResultsController.performFetch()
            guard let myLists = fetchedResultsController.fetchedObjects else {
                return
            }
            self.myLists = myLists.map(MyListViewModel.init)
        } catch {
            fatalError("Could not perform fetch: \(error.localizedDescription)")
        }
    }
}

extension MyListsViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("didChange")
        guard let myLists = controller.fetchedObjects as? [MyList] else {
            return
        }

        self.myLists = myLists.map(MyListViewModel.init)
    }
}
