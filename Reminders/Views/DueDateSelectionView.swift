//
//  DueDateSelectionView.swift
//  Reminders
//
//  Created by Albert on 02.12.23.
//

import SwiftUI

struct DueDateSelectionView: View {
    @Binding var dueDate: DueDate?
    @State private var selectedDate: Date = Date.today
    @State private var showCalender: Bool = false

    var body: some View {
        Menu {
            Button {
                dueDate = .today
            } label: {
                VStack {
                    Text("Today \n \(Date.today.formatAsString)")
                }
            }
            Button {
                dueDate = .tomorrow
            } label: {
                VStack {
                    Text("Tomorrow \n \(Date.tomorrow.formatAsString)")
                }
            }
            Button {
                showCalender = true
            } label: {
                VStack {
                    Text("Custom")
                }
            }
        } label: {
            Label(dueDate == nil ? NSLocalizedString("Add Date:", comment: "Datum einstellen") : dueDate!.title,
                  systemImage: "calendar")
        }
        .menuStyle(.borderedButton)
        .fixedSize()
        .popover(isPresented: $showCalender) {
            DatePicker("Custom", selection: $selectedDate, displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(.graphical)
                .onChange(of: selectedDate) { newDate in
                    dueDate = .custom(newDate)
                    showCalender = false
                }
        }
    }
}

#Preview {
    DueDateSelectionView(dueDate: .constant(nil))
}
