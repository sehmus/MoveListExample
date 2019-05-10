//
//  FavoriteMoviesModel.swift
//  MovieList
//
//  Created by Sehmus GOKCE on 10.05.2019.
//  Copyright © 2019 Sehmus GOKCE. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

public class FavoriteMoviesModel: Codable, DefaultsSerializable {
    var movies: [MovieModel]
    
    init(movies : [MovieModel]? = nil) {
        self.movies = movies!
    }
}
