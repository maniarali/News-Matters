//
//  NewsCell.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func layoutSubviews() {
        cardBackgroundView.createCardView()
    }
    
    var news: News? {
        didSet {
            titleLabel.text = news?.title
            authorLabel.text = news?.byline
            dateLabel.text = news?.publishedDate
        }
    }
    
}

extension UIView {
    func createCardView() {
        layer.cornerRadius = 20.0
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.7
    }
}
