//
//  MovieSearchPresenter.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 22/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import Foundation

class MovieSearchPresenter: SearchPresenter, SearchInteractorOutput {
    weak var view: SearchInterface?
    var interactor: SearchInteractorInput!
    var router: SearchWireframe!
    
    var moviesData = [Movie]() {
        didSet {
            moviesData.count > 0 ? view?.showMoviesData(movies: moviesData) : view?.nothingToFetch()
        }
    }
    
    func searchMovie(with name: String) {
        interactor.searchMovie(with: name)
    }
    
    func showDetailsForMovie(movie: Movie) {
        router.presentDetailsForMovie(movie: movie)
    }
    
    func searchedMovies(movies: [Movie]) {
        moviesData = movies
    }
    
    func searchFailed() {
        view?.nothingToFetch()
    }
}
