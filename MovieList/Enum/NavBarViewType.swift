//
//  NavbarViewType.swift
//  MovieList
//
//  Created by Sehmus GOKCE on 10.05.2019.
//  Copyright © 2019 Sehmus GOKCE. All rights reserved.
//

import Foundation

public enum NavBarViewType: String {
    case back = "navbar_back"
    case search = "nav_bar_search"
    case multiselect = "navbar_multiselect"
    case text
    case none
    
    public func getTag() -> NavBarButtonTag {
        if self == .back {
            return NavBarButtonTag.back
        }else if self == .search {
            return NavBarButtonTag.search
        }
        else if self == .multiselect {
            return NavBarButtonTag.multiselect
        }
        else{
            return NavBarButtonTag.none
        }
    }
}

public enum NavBarButtonTag: Int {
    case back = 0,search, multiselect, none
    
}
