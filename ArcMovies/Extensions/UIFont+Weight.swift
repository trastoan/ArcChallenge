//
//  UIFont+Weight.swift
//  ArcMovies
//
//  Created by Yuri on 22/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//


import UIKit

extension UIFont {
    static func font(named name: String, size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let fontDescriptor = UIFontDescriptor(fontAttributes: [
            UIFontDescriptor.AttributeName.size: size,
            UIFontDescriptor.AttributeName.family: UIFont(name: "Helvetica", size: size)!.familyName
        ])

        let weightedFontDescriptor = fontDescriptor.addingAttributes([
            UIFontDescriptor.AttributeName.traits: [
                UIFontDescriptor.TraitKey.weight: weight
            ]
        ])

        return UIFont(descriptor: weightedFontDescriptor, size: size)
    }
}
