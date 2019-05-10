//
//  BaseViewController.swift
//  MovieList
//
//  Created by Sehmus GOKCE on 9.05.2019.
//  Copyright © 2019 Sehmus GOKCE. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //Nav Bar Properties
    var navBarLeftBarButtonTypes: [NavBarViewType] = []
    var navBarRightBarButtonTypes: [NavBarViewType] = []
    var navBarTitle: String? = nil
    var navBarTheme: NavBarTheme = .defaultTheme

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .black
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let title = navBarTitle{
            NavigationBarUtils.setupNavigationBar(vc: self, theme: navBarTheme, title: title, leftViewTypes: navBarLeftBarButtonTypes, rightViewTypes: navBarRightBarButtonTypes, leftViewSelector: #selector(onClickLeftNavBarButton(_:)), rightViewSelector: #selector(onClickRightNavBarButton(_:)))
        }else{
            NavigationBarUtils.setupNavigationBar(vc: self, theme: navBarTheme, leftViewTypes: navBarLeftBarButtonTypes, rightViewTypes: navBarRightBarButtonTypes, leftViewSelector: #selector(onClickLeftNavBarButton(_:)), rightViewSelector: #selector(onClickRightNavBarButton(_:)))
        }
    }
    

    @objc func onClickLeftNavBarButton(_ sender:UIButton){
        //Left Buttons Clicked
        if sender.tag == NavBarButtonTag.back.rawValue  {
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    @objc func onClickRightNavBarButton(_ sender:UIButton){
        //Right Buttons Clicked for the Future.
    }

}
