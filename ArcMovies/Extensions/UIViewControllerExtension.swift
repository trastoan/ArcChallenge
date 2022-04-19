//
//  UIViewControllerExtension.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 20/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//
import UIKit

extension UIViewController {
    //Sets iOS 11 Navigation Bar
    func preferLargeTitles() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.largeTitleTextAttributes = self.navigationController?.navigationBar.titleTextAttributes
    }
}
