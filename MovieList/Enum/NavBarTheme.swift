//
//  NavBarTheme.swift
//  MovieList
//
//  Created by Sehmus GOKCE on 10.05.2019.
//  Copyright © 2019 Sehmus GOKCE. All rights reserved.
//

import Foundation
import UIKit

public enum NavBarTheme{
    case defaultTheme, black
    
    
    var textColor: UIColor{
        
        switch self {
        case .defaultTheme:
            return Constants.Color.NavBarDefaultTextColor
        case .black:
            return UIColor.black
        }
    }
    
    var backgroundColor: UIColor{
        
        switch self {
        case .defaultTheme:
            return Constants.Color.NavBarDefaultColor
        case .black:
            return Constants.Color.NavBarDefaultColor
        }
    }
    
    var isButtomShadowEnabled: Bool{
        
        switch self {
        case .defaultTheme:
            return true
        case .black:
            return false
        }
    }
    
    var iconColor: String{
        
        switch self {
        case .defaultTheme:
            return "_white"
        case .black:
            return "_orange"
        }
    }
    
    var font : UIFont {
        switch self {
        case .defaultTheme:
            return Constants.Font.NavBarDefaultFont
        default:
            return Constants.Font.NavBarDefaultFont
        }
    }
    
    var isTranslucent: Bool{
        
        switch self {
        case .defaultTheme:
            return false
        case .black:
            return true
        }
    }
}
