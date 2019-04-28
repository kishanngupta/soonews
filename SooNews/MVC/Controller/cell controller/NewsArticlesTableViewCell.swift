//
//  NewsArticlesTableViewCell.swift
//  SooNews
//
//  Created by Kishan Gupta on 26/04/19.
//  Copyright © 2019 KishanGupta. All rights reserved.
//

import UIKit

class NewsArticlesTableViewCell: UITableViewCell {
    
    //MARK: - OUTLET DECLARATIONS
    @IBOutlet weak var articleThumbnailImageView: UIImageView!
    @IBOutlet weak var backgroundViewForTitle: UIView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var baseView: UIView!
    // MARK: - LIFE CYCLE METHOD
    override func awakeFromNib() {
        super.awakeFromNib()
        initialiseView()
    }
    
    //MARK: - CLASS BEHAVIOR
    func initialiseView(){
        baseView.layer.cornerRadius = 10
        articleThumbnailImageView.layer.cornerRadius = 10
        articleThumbnailImageView.clipsToBounds = true
        articleTitleLabel.textColor = UIColor.white
        articleTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        sourceNameLabel.textColor = UIColor.white
        sourceNameLabel.font = UIFont.italicSystemFont(ofSize: 10)
        backgroundViewForTitle.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
}
