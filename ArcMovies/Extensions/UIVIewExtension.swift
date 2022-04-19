//
//  UIVIewExtension.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 21/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadow(withOpacity opacity: Float = 0.2, radius: CGFloat = 3) {
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 3, height: 4)
        self.layer.shadowRadius = radius
    }
    
    //Center a view on a super view
    func centerOnSelf(view: UIView) {
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
