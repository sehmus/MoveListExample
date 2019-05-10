//
//  ViewUtil.swift
//  MovieList
//
//  Created by Sehmus GOKCE on 10.05.2019.
//  Copyright © 2019 Sehmus GOKCE. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

public class ViewUtil : NSObject {
    public static func displayErrorMessage(vc : UIViewController) {
        let alert = UIAlertController(title: "dialog.title.error".localized, message: "dialog.description.error".localized, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "dialog.button.ok".localized, style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    public static func showLoadingView()
    {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(type: .ballClipRotate, backgroundColor: Constants.Color.IndicatorViewBackground), nil)
        
    }
    public static func hideLoadingView()
    {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
}
