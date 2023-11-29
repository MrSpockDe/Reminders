//
//  MyListsView.swift
//  Reminders
//
//  Created by Albert on 19.11.22.
//

import SwiftUI

struct MyListsView: View {

    @StateObject var viewModel: MyListsViewModel = MyListsViewModel(
        context: CoreDataManager.shared.persistentContainer.viewContext)

    /*init(vm: MyListsViewModel) {
        _vm = StateObject(wrappedValue: vm)
    }*/

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            List {
                Text("My Lists")
                ForEach(viewModel.myLists) { myList in
                    NavigationLink {
                        MyListItemsHeaderView(name: myList.name, count: 8, color: myList.color)
                        MyListItemsView()
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
