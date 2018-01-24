//
//  SearchBarExtension.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 22/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

extension UISearchBar {
    func changeTextFieldBackground(to color: UIColor, cursor: UIColor) {
        guard let textField = self.value(forKey: "searchField") as? UITextField else { return }
        textField.tintColor = cursor
        if let backgroundView = textField.subviews.first {
            backgroundView.backgroundColor = color
            backgroundView.layer.cornerRadius = 10
            backgroundView.clipsToBounds = true
        }
    }
}
