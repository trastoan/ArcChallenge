//
//  MovieSearchViewController.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 22/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController, SearchInterface {
    var presenter: SearchPresenter!
    var table: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var moviesData = [Movie]() {
        didSet{
            table.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    fileprivate func setupView() {
        table = TableCreator.createTable(onView: self.view)
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .singleLine
        table.tableFooterView = UIView()
        table.rowHeight = 124
        
        table.register(MovieSearchTableViewCell.self)
        
        navigationItem.title = "Search Movies"
        self.preferLargeTitles()
        
        //Searchbar
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for movies"
        searchController.searchBar.tintColor = .white
        searchController.searchBar.changeTextFieldBackground(to: .white, cursor: UIColor.navigationColor)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func showMoviesData(movies: [Movie]) {
        moviesData = movies
    }
    
    func nothingToFetch() {
        if moviesData.count == 0 {
            UIAlertController.showPassiveAlertOn(view: self, with: "Error", and: "Please check your internet connection")
        }
    }
}

extension MovieSearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        moviesData.removeAll()
    }
    func updateSearchResults(for searchController: UISearchController) {
        guard let movieName = searchController.searchBar.text else { return }
        if movieName.count > 1 {
            presenter.searchMovie(with: movieName)
        } else {
            moviesData.removeAll()
        }
    }
}

extension MovieSearchViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MovieSearchTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let movieCell = cell as? MovieSearchTableViewCell else { return }
        let movie = moviesData[indexPath.row]
        //Needs to make sure that the image is being loaded on the correct cell
        movieCell.posterImageView.loadImageInTableCell(withURL: TMDBProvider.posterURL(forPath: movie.poster, andSize: .w154), table: tableView, indexPath: indexPath, cell: cell)
        
        movieCell.setup(with: moviesData[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showDetailsForMovie(movie: moviesData[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if searchController.searchBar.text != "" {
            searchController.searchBar.resignFirstResponder()
        }
    }
}
