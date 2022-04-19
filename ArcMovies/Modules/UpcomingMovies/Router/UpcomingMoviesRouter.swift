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
        navigation.navigationBar.tintColor = .white
        navigation.navigationBar.barTintColor = UIColor.navigationColor
        navigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
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
}
