//
//  ColorListView.swift
//  Reminders
//
//  Created by Albert on 31.10.22.
//

import SwiftUI

struct ColorListView: View {

    let colors: [Color] = [.red, .orange, .green, .blue, .purple]
    @Binding var selectedColor: Color

    var body: some View {
        HStack {
            ForEach(colors, id: \.self) { color in
                Image(systemName: selectedColor == color ?
                      Constants.Icons.recordCircleFill :
                        Constants.Icons.circleFill)
                    .foregroundColor(color)
                    .font(.system(size: 16))
                    .clipShape(Circle())
                    .onTapGesture {
                        selectedColor = color
                    }
            }
        }
    }
}

struct ColorListView_Previews: PreviewProvider {
    static var previews: some View {
        ColorListView(selectedColor: .constant(.purple))
    }
}
