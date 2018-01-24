//
//  UpcomingMoviesPresenter.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 20/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import Foundation
class UpcomingMoviesPresenter: UpcomingPresenter, UpcomingInteractorOutput {
    
    weak var view: UpcomingInterface?
    var interactor: UpcomingInteractorInput!
    var router: UpcomingWireframe!
    
    var moviesData = [Movie]() {
        didSet {
            moviesData.count > 0 ? view?.showMoviesData(movies: moviesData) : view?.nothingToFetch()
        }
    }
    
    func fetchedMovies(movies: [Movie]) {
        moviesData = movies
    }
    
    func fetchMovieFailed() {
        view?.nothingToFetch()
    }
    
    func updateView(page: Int) {
        interactor.fetchMovie(page: page)
    }
    
    func showDetailsForMovie(movie: Movie) {
        router.presentDetailsForMovie(movie: movie)
    }
}
