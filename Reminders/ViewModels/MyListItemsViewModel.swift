//
//  MyListItemsViewModel.swift
//  Reminders
//
//  Created by Albert on 17.12.23.
//

import Foundation

typealias ItemAdded = ((String, Date?) -> Void)?
typealias ItemDelete = ((MyListItemViewModel) -> Void)?
typealias ItemUpdate = ((MyListItemViewModel, String, Date?) -> Void)?

class MyListItemsViewModel: ObservableObject {
    @Published var items = [MyListItemViewModel]()
    @Published var onItemAdded: ItemAdded
    @Published var onItemDelete: ItemDelete

    init(items: [MyListItemViewModel],
         onItemAdded: ItemAdded,
         onItemDelete: ItemDelete) {
        self.items = items
        self.onItemAdded = onItemAdded
        self.onItemDelete = onItemDelete
    }

    func updateItems(items: [MyListItemViewModel]) {
        self.items = items
    }
}
