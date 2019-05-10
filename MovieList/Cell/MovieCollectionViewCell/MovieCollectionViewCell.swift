//
//  MovieCollectionViewCell.swift
//  MovieList
//
//  Created by Sehmus GOKCE on 9.05.2019.
//  Copyright © 2019 Sehmus GOKCE. All rights reserved.
//

import UIKit


protocol MovieCollectionViewCellDelegate {
    func favoriteButtonTapped(model: MovieModel, isFavorited: Bool)
}

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var btnFavorite: DOFavoriteButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imgMovie: UIImageView!
    
    var movieModel : MovieModel? = nil
    
    var delegate : MovieCollectionViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.contentView.isUserInteractionEnabled = false
        btnFavorite.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    @objc func favoriteButtonTapped(sender: DOFavoriteButton) {
        if sender.isSelected {
            // deselect
            sender.deselect()
            
        } else {
            // select with animation
            sender.select()
        }
        
        guard delegate != nil else {
            return
        }
        delegate?.favoriteButtonTapped(model: movieModel!, isFavorited: sender.isSelected)
    }
    
    func bindMovieModel(movie : MovieModel) {
        lblTitle.text = movie.title
        let posterUrl = Constants.Service.imageBaseUrl + movie.posterPath
        imgMovie.cacheImage(urlString: posterUrl, defaultImage: UIImage(named: "movie_placeholder"))
        self.movieModel = movie
    }
    
    func setIsFavorited(isFavorited : Bool) {
        btnFavorite.isSelected = isFavorited
    }

}
