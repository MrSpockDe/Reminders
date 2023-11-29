//
//  DueDate.swift
//  Reminders
//
//  Created by Albert on 27.11.22.
//

import Foundation

enum DueDate {
    case today
    case tomorrow
    case yesterday
    case custom(Date)
}

extension DueDate {
    var value: Date {
        switch self {
        case .today:
            return Date.today
        case .yesterday:
            return Date.yesterday
        case .tomorrow:
            return Date.tomorrow
        case .custom(let date):
            return date
        }
    }

    var title: String {
        switch self {
        case .today: return "Today"
        case .tomorrow: return "Tomorrow"
        case .yesterday: return "Yesterday"
        case .custom(let date): return date.formatAsString
        }
    }

    var isPastDue: Bool {
        value < Date()
    }

    static func from(value: Date) -> DueDate {
        let calendar = NSCalendar.current
        if calendar.isDateInToday(value) {
            return .today
        } else if calendar.isDateInTomorrow(value) {
            return .tomorrow
        } else if calendar.isDateInYesterday(value) {
            return .yesterday
        }

        return .custom(value)
    }
}
