//
//  ObjectExtension.swift
//  MovieList
//
//  Created by Sehmus GOKCE on 10.05.2019.
//  Copyright © 2019 Sehmus GOKCE. All rights reserved.
//

import Foundation

public extension NSObject {
    
    var className: String {
        return type(of: self).className
    }
    
    static var className: String {
        return stringFromClass(aClass: self)
    }
    
}

public func stringFromClass(aClass: AnyClass) -> String {
    return NSStringFromClass(aClass).components(separatedBy: ".").last!
}
