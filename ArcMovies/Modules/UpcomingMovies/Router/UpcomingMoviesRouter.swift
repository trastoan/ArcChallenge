//
//  UpcomingMoviesRouter.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 20/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit
class UpcomingMoviesRouter: UpcomingWireframe {
    var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        let upcomingController: UpcomingMoviesViewController = UpcomingMoviesViewController()
        let presenter = UpcomingMoviesPresenter()
        let interactor = UpcomingMoviesInteractor()
        let router = UpcomingMoviesRouter()
        
        let navigation = UINavigationController(rootViewController: upcomingController)
        navigation.setAppearence(background: .navigationColor, tint: .white)

        let view = navigation.children.first as! UpcomingMoviesViewController
        
        upcomingController.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = view
        
        return navigation
    }
    
    func presentDetailsForMovie(movie: Movie) {
        let destination = MovieDetailsRouter.assembleModule(with: movie)
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }

    func presentConfigurations() {
        let destination = SettingsRouter.assembleModule()
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
