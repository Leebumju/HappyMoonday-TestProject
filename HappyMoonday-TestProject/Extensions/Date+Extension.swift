//
//  Date+Extension.swift
//  HappyMoonday-TestProject
//
//  Created by 이범준 on 8/12/25.
//
import Foundation

extension Date {
    func dateToString(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = .autoupdatingCurrent
        
        return dateFormatter.string(from: self)
    }
}
