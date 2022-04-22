//
//  UpcomingMoviesViewController.swift
//  ArcMovies
//
//  Created by Yuri Saboia Felix Frota on 20/01/18.
//  Copyright © 2018 YuriFrota. All rights reserved.
//

import UIKit

class UpcomingMoviesViewController: UIViewController, UpcomingInterface {
    
    var collection: UICollectionView!
    var presenter: UpcomingPresenter!
    
    var moviesData = [Movie]() {
        didSet {
            //API sends duplicate data sometimes, so we need to filter it
            moviesData = moviesData.filterDuplicate{$0.id}
            collection.reloadData()
        }
    }
    var didReachEnd = false
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection = CollectionCreator.createCollection(onView: self.view)
        setupView()
        setupConfigurationsButton()
        presenter.updateView(page: currentPage)
    }
    
    fileprivate func setupView() {
        collection.delegate = self
        collection.dataSource = self
        collection.prefetchDataSource = self

        collection.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
        collection.backgroundColor = .systemBackground
        if #available(iOS 11.0, *) {
            collection.contentInsetAdjustmentBehavior = .always
        }
        self.navigationItem.title = "Upcoming Movies"
        self.preferLargeTitles()
    }

    func setupConfigurationsButton() {
        let barButton = UIBarButtonItem(title: nil,
                                        image: UIImage(systemName: "gear"),
                                        primaryAction: UIAction(handler: { _ in self.presenter.showConfigurations() }))

        navigationItem.setRightBarButton(barButton, animated: false)
    }
    
    func showMoviesData(movies: [Movie]) {
        moviesData.append(contentsOf: movies)
    }
    
    func nothingToFetch() {
        if moviesData.count == 0 {
            UIAlertController.showPassiveAlertOn(view: self, with: "Connection Error", and: "Check your internet and try again")
        }
        didReachEnd = true
    }
}

extension UpcomingMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as MovieCollectionViewCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let itemsPerFetch = 20
        let newFetchTrigger = moviesData.count - itemsPerFetch
        if let firstIndex = indexPaths.first?.row,
           firstIndex >= newFetchTrigger {
            currentPage += 1
            presenter.updateView(page: currentPage)
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? MovieCollectionViewCell else { return }
        let movie = moviesData[indexPath.row]
        cell.setup(movie)
        cell.moviePosterImage.loadImage(withURL: TMDBProvider.posterURL(forPath: movie.poster, andSize: .w342))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showDetailsForMovie(movie: moviesData[indexPath.row])
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension UpcomingMoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var size: CGSize

        let width = UIScreen.main.bounds.width

        let navBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
        let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 0
        let height = UIScreen.main.bounds.height - (navBarHeight + tabBarHeight)

        if width < height {
            let cellWidth = width/2
            let cellHeight = cellWidth * 1.75
            size = CGSize(width: cellWidth, height: cellHeight)
        } else {
            let cellHeight = height
            let cellWidth = cellHeight * 0.58
            size = CGSize(width: cellWidth, height: cellHeight)
        }
        return size
    }
}
