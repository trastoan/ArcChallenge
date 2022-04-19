//
//  MovieSearchRouter.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 22/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit
class MovieSearchRouter: SearchWireframe {
    var viewController: UIViewController?
    
    func presentDetailsForMovie(movie: Movie) {
        let destination = MovieDetailsRouter.assembleModule(with: movie)
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
    
    static func assembleModule() -> UIViewController {
        let searchController = MovieSearchViewController()
        let presenter = MovieSearchPresenter()
        let interactor = MovieSearchInteractor()
        let router = MovieSearchRouter()
        
        let navigation = UINavigationController(rootViewController: searchController)
        navigation.navigationBar.tintColor = .white
        navigation.navigationBar.barTintColor = UIColor.navigationColor
        navigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
//        let view = navigation.childViewControllers.first as! MovieSearchViewController
        
        searchController.presenter = presenter
        
        presenter.view = searchController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = searchController
        
        return navigation
    }
}
