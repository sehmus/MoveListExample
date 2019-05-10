//
//  MovieListViewController.swift
//  MovieList
//
//  Created by Sehmus GOKCE on 9.05.2019.
//  Copyright © 2019 Sehmus GOKCE. All rights reserved.
//

import UIKit


enum MovieListViewPageType {
    case grid, list
}

class MovieListViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieList : [MovieModel] = []
    var currentPage = 0
    var lastSelectedIndex = -1
    var hasMoreToLoad = true
    var pageType : MovieListViewPageType = .list {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: MovieCollectionViewCell.className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: MovieCollectionViewCell.className)
        
        let nibFooter = UINib(nibName: MovieFooterViewCell.className, bundle: nil)
        collectionView.register(nibFooter, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MovieFooterViewCell.className)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getMovieListFromService()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navBarTitle = "movielist.page.title".localized
        navBarRightBarButtonTypes = [.multiselect]
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard lastSelectedIndex != -1 else {
            return
        }
        collectionView.reloadItems(at: [IndexPath(row: lastSelectedIndex, section: 0)])
        
    }
    
    func getMovieListFromService(){
        ViewUtil.showLoadingView()
        MovieService.getPopularMovies(page: currentPage + 1) { (resultModel, error) in
            ViewUtil.hideLoadingView()
            guard resultModel != nil else {
                ViewUtil.displayErrorMessage(vc: self)
                return
            }
            if resultModel!.page > self.currentPage {
                self.movieList.append(contentsOf: resultModel!.results)
            }
            self.currentPage = self.currentPage + 1
            if self.currentPage == resultModel?.totalPages {
                self.hasMoreToLoad = false
            }
            self.collectionView.reloadData()
            
            
        }
    }
    
    override func onClickRightNavBarButton(_ sender: UIButton) {
        if sender.tag == NavBarButtonTag.multiselect.rawValue {
            if pageType == .grid {
                pageType = .list
            }
            else
            {
                pageType = .grid
            }
        }
    }


}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.className, for: indexPath) as! MovieCollectionViewCell
        cell.delegate = self
        cell.bindMovieModel(movie: movieList[indexPath.row])
        let isFavorited = FavoriteService.isMovieAddedInFavorites(movie: movieList[indexPath.row])
        cell.setIsFavorited(isFavorited: isFavorited)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width : CGFloat = 0
        
        switch pageType {
        case .grid:
            width = self.collectionView.frame.width / 2 - Constants.MovieCollectionView.CellMargin
        default:
            width = self.collectionView.frame.width
        }
        let height = CGFloat(Constants.MovieCollectionView.CellHeight)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = movieList[indexPath.row]
        
        let movieDetailVC = self.storyboard?.instantiateViewController(withIdentifier: MovieDetailViewController.className) as! MovieDetailViewController
        movieDetailVC.movie = model
        
        self.navigationController?.pushViewController(movieDetailVC, animated: true)
        
        self.lastSelectedIndex = indexPath.row
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MovieCollectionViewCell
        cell.isSelected = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MovieCollectionViewCell
        cell.isSelected = false
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let movieFooterViewCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MovieFooterViewCell.className, for: indexPath) as! MovieFooterViewCell
        movieFooterViewCell.delegate = self
        return movieFooterViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard movieList.count != 0 && hasMoreToLoad == true else {
             return CGSize(width: collectionView.frame.size.width, height: 0)
        }
        return CGSize(width: collectionView.frame.size.width, height: Constants.MovieFooterViewCell.CellHeight)
    }
}

extension MovieListViewController : MovieFooterViewCellDelegate {
    func loadMoreTouched(button: UIButton) {
        getMovieListFromService()
    }
}

extension MovieListViewController : MovieCollectionViewCellDelegate {
    func favoriteButtonTapped(model: MovieModel, isFavorited: Bool) {
        
        if isFavorited {
            FavoriteService.addMovieToFavorites(movie: model)
        }
        else {
            FavoriteService.removeMovieFromFavorites(movie: model)
        }
        
    }
}
