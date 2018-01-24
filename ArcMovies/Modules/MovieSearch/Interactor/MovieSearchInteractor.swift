//
//  MovieSearchInteractor.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 22/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import Foundation
class MovieSearchInteractor: SearchInteractorInput {
    var output: SearchInteractorOutput!
    
    func searchMovie(with name: String) {
        TMDBProvider.searchForMovie(withTitle: name, onPage: 1) { [weak self] (movies, error) in
            guard let strongSelf = self else { fatalError("Unable to get self reference") }
            if error != nil {
                print(error!.localizedDescription)
                DispatchQueue.main.async {
                    strongSelf.output.searchFailed()
                }
            }else {
                DispatchQueue.main.async {
                    guard let resultedMovies = movies else {
                        strongSelf.output.searchFailed()
                        return
                    }
                    strongSelf.output.searchedMovies(movies: resultedMovies)
                }
            }
        }
    }
}
