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
    func preferLargeTitles(isOn: Bool = true) {
        self.navigationController?.navigationBar.prefersLargeTitles = isOn
        self.navigationItem.largeTitleDisplayMode = isOn ? .always : .never
        self.navigationController?.navigationBar.largeTitleTextAttributes = self.navigationController?.navigationBar.titleTextAttributes
    }
}
