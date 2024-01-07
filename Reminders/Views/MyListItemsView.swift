//
//  MyListItemsView.swift
//  Reminders
//
//  Created by Albert on 27.11.22.
//

import SwiftUI

struct MyListItemsView: View {
    @ObservedObject var myListItemVM: MyListItemsViewModel

    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(myListItemVM.items) { item in
                    ListItemCellView(
                        item: item,
                        onListItemDelete: { item in
                            myListItemVM.onItemDelete?(item)
                        },
                        onUpdate: { title, dueDate in
                            item.updateItem(title: title, dueDate: dueDate)
                        })
                }
                AddNewListItemView { title, dueDate in
                    if let onItemAdded = myListItemVM.onItemAdded {
                        onItemAdded(title, dueDate)

                    }
                }
            }
        }
    }
}

struct MyListItemsView_Previews: PreviewProvider {
    static var previews: some View {
        MyListItemsView(myListItemVM: MyListItemsViewModel(items: [], onItemAdded: nil, onItemDelete: nil))
    }
}
