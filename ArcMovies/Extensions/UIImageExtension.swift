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
        Manager.shared.cancelRequest(for: self)
        self.image = nil
        guard let imageURL = url else {
            activityIndicator.stopAnimating()
            self.image = defaultImage
            return
        }
        Manager.shared.loadImage(with: imageURL) { (images) in
            activityIndicator.stopAnimating()
            guard let image = images.value else {
                self.image = defaultImage
                return
            }
            self.image = image
        }
    }
    
    func loadImageInCollectionCell(withURL url: URL?, collection: UICollectionView, indexPath: IndexPath, cell: UICollectionViewCell, defaultImage: UIImage = #imageLiteral(resourceName: "NoPoster")) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.setupOn(view: self)
        activityIndicator.startAnimating()
        Manager.shared.cancelRequest(for: self)
        self.image = nil
        guard let imageURL = url else {
            activityIndicator.stopAnimating()
            self.image = defaultImage
            return
        }
        Manager.shared.loadImage(with: imageURL) { (images) in
            activityIndicator.stopAnimating()
            guard let image = images.value else {
                self.image = defaultImage
                return
            }
            if collection.indexPath(for: cell)?.row == indexPath.row {
                self.image = image
            }
        }
    }
    
    func loadImageInTableCell(withURL url: URL?, table: UITableView, indexPath: IndexPath, cell: UITableViewCell, defaultImage: UIImage = #imageLiteral(resourceName: "NoPoster")) {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.setupOn(view: self)
        activityIndicator.startAnimating()
        Manager.shared.cancelRequest(for: self)
        self.image = nil
        guard let imageURL = url else {
            activityIndicator.stopAnimating()
            self.image = defaultImage
            return
        }
        Manager.shared.loadImage(with: imageURL) { (images) in
            activityIndicator.stopAnimating()
            guard let image = images.value else {
                self.image = defaultImage
                return
            }
            if table.indexPath(for: cell)?.row == indexPath.row {
                self.image = image
            }
        }
    }
}
