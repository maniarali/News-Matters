//
//  NewsCell.swift
//  news matters
//
//  Created by Muhammad Ali Maniar on 20/11/2021.
//

import UIKit

class NewsCell: UITableViewCell {

    var cardBackgroundView: UIView = {
        let cbgv = UIView()
        cbgv.translatesAutoresizingMaskIntoConstraints = false
        cbgv.backgroundColor = .lightGray
        cbgv.clipsToBounds = true
        return cbgv
    }()
    
    var newsImageView: UIImageView = {
        let niv = UIImageView()
        niv.translatesAutoresizingMaskIntoConstraints = false
        niv.contentMode = .scaleAspectFit
        niv.clipsToBounds = true
        return niv
    }()
    
    var blurView: UIView = {
        let bv = UIView()
        bv.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        bv.translatesAutoresizingMaskIntoConstraints = false
        return bv
    }()
    
    var dataStack: UIStackView = {
        let ds = UIStackView()
        ds.axis = .vertical
        ds.alignment = .center
        ds.distribution = .fill
        ds.spacing = 20
        ds.translatesAutoresizingMaskIntoConstraints = false
        return ds
    }()
    
    var titleLabel: UILabel = {
        let tl = UILabel()
        tl.font = .systemFont(ofSize: 20.0, weight: .heavy)
        tl.textColor = .white
        tl.numberOfLines = 0
        tl.textAlignment = .center
        return tl
    }()
    
    var authorLabel: UILabel = {
        let al = UILabel()
        al.translatesAutoresizingMaskIntoConstraints = false
        al.font = .systemFont(ofSize: 17.0, weight: .medium)
        al.textColor = .white
        al.numberOfLines = 0
        al.textAlignment = .center
        al.adjustsFontSizeToFitWidth = true
        return al
    }()
    
    var dateLabel: UILabel = {
        let dl = UILabel()
        dl.translatesAutoresizingMaskIntoConstraints = false
        dl.font = .systemFont(ofSize: 14.0, weight: .regular)
        dl.textColor = .white
        dl.textAlignment = .center
        return dl
    }()
    
    override func layoutSubviews() {
        cardBackgroundView.createCardView()
    }
    
    func setupView() {
        self.addSubViews()
        self.setupConstriants()
    }
    
    private func addSubViews() {
        self.contentView.addSubview(self.cardBackgroundView)
        self.cardBackgroundView.addSubview(self.newsImageView)
        self.cardBackgroundView.addSubview(self.blurView)
        self.blurView.addSubview(self.dataStack)
        self.dataStack.addArrangedSubview(self.titleLabel)
        self.dataStack.addArrangedSubview(self.authorLabel)
        self.dataStack.addArrangedSubview(self.dateLabel)
    }
    
    private func setupConstriants() {
        setupConstraintsForCardBackgroundView()
        setupConstraintsForNewsImageView()
        setupConstraintsForBlurView()
        setupConstraintsForVerticalStackView()
    }
    
    private func setupConstraintsForCardBackgroundView() {
        self.cardBackgroundView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        self.cardBackgroundView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        self.cardBackgroundView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        self.cardBackgroundView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    private func setupConstraintsForNewsImageView() {
        self.newsImageView.topAnchor.constraint(equalTo: self.cardBackgroundView.topAnchor).isActive = true
        self.newsImageView.leadingAnchor.constraint(equalTo: self.cardBackgroundView.leadingAnchor).isActive = true
        self.newsImageView.trailingAnchor.constraint(equalTo: self.cardBackgroundView.trailingAnchor).isActive = true
        self.newsImageView.bottomAnchor.constraint(equalTo: self.cardBackgroundView.bottomAnchor).isActive = true
    }
    private func setupConstraintsForBlurView() {
        self.blurView.topAnchor.constraint(equalTo: self.cardBackgroundView.topAnchor).isActive = true
        self.blurView.leadingAnchor.constraint(equalTo: self.cardBackgroundView.leadingAnchor).isActive = true
        self.blurView.trailingAnchor.constraint(equalTo: self.cardBackgroundView.trailingAnchor).isActive = true
        self.blurView.bottomAnchor.constraint(equalTo: self.cardBackgroundView.bottomAnchor).isActive = true
    }
    
    private func setupConstraintsForVerticalStackView() {
        self.dataStack.topAnchor.constraint(equalTo: self.blurView.topAnchor, constant: 16).isActive = true
        self.dataStack.leadingAnchor.constraint(equalTo: self.blurView.leadingAnchor, constant: 16).isActive = true
        self.dataStack.trailingAnchor.constraint(equalTo: self.blurView.trailingAnchor, constant: -16).isActive = true
        self.dataStack.bottomAnchor.constraint(equalTo: self.blurView.bottomAnchor, constant: -16).isActive = true
    }
    
    /// When news is set it will set property accordingly.
    var news: News? {
        didSet {
            titleLabel.text = news?.title
            authorLabel.text = news?.byline
            dateLabel.text = news?.publishedDate
            newsImageView.downloaded(from: news?.media.first?.mediaMetadata.first?.url)
        }
    }
    
}
