//
//  ListItemCellView.swift
//  Reminders
//
//  Created by Albert on 02.12.23.
//

import SwiftUI

struct ListItemCellView: View {

    @State private var active = false
    @State private var showPopover = false
    @ObservedObject var item: MyListItemViewModel

    var onListItemDelete: (MyListItemViewModel) -> Void = { _ in }
    var onUpdate: (String, Date?) -> Void = { _, _ in }

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Image(systemName: Constants.Icons.circle)
                .font(.system(size: 14))
                .opacity(0.2)
            VStack(alignment: .leading) {
                Text(item.title)
                if let dueDate = item.dueDate {
                    Text(dueDate.title)
                        .opacity(0.4)
                        .foregroundColor(dueDate.isPastDue ? .red : .primary)
                }
            }
            Spacer()
            if active {
                Image(systemName: Constants.Icons.multiplyCircle)
                    .foregroundColor(.red)
                    .onTapGesture {
                        onListItemDelete(item)
                    }
                Image(systemName: Constants.Icons.exclamationMarkCircle)
                    .foregroundColor(.purple)
                    .onTapGesture {
                        showPopover = true
                    }
            }
        }
        .contentShape(Rectangle())
        .onHover { value in
            active = value
        }
        .sheet(isPresented: $showPopover) {
            AddNewListItemView(title: item.title, dueDate: item.dueDate, onSave: onUpdate, mode: .edit)
        }
    }

}

#Preview {
    ListItemCellView(item: MyListItemViewModel(myListItem: MyListItem()))
}
