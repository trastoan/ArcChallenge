//
//  DateFormatterExtension.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 18/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter
    }()
}

extension Date {
    var formattedDateForRelease : String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = NSLocale.current
        
        return formatter.string(from: self as Date)
    }
}
