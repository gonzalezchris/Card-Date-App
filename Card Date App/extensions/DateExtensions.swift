//
//  Dates.swift
//  Card Date App
//
//  Created by Christoph on 3/24/18.
//  Copyright © 2018 Christoph. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentMonthAndYear() -> (month: Int, year: Int) {
        let today = Date()
        let gregorian = NSCalendar(calendarIdentifier: .gregorian)
        let monthInt = gregorian?.component(.month, from: today)
        let yearInt = gregorian?.component(.year, from: today)
        
        return (monthInt ?? 03, yearInt ?? 2018)
    }
    
    static func getYears() -> [Int] {
        let today = Date()
        let gregorian = NSCalendar(calendarIdentifier: .gregorian)
        let yearComponent = gregorian?.component(.year, from: today)
        var years: [Int] = []
        
        years.append(yearComponent ?? 2018)
        
        while (years.count < 21 && years.count > 0) {
            years.append(years.last! + 1)
        }
        
        return years
    }
    
    static func getMonths() -> [String] {
        return [
            Month.jan.monthName(),
            Month.feb.monthName(),
            Month.mar.monthName(),
            Month.apr.monthName(),
            Month.may.monthName(),
            Month.jun.monthName(),
            Month.jul.monthName(),
            Month.aug.monthName(),
            Month.sep.monthName(),
            Month.ov.monthName(),
            Month.nov.monthName(),
            Month.dec.monthName(),
        ]
    }
    
    static func isCurrentDateBefore(selectedDates dates: (month: UInt, year: UInt)) throws -> Bool {
        // is valid date?
        if (dates.month == 0 || dates.year == 0) { throw DateError.invalidDate }
        
        let currentDates = Date.getCurrentMonthAndYear()
        let currentDateComponents = NSDateComponents()
        currentDateComponents.year = currentDates.year
        currentDateComponents.month = currentDates.month
        
        let selectedDatesComponents = NSDateComponents()
        selectedDatesComponents.year = Int(dates.year)
        selectedDatesComponents.month = Int(dates.month)
        
        let selectedDate = NSCalendar(calendarIdentifier: .gregorian)?.date(from: selectedDatesComponents as DateComponents)
        let currentDate = NSCalendar(calendarIdentifier: .gregorian)?.date(from: currentDateComponents as DateComponents)
        
        guard let unwrappedCurrent = currentDate, let unwrappedSelected = selectedDate else { throw DateError.invalidDate }
        
        guard unwrappedCurrent <= unwrappedSelected else { throw DateError.dateInPast }

        return unwrappedCurrent <= unwrappedSelected
    }
    
}
