//
//  Genre.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 19/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import Foundation

struct GenreList: Codable {
    let genres: [Genre]
    //Filename for cache
    static let fileName = "genresList"
    
    //If difference found, remove genre list from cache to be downloaded again
    static func checkListValidity(moviesGenre: [Int], list: [Int]) {
        let storedList = Set(list)
        let validationList = Set(moviesGenre)

        if validationList.subtracting(storedList).count > 0 {
            Cache.remove(fileName)
        }
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}
