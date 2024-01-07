//
//  AddNewListItemView.swift
//  Reminders
//
//  Created by Albert on 02.12.23.
//

import SwiftUI

enum Modes {
    case new, edit
}

struct AddNewListItemView: View {
    @StateObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss

    var mode = Modes.new

    init(title: String = "", dueDate: DueDate? = nil, onSave: @escaping OnSaveFunc, mode: Modes = .new) {
        let vMod = ViewModel(title: title, dueDate: dueDate, onSave: onSave)
        _viewModel = StateObject(wrappedValue: vMod)
        self.mode = mode
    }

    var body: some View {
        Form {
            if mode == .edit {
                HStack(alignment: .center) {
                    Text("Edit entry")
                        .font(.title)
                        .padding(.bottom, 20)
                }
            }
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Image(systemName: Constants.Icons.circle)
                        .font(.system(size: 14))
                        .opacity(0.2)
                    TextField("", text: $viewModel.title)
                }
                Text("Notes")
                    .opacity(0.2)
                    .padding(.leading, 30)
                HStack {
                    DueDateSelectionView(dueDate: $viewModel.dueDate)
                    if viewModel.dueDate != nil {
                        Button("Clear") {
                            viewModel.dueDate = nil
                        }
                    }
                    if mode == .edit {
                        Button("Cancel", role: .cancel) {
                            dismiss()
                        }
                    }
                    Button(mode == .new ? "Save" : "Change") {
                        if !viewModel.title.isEmpty {
                            viewModel.onSave(
                                viewModel.title,
                                viewModel.dueDate?.value)
                            viewModel.title = ""
                            viewModel.dueDate = nil
                            if mode == .edit {
                                dismiss()
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .padding(mode == .new ? 0 : 20)
    }
}

#Preview {
    AddNewListItemView( onSave: { _, _ in })
}
