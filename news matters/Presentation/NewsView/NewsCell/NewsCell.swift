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
            newsImageView.downloaded(from: news?.media.first?.mediaMetadata.first?.url)
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

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String?, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let link = link, let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
