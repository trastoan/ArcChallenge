//
//  MoviesCollectionViewCell.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 20/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    let moviePosterImage: LoadableImageView! = {
        let imageView = LoadableImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let dateHeaderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(displayP3Red: 0.15, green: 0.15, blue: 0.15, alpha: 0.7)
        return view
    }()

    let genresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font(named: "Helvetica", size: 10, weight: .bold)
        label.textColor = .navigationColor
        return label
    }()

    let shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font(named: "Helvetica", size: 14, weight: .bold)
        return label
    }()

    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font(named: "Helvetica", size: 14, weight: .bold)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.71)
        return label
    }()
    
    override func prepareForReuse() {
        moviePosterImage.image = nil
        genresLabel.text = ""
        titleLabel.text = ""
        releaseDateLabel.text = ""
    }
    
    func setup(_ movie: Movie) {
        titleLabel.text = movie.title
        releaseDateLabel.text =  movie.releaseDate == nil || movie.releaseDate == "" ? "Unknow" : movie.releaseDate?.formattedDate()
        Task {
            genresLabel.text = await movie.getGenres()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        shadowView.dropShadow(withOpacity: 1.5)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        self.addSubview(shadowView)
        self.addSubview(moviePosterImage)
        self.addSubview(dateHeaderView)
        self.addSubview(releaseDateLabel)
        self.addSubview(genresLabel)
        self.addSubview(titleLabel)
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([
            moviePosterImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            moviePosterImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            moviePosterImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            moviePosterImage.heightAnchor.constraint(equalTo: moviePosterImage.widthAnchor, multiplier: 1.42),

            dateHeaderView.topAnchor.constraint(equalTo: moviePosterImage.topAnchor),
            dateHeaderView.widthAnchor.constraint(equalTo: moviePosterImage.widthAnchor),
            dateHeaderView.heightAnchor.constraint(equalToConstant: 32),
            dateHeaderView.centerXAnchor.constraint(equalTo: moviePosterImage.centerXAnchor),

            shadowView.centerXAnchor.constraint(equalTo: moviePosterImage.centerXAnchor),
            shadowView.centerYAnchor.constraint(equalTo: moviePosterImage.centerYAnchor),
            shadowView.widthAnchor.constraint(equalTo: moviePosterImage.widthAnchor),
            shadowView.heightAnchor.constraint(equalTo: moviePosterImage.heightAnchor),

            releaseDateLabel.centerXAnchor.constraint(equalTo: dateHeaderView.centerXAnchor),
            releaseDateLabel.centerYAnchor.constraint(equalTo: dateHeaderView.centerYAnchor),

            titleLabel.topAnchor.constraint(equalTo: moviePosterImage.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),

            genresLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            genresLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            genresLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            genresLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -4)

        ])
    }
}
