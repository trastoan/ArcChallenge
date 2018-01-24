//
//  UpcomingPresenterTests.swift
//  ArcMoviesTests
//
//  Created by Yuri Saboia Felix Frota on 23/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import XCTest
import Foundation
@testable import ArcMovies

class UpcomingPresenterTests: XCTestCase {
    var presenter: UpcomingMoviesPresenter?
    var view: UpcomingMoviesViewController?
    var interactor: UpcomingMoviesInteractor?
    var movie: Movie?
    
    override func setUp() {
        movie = Movie(id: 2, title: "TestMovie", originalTitle: "The Movie", genres: [1,2,3], poster: "/thisMoviePoster", overview: nil, releaseDate: nil, backdrop: "/thisMovieBackdrop")
        guard let nav = UpcomingMoviesRouter.assembleModule() as? UINavigationController else {
            XCTFail()
            return
        }
        guard let view = nav.childViewControllers.first as? UpcomingMoviesViewController,
            let presenter = view.presenter as? UpcomingMoviesPresenter,
            let interactor = presenter.interactor as? UpcomingMoviesInteractor else {
                XCTFail()
                return
        }
        
        self.view = view
        view.viewDidLoad()
        self.presenter = presenter
        self.interactor = interactor
    }
    
    func testPresenterFailedUpdateView() {
        presenter?.moviesData = [Movie]()
        XCTAssert(view?.didReachEnd == true)
    }
    
    func testPresenterSucessfulUpdataView() {
        guard let movie = movie,let view = self.view else {
            XCTFail()
            return
        }
        let count = view.moviesData.count
        presenter?.moviesData = [movie]
        XCTAssert(view.moviesData.count > count)
    }
    
    func testPresenterRequiresInteractorUpdate() {
        guard let presenter = self.presenter, let movie = movie else {
            XCTFail()
            return
        }
        interactor?.output.fetchedMovies(movies: [movie])
        XCTAssert(presenter.moviesData.count > 0)
    }
}
