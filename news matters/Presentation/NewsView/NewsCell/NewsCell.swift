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
        addSubViews()
        setupConstriants()
    }
    
    private func addSubViews() {
        contentView.addSubview(cardBackgroundView)
        cardBackgroundView.addSubview(newsImageView)
        cardBackgroundView.addSubview(blurView)
        blurView.addSubview(dataStack)
        dataStack.addArrangedSubview(titleLabel)
        dataStack.addArrangedSubview(authorLabel)
        dataStack.addArrangedSubview(dateLabel)
    }
    
    private func setupConstriants() {
        setupConstraintsForCardBackgroundView()
        setupConstraintsForNewsImageView()
        setupConstraintsForBlurView()
        setupConstraintsForVerticalStackView()
    }
    
    private func setupConstraintsForCardBackgroundView() {
        cardBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        cardBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        cardBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        cardBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    private func setupConstraintsForNewsImageView() {
        newsImageView.topAnchor.constraint(equalTo: cardBackgroundView.topAnchor).isActive = true
        newsImageView.leadingAnchor.constraint(equalTo: cardBackgroundView.leadingAnchor).isActive = true
        newsImageView.trailingAnchor.constraint(equalTo: cardBackgroundView.trailingAnchor).isActive = true
        newsImageView.bottomAnchor.constraint(equalTo: cardBackgroundView.bottomAnchor).isActive = true
    }
    private func setupConstraintsForBlurView() {
        blurView.topAnchor.constraint(equalTo: cardBackgroundView.topAnchor).isActive = true
        blurView.leadingAnchor.constraint(equalTo: cardBackgroundView.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: cardBackgroundView.trailingAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: cardBackgroundView.bottomAnchor).isActive = true
    }
    
    private func setupConstraintsForVerticalStackView() {
        dataStack.topAnchor.constraint(equalTo: blurView.topAnchor, constant: 16).isActive = true
        dataStack.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 16).isActive = true
        dataStack.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -16).isActive = true
        dataStack.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -16).isActive = true
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
