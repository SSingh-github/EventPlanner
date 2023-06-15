//
//  Formatting.swift
//  EventPlanner
//
//  Created by Chicmic on 08/06/23.
//

import Foundation

class Formatter {
    private init() {}
    static let shared = Formatter()

    func formatDate(dates: [Date]) -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedStartDate = dateFormatter.string(from: dates[0])
        let formattedEndDate = dateFormatter.string(from: dates[1])
        return [formattedStartDate, formattedEndDate]
    }
    
    func formatSingleDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedStartDate = dateFormatter.string(from: date)
        return formattedStartDate
    }
    
    func createDateFromString(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: date)
    }
    
    func formatTime(times: [Date]) -> [String] {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let formattedStartTime = timeFormatter.string(from: times[0])
        let formattedEndTime = timeFormatter.string(from: times[1])
        return [formattedStartTime, formattedEndTime]
    }
    
    func getMonthIndexRange(date: String) -> ClosedRange<String.Index> {
        let start = date.index(date.startIndex, offsetBy: 5)
        let end   = date.index(date.startIndex, offsetBy: 6)
        return start...end
    }
}
