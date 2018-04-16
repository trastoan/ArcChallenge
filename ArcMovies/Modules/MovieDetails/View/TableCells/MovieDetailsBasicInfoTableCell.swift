//
//  MovieDetailsBasicInfoTableCell.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 21/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

class MovieDetailsBasicInfoTableCell: UITableViewCell {
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    func setup(with movie: Movie) {
        originalTitleLabel.text = movie.originalTitle == "" ? "Unknow" : movie.originalTitle
        releaseDateLabel.text = movie.releaseDate == nil || movie.releaseDate == "" ? "Unknow" : movie.releaseDate?.formattedDate()
    }
}
