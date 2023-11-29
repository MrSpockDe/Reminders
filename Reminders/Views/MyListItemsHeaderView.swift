//
//  MyListItemsHeaderView.swift
//  Reminders
//
//  Created by Albert on 23.11.22.
//

import SwiftUI

struct MyListItemsHeaderView: View {

    let name: String
    let count: Int
    let color: Color

    var body: some View {
        HStack {
            Text(name)
                .font(.system(size: 28))
                .fontWeight(.bold)
                .foregroundColor(color)
                .padding()
            Spacer()
            Text("\(count)")
                .font(.system(size: 32))
                .foregroundColor(color)
                .padding()
        }
    }
}

struct MyListItemsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MyListItemsHeaderView(name: "item", count: 8, color: .red)
    }
}
