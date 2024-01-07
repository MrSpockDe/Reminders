//
//  MyListsView.swift
//  Reminders
//
//  Created by Albert on 19.11.22.
//

import SwiftUI

struct MyListsView: View {

    @StateObject var viewModel = Viewmodel(context: CoreDataManager.shared.persistentContainer.viewContext)

    /*init(vm: MyListsViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }*/

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            List {
                Text("\(viewModel.myLists.count)")
                ForEach(viewModel.myLists, id: \.id) { myList in
                    NavigationLink {
                        MyListItemsHeaderView(name: myList.name, count: myList.itemsCount, color: myList.color)
                        MyListItemsView(myListItemVM: myList.myListItemVM) /*
                            items: myList.vmItems,
                            onItemAdded: { title, dueDate in
                                viewModel.saveTo(list: myList, title: title, dueDate: dueDate)
                            },
                            onItemDelete: { item in
                                viewModel.deleteItem(item)
                            })*/
                    } label: {
                        HStack {
                            Image(systemName: Constants.Icons.line3HorizontalCircleFill)
                                .font(.title)
                                .foregroundColor(myList.color)
                            Text(myList.name)
                        }}
                    .contextMenu {
                        Button(action: {
                            viewModel.delete(myList)
                        }, label: {
                            Label("Delete", systemImage: "trash")
                        })
                    }
                }
            }
        }
    }
}

struct MyListsView_Previews: PreviewProvider {
    static var previews: some View {
        MyListsView()
    }
}
