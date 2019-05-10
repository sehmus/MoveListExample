//
//  FavoriteService.swift
//  MovieList
//
//  Created by Sehmus GOKCE on 10.05.2019.
//  Copyright © 2019 Sehmus GOKCE. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

//
//
// For the demonstration purposes NSUserDefaults is used in this project.
// For the big and stable projects, Realm or CoreData can be used for performance purposes.
//
//
//

public class FavoriteService {
    static func getFavorites() -> FavoriteMoviesModel? {
        let favoriteMovies = Defaults[.favoriteMovies]
        return favoriteMovies
    }
    
    static func saveFavorites(favoriteMovies : FavoriteMoviesModel){
        Defaults[.favoriteMovies] = favoriteMovies
    }
    
    
    static func addMovieToFavorites(movie : MovieModel) {
        let favoriteMovies = getFavorites()
        guard favoriteMovies != nil else {
            return
        }
        for movieInFavorite in favoriteMovies!.movies
        {
            if movieInFavorite.id == movie.id {
                return
            }
        }
        favoriteMovies?.movies.append(movie)
        
        saveFavorites(favoriteMovies: favoriteMovies!)
    }
    
    static func removeMovieFromFavorites(movie : MovieModel) {
        let favoriteMovies = getFavorites()
        guard favoriteMovies != nil else {
            return
        }
        
        for i in 0..<favoriteMovies!.movies.count {
            if favoriteMovies?.movies[i].id == movie.id {
                favoriteMovies?.movies.remove(at: i)
                break
            }
        }
        saveFavorites(favoriteMovies: favoriteMovies!)
    }
    
    static func isMovieAddedInFavorites(movie : MovieModel) -> Bool {
        let favoriteMovies = getFavorites()
        guard favoriteMovies != nil else {
            return false
        }
        for movieInFavorite in favoriteMovies!.movies
        {
            if movieInFavorite.id == movie.id {
                return true
            }
        }
        return false
    }
}
