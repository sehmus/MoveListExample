//
//  NavigationBarUtils.swift
//  MovieList
//
//  Created by Sehmus GOKCE on 10.05.2019.
//  Copyright © 2019 Sehmus GOKCE. All rights reserved.
//

import UIKit

open class NavigationBarUtils {
    
    public static func setupNavigationBar(vc: UIViewController, theme: NavBarTheme, title: String? = nil, leftViewTypes: [NavBarViewType], rightViewTypes: [NavBarViewType], leftViewSelector: Selector, rightViewSelector: Selector){
        
        
        // Creating Left Views
        var leftBarButtonItems:[UIBarButtonItem] = [UIBarButtonItem]()
        for leftViewType in leftViewTypes {
            let imageName = leftViewType.rawValue + theme.iconColor
            let leftView: UIView = createLeftBarButtonView(vc: vc, imageName: imageName, tag: leftViewType.getTag().rawValue, selector: leftViewSelector)
            let leftBarButtonItem = UIBarButtonItem(customView: leftView)
            leftBarButtonItems.append(leftBarButtonItem)
        }
        vc.navigationItem.leftBarButtonItems = leftBarButtonItems
        
        //Creating Right Views
        var rightBarButtonItems:[UIBarButtonItem] = [UIBarButtonItem]()
        for rightViewType in rightViewTypes {
            let imageName = rightViewType.rawValue + theme.iconColor
            let rightView: UIView = createRightBarButtonView(vc: vc, imageName: imageName, tag: rightViewType.getTag().rawValue, selector: rightViewSelector)
            let rightBarButtonItem = UIBarButtonItem(customView: rightView)
            rightBarButtonItems.append(rightBarButtonItem)
        }
        vc.navigationItem.rightBarButtonItems = rightBarButtonItems
        
        if let navBarTitle = title{
            vc.navigationItem.title = navBarTitle
        }else{
            vc.navigationItem.title = ""
        }
        
        // set nav bar text color
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: theme.textColor,
                                       NSAttributedString.Key.font: theme.font]
        vc.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        
        //Clear default navigation bar apperance
        vc.navigationController?.navigationBar.backgroundColor = theme.backgroundColor
        vc.navigationController?.navigationBar.barTintColor = theme.backgroundColor
        
        if theme.isButtomShadowEnabled == false{
            vc.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
            //vc.navigationController?.navigationBar.setShadow(shadowHeight: 10)
        }
        
        if theme.isTranslucent == true{
            vc.navigationController?.navigationBar.isTranslucent = theme.isTranslucent
            vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            vc.navigationController?.navigationBar.shadowImage = UIImage() //remove pesky 1 pixel line
        }
        
        vc.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    
    public static func createRightBarButtonView(vc: UIViewController, imageName: String, tag: Int,selector: Selector) -> UIView{
        let rightbutton = UIButton(type: .custom)
        rightbutton.setImage(UIImage(named: imageName, in: Bundle(for: NavigationBarUtils.self), compatibleWith: nil), for: .normal)
        rightbutton.addTarget(vc, action: selector, for: .touchUpInside)
        rightbutton.tag = tag
        rightbutton.frame.size.width = 30
        rightbutton.frame.size.height = 30
        
        return rightbutton
        
    }
    
    public static func createLeftBarButtonView(vc: UIViewController, imageName: String, tag: Int, selector: Selector) -> UIView{
        let leftbutton = UIButton(type: .custom)
        
        leftbutton.setImage(UIImage(named: imageName, in: Bundle(for: NavigationBarUtils.self), compatibleWith: nil), for: .normal)
        leftbutton.addTarget(vc, action: selector, for: .touchUpInside)
        leftbutton.tag = tag
        leftbutton.frame.size.width = 30
        leftbutton.frame.size.height = 30
        
        if imageName == "back_icon" {
            leftbutton.frame.origin.x = -12
        }
        
        let leftButtonView = UIView()
        leftButtonView.frame = leftbutton.frame
        leftButtonView.addSubview(leftbutton)
        
        return leftButtonView
    }
    
    public static func createBarButtonItem(vc: UIViewController, iconName: String, selector: Selector? = nil) -> UIBarButtonItem {
        let barButton = UIButton(type: .custom)
        barButton.frame = CGRect(x: 0, y: 0, width: 32, height: 40)
        barButton.setImage(UIImage(named: iconName), for: .normal)
        if selector != nil {
            barButton.addTarget(vc, action: selector!, for: .touchUpInside)
        }
        return UIBarButtonItem(customView: barButton)
    }
}
