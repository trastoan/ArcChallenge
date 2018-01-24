//
//  MovieDetailsViewController.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 21/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

enum MovieDetails {
    case header
    case overview
    case basicInfo
}

class MovieDetailsViewController: UIViewController, DetailsInterface {
    var presenter: DetailsPresenter!
    var table: UITableView!
    var detailedMovie: Movie? {
        didSet {
            self.navigationItem.title = detailedMovie?.title ?? "Movie Details"
            table.reloadData()
        }
    }
    var details: [MovieDetails] = [.header,  .basicInfo, .overview]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.updateView()
    }
    
    fileprivate func setupView() {
        table = TableCreator.createTable(onView: self.view)
        table.dataSource = self
        table.separatorStyle = .none
        table.tableFooterView = UIView()
        table.allowsSelection = false
        
        table.register(MovieDetailsHeaderTableCell.self)
        table.register(MovieDetailsBasicInfoTableCell.self)
        table.register(MovieDetailsOverviewTableCell.self)
    }
    
    func showDetails(for movie: Movie) {
        detailedMovie = movie
    }
}

extension MovieDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailedMovie != nil ? details.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = details[indexPath.row]
        guard let movie = detailedMovie else { fatalError("missing movies information") }
        switch cellType {
        case .header:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MovieDetailsHeaderTableCell
            cell.setup(with: movie)
            return cell
        case .overview:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MovieDetailsOverviewTableCell
            cell.setup(with: movie)
            return cell
        case .basicInfo:
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MovieDetailsBasicInfoTableCell
            cell.setup(with: movie)
            return cell
        }
    }
}
