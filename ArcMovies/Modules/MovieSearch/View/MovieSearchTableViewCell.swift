//
//  MovieSearchTableViewCell.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 22/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

class MovieSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    
    override func prepareForReuse() {
        titleLabel.text = ""
        genresLabel.text = ""
        posterImageView.image = nil
    }
    
    func setup(with movie: Movie) {
        self.selectionStyle = .none
        titleLabel.text = movie.title
        posterImageView.dropShadow(withOpacity: 1)
        movie.getGenres { (result) in
            DispatchQueue.main.async {
                self.genresLabel.text = result
            }
        }
    }
}
