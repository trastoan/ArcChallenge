//
//  ArrayExtension.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 23/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import Foundation
extension Array {
    //Get unique data based on key value
    func filterDuplicate<T>(_ keyValue:(Element)->T) -> [Element] {
        var uniqueKeys = Set<String>()
        return filter{uniqueKeys.insert("\(keyValue($0))").inserted}
    }
}
