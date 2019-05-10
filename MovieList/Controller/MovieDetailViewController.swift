//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Sehmus GOKCE on 10.05.2019.
//  Copyright © 2019 Sehmus GOKCE. All rights reserved.
//

import UIKit
import Cosmos

class MovieDetailViewController: BaseViewController {
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var starView: CosmosView!
    @IBOutlet weak var twMovieDescription: UITextView!
    
    @IBOutlet weak var btnFavorite: DOFavoriteButton!
    
    var movie : MovieModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnFavorite.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        
        guard movie != nil else {
            ViewUtil.displayErrorMessage(vc: self)
            return
        }
        bindModel(model: movie!)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navBarTitle = "movielistdetail.page.title".localized
        navBarLeftBarButtonTypes = [.back]
        super.viewWillAppear(animated)
    }
    
    private func bindModel(model : MovieModel) {
        imgMovie.cacheImage(urlString: Constants.Service.imageBaseUrl + model.posterPath, defaultImage: UIImage(named: "movie_placeholder"))
        lblTitle.text = model.title
        starView.rating = model.voteAverage / 2
        twMovieDescription.text = model.overview
        
        btnFavorite.isSelected = FavoriteService.isMovieAddedInFavorites(movie: model)
    }
    
    @objc func favoriteButtonTapped(sender: DOFavoriteButton) {
        guard movie != nil else {
            return
        }
        if sender.isSelected {
            // deselect
            sender.deselect()
            FavoriteService.removeMovieFromFavorites(movie: movie!)
        } else {
            // select with animation
            sender.select()
            FavoriteService.addMovieToFavorites(movie: movie!)
        }
        
        
    }

}
