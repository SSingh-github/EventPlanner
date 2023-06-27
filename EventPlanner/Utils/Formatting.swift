//
//  Formatting.swift
//  EventPlanner
//
//  Created by Chicmic on 08/06/23.
//

import Foundation


//This singleton contains the functions to format the strings to different date formats ans vice-versa.

class Formatter {
    private init() {}
    static let shared = Formatter()

    //formats the array of date objects to string formats and returns the array of strings.
    func formatDate(dates: [Date]) -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.StringFormats.dateFormat
        let formattedStartDate = dateFormatter.string(from: dates[0])
        let formattedEndDate = dateFormatter.string(from: dates[1])
        return [formattedStartDate, formattedEndDate]
    }
    
    //formats the single date object to string and returns the string.
    func formatSingleDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.StringFormats.dateFormat
        let formattedStartDate = dateFormatter.string(from: date)
        return formattedStartDate
    }
    
    //converts the date in the string format to date object and returns the date object.
    func createDateFromString(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.StringFormats.dateFormat
        return dateFormatter.date(from: date)
    }
    
    //converts the array of date objects to strings which are of the format of time and returns the array of strings.
    func formatTime(times: [Date]) -> [String] {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = Constants.StringFormats.timeFormat
        let formattedStartTime = timeFormatter.string(from: times[0])
        let formattedEndTime = timeFormatter.string(from: times[1])
        return [formattedStartTime, formattedEndTime]
    }
    
    //takes the date string as the argument and returns a closed range object for the range of month.
    func getMonthIndexRange(date: String) -> ClosedRange<String.Index> {
        let start = date.index(date.startIndex, offsetBy: 5)
        let end   = date.index(date.startIndex, offsetBy: 6)
        return start...end
    }
}
