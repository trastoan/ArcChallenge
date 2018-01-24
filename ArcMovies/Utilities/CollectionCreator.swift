//
//  CollectionCreator.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 20/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

struct CollectionCreator {
    static func createCollection(onView view: UIView) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        view.addSubview(collection)
        collection.translatesAutoresizingMaskIntoConstraints = false
        view.centerOnSelf(view: collection)
        return collection
    }
}
