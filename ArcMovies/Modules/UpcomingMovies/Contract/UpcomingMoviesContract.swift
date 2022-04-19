//
//  UpcomingMoviesContract.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 20/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

//Interface contract
protocol UpcomingInterface: AnyObject {
    func showMoviesData(movies: [Movie])
    func nothingToFetch()
}

//Presenter contract
protocol UpcomingPresenter: AnyObject {
    func updateView(page: Int)
    func showDetailsForMovie(movie: Movie)
}

//Interactor Output Contractor
protocol UpcomingInteractorOutput: AnyObject {
    func fetchedMovies(movies: [Movie])
    func fetchMovieFailed()
}

//Interactor Input Contract
protocol UpcomingInteractorInput: AnyObject {
    var output: UpcomingInteractorOutput! { get set }
    
    func fetchMovie(page: Int)
}

//Wireframe Contract
protocol UpcomingWireframe: AnyObject {
    var viewController: UIViewController? { get set }
    
    func presentDetailsForMovie(movie: Movie)
    static func assembleModule() -> UIViewController
}
