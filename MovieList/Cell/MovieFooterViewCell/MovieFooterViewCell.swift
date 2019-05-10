//
//  MovieFooterViewCell.swift
//  MovieList
//
//  Created by Sehmus GOKCE on 10.05.2019.
//  Copyright © 2019 Sehmus GOKCE. All rights reserved.
//

import UIKit

protocol MovieFooterViewCellDelegate {
    func loadMoreTouched(button : UIButton)
}

class MovieFooterViewCell: UICollectionReusableView {

    var delegate : MovieFooterViewCellDelegate? = nil
    @IBOutlet weak var btnLoadMore: UIButton!
    
    @IBAction func loadMoreTouched(_ sender: Any) {
        guard delegate != nil else {
            return
        }
        delegate?.loadMoreTouched(button: btnLoadMore)
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnLoadMore.setTitle("movielist.list.loadmore".localized, for: .normal)
    }
    
}
