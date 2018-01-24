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
        presenter.updateView(page: currentPage)
    }
    
    fileprivate func setupView() {
        collection.delegate = self
        collection.dataSource = self

        collection.register(MovieCollectionViewCell.self)
        collection.backgroundColor = .white
        if #available(iOS 11.0, *) {
            collection.contentInsetAdjustmentBehavior = .always
        }
        self.navigationItem.title = "Upcoming Movies"
        self.preferLargeTitles()
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

extension UpcomingMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as MovieCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? MovieCollectionViewCell else { return }
        let movie = moviesData[indexPath.row]
        cell.setup(movie)
        //Needs to use this function to check if the cell loading the image is the right cell
        cell.moviePosterImage.loadImageInCollectionCell(withURL: TMDBProvider.posterURL(forPath: movie.poster, andSize: .w342), collection: collectionView, indexPath: indexPath, cell: cell)
        //Loads new data when there are only four cells to appear before end
        if indexPath.row == moviesData.count - 4 && !didReachEnd {
            currentPage += 1
            presenter.updateView(page: currentPage)
        }
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
        //Iphone plus width sizes are 414
        let maximumWidth: CGFloat = 420
        if collectionView.bounds.width < maximumWidth {
            let width = (collectionView.bounds.width/2)
            let height = width * 1.75
            size = CGSize(width: width, height: height)
        } else {
            let height = collectionView.bounds.height
            let width = height * 0.58
            size = CGSize(width: width, height: height)
        }
        return size
    }
}
