//
//  MovieSearchTableViewCell.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 22/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

class MovieSearchTableViewCell: UITableViewCell {

    let posterImageView: LoadableImageView = {
        let imageView = LoadableImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font(named: "Helvetica", size: 18, weight: .bold)
        label.numberOfLines = 2
        return label
    }()

    let genresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font(named: "Helvetica", size: 14, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    override func prepareForReuse() {
        titleLabel.text = ""
        genresLabel.text = ""
        posterImageView.image = nil
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with movie: Movie) {
        self.selectionStyle = .none
        titleLabel.text = movie.title
        posterImageView.dropShadow(withOpacity: 1)
        Task {
            genresLabel.text = await movie.getGenres()
        }
    }

    func setupSubviews() {
        self.addSubview(posterImageView)
        self.addSubview(titleLabel)
        self.addSubview(genresLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            posterImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            posterImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.4),

            titleLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            titleLabel.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),

            genresLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            genresLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            genresLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)

        ])
    }
}
