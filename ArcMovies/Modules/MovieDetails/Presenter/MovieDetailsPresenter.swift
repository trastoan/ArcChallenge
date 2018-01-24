//
//  MovieDetailsPresenter.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 21/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import Foundation
class MovieDetailsPresenter: DetailsPresenter {
    var detailedMovie: Movie!
    var view: DetailsInterface?
    
    func updateView() {
        view?.showDetails(for: detailedMovie)
    }
}
