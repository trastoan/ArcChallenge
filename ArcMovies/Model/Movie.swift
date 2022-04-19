//
//  Movie.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 18/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import Foundation

//Helps on the API JSON decoding
struct MovieList: Decodable {
    let results: [Movie]?
}

struct Movie: Decodable {
    let id: Int?
    let title: String?
    let originalTitle: String?
    var genres: [Int]?
    let poster: String?
    let overview: String?
    let releaseDate: String?
    let backdrop: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case backdrop = "backdrop_path"
        case overview
        case releaseDate = "release_date"
        case title
        case genres = "genre_ids"
        case poster = "poster_path"
    }
    
    func getGenres(completion: @escaping (String) -> Void){
        guard let genresIds = genres else {
            completion("")
            return
        }
        TMDBProvider.getGenreList(inlanguage: .en) { (genres, error) in
            if error != nil {
                completion("")
            }else {
                guard let genres = genres else {
                    completion("")
                    return
                }
                var genresDict = [Int: String]()
                _ = genres.map{genresDict[$0.id] = $0.name}
                let listIds = Array(genresDict.keys)
                GenreList.checkListValidity(moviesGenre: genresIds, list: listIds)
                let genresNames = genresIds.map{genresDict[$0]}.compactMap{$0}
                completion(genresNames.reduce("") {$0 == "" ? $1 : "\($0) \($1)"})
            }
        }
    }
}
