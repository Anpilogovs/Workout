//
//  Date + Extension.swift
//  Workout
//
//  Created by Сергей Анпилогов on 26.01.2023.
//

import Foundation


extension Date {
    
    func localDate() -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: self) ?? Date()
        return localDate
    }
    
    func getWeekDayNumber() -> Int {
        let calencar = Calendar.current
        let weekDay = calencar.component(.weekday, from: self)
        return weekDay
    }
    
    func startEndDate() -> (Date, Date) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        
        let dateStart = formatter.date(from: "\(day)/\(month)/\(year)") ?? Date()
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart) ?? Date()
        }()
        
        return (dateStart, dateEnd)
    }
    
    func offSetDays(days: Int) -> Date {
        let offSetDate = Calendar.current.date(byAdding: .day, value: -days, to: self) ?? Date()
        return offSetDate
    }
    
    func getWeekArray() -> [[String]] {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        // two letter for collection (month)
        formatter.dateFormat = "EEEEEE"
        
        var weekArray: [[String]] = [[], []]
        let calendar = Calendar.current
        
        for index in -6...0 {
            let date  = calendar.date(byAdding: .weekday, value: index, to: self) ?? Date()
            let day = calendar.component(.day, from: date)
            weekArray[1].append("\(day)")
            let weekday = formatter.string(from: date)
            weekArray[0].append(weekday)
            print(date)
        }
        
        return weekArray
    }
}
