//
//  TMDBProviderTest.swift
//  ArcMoviesTests
//
//  Created by Yuri Saboia Felix Frota on 23/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import XCTest
import Foundation
@testable import ArcMovies

class TMDBProviderTest: XCTestCase {
    var movie: Movie?
    
    override func setUp() {
        movie = Movie(id: 2, title: "TestMovie", originalTitle: "The Movie", genres: [1,2,3], poster: "/thisMoviePoster", overview: nil, releaseDate: nil, backdrop: "/thisMovieBackdrop")
    }
    
    func testGetPosterURL() {
        guard let desiredURL = URL(string: "https://image.tmdb.org/t/p/w342/thisMoviePoster"), let urlPath = movie?.poster, let obtainedURL = TMDBProvider.posterURL(forPath: urlPath, andSize: .w342) else { return }

        XCTAssert(desiredURL.path == obtainedURL.path)
    }
    
    func testGetBackdropURL() {
        guard let desiredURL = URL(string: "https://image.tmdb.org/t/p/w300/thisMovieBackdrop"), let urlPath = movie?.backdrop, let obtainedURL = TMDBProvider.backdropURL(forPath: urlPath, andSize: .w300) else { return }
        
        XCTAssert(desiredURL.path == obtainedURL.path)
    }
    
    func testGetGenresList() {
        let expectation = self.expectation(description: "Loading genres from API")
        
        TMDBProvider.getGenreList(inlanguage: .en) { (genre, error) in
            if error == nil {
                XCTAssert(genre != nil)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    func testGetUpcomingMovies() {
        let expectation = self.expectation(description: "Loading movies from API")
        
        TMDBProvider.movies(in: .upcoming, andPage: 1, withLanguage: .en) { (movies, error) in
            if error == nil {
                XCTAssert(movies != nil)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSearchMovie() {
        let expectation = self.expectation(description: "looking for movies in API")
        
        TMDBProvider.searchForMovie(withTitle: "The name", onPage: 1) { (movies, error) in
            if error == nil {
                XCTAssert(movies != nil)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
