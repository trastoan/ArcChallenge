//
//  UIAlertExtension.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 23/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func showPassiveAlertOn(view: UIViewController, with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
}
