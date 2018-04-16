//
//  TableCreator.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 21/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

struct TableCreator {
    static func createTable(onView view: UIView) -> UITableView {
        let table = UITableView(frame: view.frame)
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        view.centerOnSelf(view: table)
        return table
    }
}
