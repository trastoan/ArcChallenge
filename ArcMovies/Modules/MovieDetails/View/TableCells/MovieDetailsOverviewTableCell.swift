//
//  MovieDetailsOverviewTableCell.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 21/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

class MovieDetailsOverviewTableCell: UITableViewCell {
    @IBOutlet weak var overviewLabel: UILabel!
    
    func setup(with movie: Movie) {
        overviewLabel.text = movie.overview == "" ? "Overview not available" : movie.overview
    }
}
