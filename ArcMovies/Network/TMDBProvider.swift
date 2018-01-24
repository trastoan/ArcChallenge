//
//  TMDBProvider.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 18/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import Foundation

struct TMDBProvider {
    private static let APIKey = "1f54bd990f1cdfb230adb312546d765d"
    private static let rootPath = "https://api.themoviedb.org/3/"
    private static let imagesRootPath = "https://image.tmdb.org/t/p/"
    
    enum Model: String {
        case movie
        case genre
    }
    
    enum Request: String {
        case upcoming
        case search
    }
    
    enum PosterSize: String {
        case w92
        case w154
        case w342
        case w500
        case w780
        case original
    }
    enum Language: String {
        case en = "en-US"
    }
    enum RequestError: Error {
        case URLMalformation
        case badRequest
        case invalidData
    }
    
    enum BackdropSize: String {
        case w300
        case w780
        case w1280
        case original
    }
    
    static func posterURL(forPath path: String?,andSize size: PosterSize) -> URL? {
        guard let imagePath = path else { return nil }
        return URL(string: "\(imagesRootPath)\(size)\(imagePath)")
    }
    
    static func backdropURL(forPath path: String?, andSize size: BackdropSize) -> URL? {
        guard let imagePath = path else { return nil }
        return URL(string: "\(imagesRootPath)\(size)\(imagePath)")
    }
    
    static func movies(in request: Request, andPage page: Int, withLanguage language: Language, completion: @escaping ([Movie]?, RequestError?) -> Void) {
        guard var components = URLComponents(string: "\(rootPath)\(Model.movie)/\(request)") else {
            completion(nil, .URLMalformation)
            return
        }
        components.queryItems = [
            URLQueryItem(name: "api_key", value: APIKey),
            URLQueryItem(name: "language", value: language.rawValue),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        guard let url = components.url else {
            completion(nil, .URLMalformation)
            return
        }
        getData(fromURL: url, type: MovieList.self) { (list, error) in
            guard let movies = list?.results else {
                completion(nil, .invalidData)
                return
            }
            completion(movies, error)
        }
    }
    
    static func searchForMovie(withTitle title: String, onPage page: Int, completion: @escaping ([Movie]?, RequestError?) -> Void) {
        guard var components = URLComponents(string: "\(rootPath)\(Request.search.rawValue)/\(Model.movie)") else {
            completion(nil, .URLMalformation)
            return
        }
        components.queryItems = [
            URLQueryItem(name: "api_key", value: APIKey),
            URLQueryItem(name: "query", value: title.lowercased()),
            URLQueryItem(name: "page", value: "\(page)"),
        ]
        guard let url = components.url else {
            completion(nil, .URLMalformation)
            return
        }
        getData(fromURL: url, type: MovieList.self) { (list, error) in
            completion(list?.results, error)
        }
    }
    
    static func getGenreList(inlanguage language: Language, completion: @escaping ([Genre]?, RequestError?) -> Void) {
        guard var components = URLComponents(string: "\(rootPath)\(Model.genre)/\(Model.movie)/list") else {
            completion(nil, .URLMalformation)
            return
        }
        components.queryItems = [
            URLQueryItem(name: "api_key", value: APIKey),
            URLQueryItem(name: "language", value: language.rawValue)
        ]
        guard let url = components.url else {
            completion(nil, .URLMalformation)
            return
        }
        
        if !Cache.fileExists(GenreList.fileName) {
            getData(fromURL: url, type: GenreList.self, completion: { (list, error) in
                guard let genresList = list else {
                    completion(nil, error)
                    return
                }
                Cache.save(genresList, as: GenreList.fileName)
                completion(genresList.genres, nil)
            })
        } else {
           let genresList = Cache.load(GenreList.fileName, as: GenreList.self)
           completion(genresList.genres, nil)
        }
    }
    
    private static func getData<T: Decodable>(fromURL url: URL, type: T.Type, completion: @escaping (T?, RequestError?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(nil, .badRequest)
            } else {
                guard let data = data else{
                    completion(nil, .invalidData)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let typeData = try decoder.decode(type, from: data)
                    completion(typeData, nil)
                } catch {
                    completion(nil, .invalidData)
                }
            }
            }.resume()
    }
}
