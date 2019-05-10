//
//  Consta.swift
//  MovieList
//
//  Created by Sehmus GOKCE on 9.05.2019.
//  Copyright © 2019 Sehmus GOKCE. All rights reserved.
//

import Foundation
import UIKit


public struct Constants {
    public struct Service {
        public static var baseUrl = "https://api.themoviedb.org"
        public static var popularMovies = "/3/movie/popular"
        public static var apiKey : String = "fd2b04342048fa2d5f728561866ad52a"
        public static var imageBaseUrl = "http://image.tmdb.org/t/p/w500"
    }
    
    public struct Color {
        public static let NavBarDefaultColor    = UIColor(rgb: 0xFE5067)
        public static let NavBarDefaultTextColor = UIColor(rgb: 0xFFFFFF)
        public static let NavBarDefaultButtonColor = UIColor(rgb: 0xFFFFFF)
        
        
        static let IndicatorViewBackground = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
    }
    
    public struct Font {
        public static let NavBarDefaultFont    = UIFont.systemFont(ofSize: 20, weight: .medium)
        
    }
    
    public struct MovieCollectionView {
        public static let CellHeight : CGFloat = 150
        public static let CellMargin : CGFloat = 5
    }
    public struct MovieFooterViewCell {
        public static let CellHeight : CGFloat = 50
    }
}


