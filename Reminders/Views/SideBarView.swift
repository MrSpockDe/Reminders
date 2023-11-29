//
//  SideBarView.swift
//  Reminders
//
//  Created by Albert on 31.10.22.
//

import SwiftUI

struct SideBarView: View {
    @State private var isPresented: Bool = false
    @Environment(\.managedObjectContext) var moc: NSManagedObjectContext

    var body: some View {
        VStack(alignment: .leading) {
            Text("All items count: 5")
            MyListsView()

            Spacer()
            Button {
                isPresented = true
            } label: {
                HStack {
                    Image(systemName: Constants.Icons.plusCircle)
                    Text("Add List")
                }
            }
            .buttonStyle(.plain)
            .padding()
        }
        .padding(.leading, 5)
        .sheet(isPresented: $isPresented) {
            AddNewListView()
        }
    }
}

struct SideBarView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarView()
    }
}
