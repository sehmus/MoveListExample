//
//  MovieDefaults.swift
//  MovieList
//
//  Created by Sehmus GOKCE on 10.05.2019.
//  Copyright © 2019 Sehmus GOKCE. All rights reserved.
//

import Foundation
import SwiftyUserDefaults


extension DefaultsKeys {
    static let favoriteMovies = DefaultsKey<FavoriteMoviesModel>("favoriteMovies", defaultValue: FavoriteMoviesModel(movies: []))
}
