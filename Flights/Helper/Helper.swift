//
//  Helper.swift
//  Flights
//
//  Created by Leonardo Reis on 13/07/19.
//  Copyright © 2019 Leonardo Reis. All rights reserved.
//

import UIKit

class Helper: NSObject {

}

// MARK: - Date

extension Date {
    func getWeekDates() -> (thisWeek:[Date],nextWeek:[Date]) {
        var tuple: (thisWeek:[Date],nextWeek:[Date])
        var arrThisWeek: [Date] = []
        for i in 0..<7 {
            arrThisWeek.append(Calendar.current.date(byAdding: .day, value: i, to: startOfWeek)!)
        }
        var arrNextWeek: [Date] = []
        for i in 1...7 {
            arrNextWeek.append(Calendar.current.date(byAdding: .day, value: i, to: arrThisWeek.last!)!)
        }
        tuple = (thisWeek: arrThisWeek,nextWeek: arrNextWeek)
        return tuple
    }
    
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var startOfWeek: Date {
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
        return gregorian.date(byAdding: .day, value: 1, to: sunday!)!
    }
    
    func toDate(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    static func getFormattedDate(stringDate: String, formatter: String) -> String {
        //        "MMM dd,yyyy"
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = formatter
        
        let date: Date? = dateFormatterGet.date(from: stringDate)
        return dateFormatterPrint.string(from: date!);
    }
}

// MARK: - Int

extension Int {
    func minutesToHoursMinutes () -> String {
        let tupleTime: (hours : Int , leftMinutes : Int) =  (self / 60, (self % 60))
        return "\(tupleTime.hours)h" + " " + "\(tupleTime.leftMinutes)m"
    }
}
