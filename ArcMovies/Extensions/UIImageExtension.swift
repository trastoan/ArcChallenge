//
//  UIImageExtension.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 20/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {
    func loadImage(withURL url: URL?, defaultImage: UIImage = #imageLiteral(resourceName: "NoPoster")) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.setupOn(view: self)
        activityIndicator.startAnimating()
        Nuke.cancelRequest(for: self)
        self.image = nil
        guard let imageURL = url else {
            activityIndicator.stopAnimating()
            self.image = defaultImage
            return
        }
        Nuke.loadImage(with: imageURL, into: self) { result in
            activityIndicator.stopAnimating()
            switch result {
                case .success(let response):
                    self.image = response.image
                case .failure:
                    self.image = defaultImage
            }
        }
    }
    
    func loadImageInCollectionCell(withURL url: URL?, collection: UICollectionView, indexPath: IndexPath, cell: UICollectionViewCell, defaultImage: UIImage = #imageLiteral(resourceName: "NoPoster")) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.setupOn(view: self)
        activityIndicator.startAnimating()
        Nuke.cancelRequest(for: self)
        self.image = nil
        guard let imageURL = url else {
            activityIndicator.stopAnimating()
            self.image = defaultImage
            return
        }
        Nuke.loadImage(with: imageURL, into: self) { result in
            activityIndicator.stopAnimating()
            switch result {
                case .success(let response):
                    if collection.indexPath(for: cell)?.row == indexPath.row {
                        self.image = response.image
                    }
                case .failure:
                    self.image = defaultImage
            }
        }
    }
    
    func loadImageInTableCell(withURL url: URL?, table: UITableView, indexPath: IndexPath, cell: UITableViewCell, defaultImage: UIImage = #imageLiteral(resourceName: "NoPoster")) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.setupOn(view: self)
        activityIndicator.startAnimating()
        Nuke.cancelRequest(for: self)
        self.image = nil
        guard let imageURL = url else {
            activityIndicator.stopAnimating()
            self.image = defaultImage
            return
        }
        Nuke.loadImage(with: imageURL, into: self) { result in
            activityIndicator.stopAnimating()
            switch result {
                case .success(let response):
                    if table.indexPath(for: cell)?.row == indexPath.row {
                        self.image = response.image
                    }
                case .failure:
                    self.image = defaultImage
            }
        }
    }
}
