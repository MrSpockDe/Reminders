//
//  AddNewListView.swift
//  Reminders
//
//  Created by Albert on 31.10.22.
//

import SwiftUI

struct AddNewListView: View {

    @StateObject private var viewModel: Viewmodel
    @Environment(\.dismiss) var dismiss

    init() {
        let viewModel = Viewmodel(context: CoreDataManager.shared.persistentContainer.viewContext)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Text("New List")
                    .font(.headline)
                    .padding(.bottom, 20)
                HStack {
                    Text("Name:")
                    TextField("", text: $viewModel.name)
                }

                HStack {
                    Text("Color")
                    ColorListView(selectedColor: $viewModel.color)
                }
            }

            HStack {
                Spacer()
                Button("Cancel") {
                    dismiss()
                }
                Button("OK") {
                    viewModel.save()
                    dismiss()
                }
                .disabled(viewModel.name.isEmpty)
             }
        }
        .frame(minWidth: 300)
        .padding()
    }
}

struct AddNewListView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewListView()
    }
}
