//
//  UpcomingMoviesInteractor.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 20/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import Foundation
class UpcomingMoviesInteractor: UpcomingInteractorInput {
    var output: UpcomingInteractorOutput!
    
    func fetchMovie(page: Int) {
        TMDBProvider.movies(in: .upcoming, andPage: page, withLanguage: .en) { [weak self] (movies, error) in
            guard let strongSelf = self else {
                fatalError("Unable to get UpcomingMoviesInteractor reference")
            }
            if error != nil {
                DispatchQueue.main.async {
                    strongSelf.output.fetchMovieFailed()
                }
            }else {
                DispatchQueue.main.async {
                    guard let fetchedMovies = movies else {
                        strongSelf.output.fetchMovieFailed()
                        return
                    }
                    strongSelf.output.fetchedMovies(movies: fetchedMovies)
                }
            }
        }
    }
}
