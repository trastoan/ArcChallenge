//
//  MovieDetailsHeaderTableCell.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 21/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

class MovieDetailsHeaderTableCell: UITableViewCell {
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    func setup(with movie: Movie) {
        movie.getGenres { [weak self] (genres) in
            DispatchQueue.main.async {
                guard let stronSelf = self else { return }
                stronSelf.genresLabel.text = genres
            }
        }
        shadowView.dropShadow(withOpacity: 0.6)
        backdropImageView.loadImage(withURL: TMDBProvider.backdropURL(forPath: movie.backdrop, andSize: .w780))
        posterImageView.loadImage(withURL: TMDBProvider.posterURL(forPath: movie.poster, andSize: .w154))
    }
}
