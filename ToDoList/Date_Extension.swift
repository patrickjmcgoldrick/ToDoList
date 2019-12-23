//
//  Date_Extension.swift
//  ToDoList
//
//  Created by dirtbag on 11/23/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

import Foundation

extension Date {
    // format date to standard MM/dd/yyyy
    func formatDueDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: self)
    }

    // calculate date without any time information,
    // ie set it to midnight
    func startOfDay() -> Date {
        let cal = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let newDate = cal.startOfDay(for: self)
        return newDate
    }
}
