//
//  StringExtension.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 23/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import Foundation

extension String {
    func formattedDate() -> String {
        let formatter = DateFormatter.yyyyMMdd
        if let date = formatter.date(from: self) {
            return date.formattedDateForRelease
        }else {
            return self
        }
    }
}
