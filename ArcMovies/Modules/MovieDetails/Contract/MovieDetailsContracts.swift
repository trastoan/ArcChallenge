//
//  MovieDetailsContracts.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 21/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

protocol DetailsInterface: class {
    var presenter: DetailsPresenter! { get set }
    func showDetails(for movie: Movie)
}

protocol DetailsPresenter: class {
    var detailedMovie: Movie! { get set }
    weak var view: DetailsInterface? { get set }
    func updateView()
}

protocol DetailsWireframe: class {
    static func assembleModule(with movie: Movie) -> UIViewController
}
