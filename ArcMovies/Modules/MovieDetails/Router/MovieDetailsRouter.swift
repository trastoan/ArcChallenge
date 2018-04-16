//
//  MovieDetailsRouter.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 21/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit
class MovieDetailsRouter: DetailsWireframe {
    static func assembleModule(with movie: Movie) -> UIViewController {
        let view = MovieDetailsViewController()
        let presenter = MovieDetailsPresenter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.detailedMovie = movie
        
        return view
    }
}
