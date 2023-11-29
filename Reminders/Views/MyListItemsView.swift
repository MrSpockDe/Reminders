//
//  MyListItemsView.swift
//  Reminders
//
//  Created by Albert on 27.11.22.
//

import SwiftUI

struct MyListItemsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            List(1...10, id: \.self) { index in
                Text("Item \(index)")
            }
        }
    }
}

struct MyListItemsView_Previews: PreviewProvider {
    static var previews: some View {
        MyListItemsView()
    }
}
