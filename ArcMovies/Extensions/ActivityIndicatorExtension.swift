//
//  ActivityIndicatorExtension.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 20/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    func setupOn(view: UIView, xFromCenter: CGFloat = 0.0, yFromCenter: CGFloat = 0.0) {
        view.addSubview(self)
        self.style = .large
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: xFromCenter).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yFromCenter).isActive = true
    }
}
