//
//  MoviesCollectionViewCell.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 20/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePosterImage: LoadableImageView!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func prepareForReuse() {
        moviePosterImage.image = nil
        genresLabel.text = ""
        titleLabel.text = ""
        releaseDateLabel.text = ""
    }
    
    func setup(_ movie: Movie) {
        titleLabel.text = movie.title
        releaseDateLabel.text =  movie.releaseDate == nil || movie.releaseDate == "" ? "Unknow" : movie.releaseDate?.formattedDate()
        movie.getGenres { [weak self] (genres) in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.genresLabel.text = genres
            }
        }
        shadowView.dropShadow(withOpacity: 1.5)
    }
}
