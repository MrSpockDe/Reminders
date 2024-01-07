//
//  ListItemViewModel.swift
//  Reminders
//
//  Created by Albert on 05.12.23.
//

import Foundation

typealias OnSaveFunc = (String, Date?) -> Void

extension AddNewListItemView {
    class ViewModel: ObservableObject {
        @Published var title = ""
        @Published var dueDate: DueDate?
        var onSave: OnSaveFunc
        init(title: String = "", dueDate: DueDate? = nil, onSave: @escaping OnSaveFunc) {
            self.title = title
            self.dueDate = dueDate
            self.onSave = onSave
        }
    }
}
