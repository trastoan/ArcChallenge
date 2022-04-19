//
//  MovieSearchContracts.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 22/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

protocol SearchInterface: AnyObject {
    var presenter: SearchPresenter! { get set }
    func showMoviesData(movies: [Movie])
    func nothingToFetch()
}

protocol SearchPresenter: AnyObject {
    func searchMovie(with name: String)
    func showDetailsForMovie(movie: Movie)
}

protocol SearchInteractorOutput: AnyObject {
    func searchedMovies(movies: [Movie])
    func searchFailed()
}

protocol SearchInteractorInput {
    var output: SearchInteractorOutput! { get set }
    func searchMovie(with name: String)
}

protocol SearchWireframe {
    var viewController: UIViewController? { get set }
    
    func presentDetailsForMovie(movie: Movie)
    static func assembleModule() -> UIViewController
}

