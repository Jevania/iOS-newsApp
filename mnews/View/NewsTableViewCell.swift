//
//  NewsTableViewCell.swift
//  mnews
//
//  Created by jevania on 13/05/24.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    private let horStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let textVerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let textHorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.configure(withText: nil, textColor: .black, size: 14, weight: .semibold, alignment: .left)
        label.sizeToFit()
        
        return label
    }()
    
    private var author: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.configure(withText: nil, textColor: .darkGray, size: 12, weight: .regular, alignment: .left)
        label.sizeToFit()
        
        return label
    }()
    
    private var publicationTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.configure(withText: nil, textColor: .darkGray, size: 12, weight: .regular, alignment: .left)
        label.sizeToFit()
        
        return label
    }()
    
    func setup(with article: Article?) {
        title.text = article?.title
        author.attributedText = NSMutableAttributedString.attributedText(icon: "person", text: article?.author ?? "")
        publicationTime.attributedText = NSMutableAttributedString.attributedText(icon: "calendar", text: DateFormatter.formattedDate(article?.publishedAt ?? "") ?? "")
        
        image.setLoad(isLoad: true, style: .large)
        image.sd_setImage(with: URL(string: article?.urlToImage ?? "")) { (img, err, cache, url) in
            self.image.setLoad(isLoad: false, style: .large)
            if err == nil {
                self.image.image = img
            } else {
                self.image.image = nil
                self.image.image = UIImage(systemName: "photo")
                self.image.tintColor = .gray
                self.image.backgroundColor = .lightGray
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContentView()
        
        textHorStackView.addArrangedSubview(author)
        textHorStackView.addArrangedSubview(publicationTime)
        
        textVerStackView.addArrangedSubview(title)
        textVerStackView.addArrangedSubview(textHorStackView)
        
        horStackView.addArrangedSubview(image)
        horStackView.addArrangedSubview(textVerStackView)
        
        contentView.addSubview(horStackView)
        
        configureConstraints()
    }
    
    private func configureContentView() {
        contentView.backgroundColor = .white
    }
    
    private func configureConstraints() {
        let horStackViewConstraints = [
            horStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            horStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            horStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        let imageConstraints = [
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: textVerStackView.leadingAnchor, constant: -8),
            image.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3)
        ]
        
        let textVerStackViewConstraints = [
            textVerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            textVerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textVerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ]
        
        let textHorStackViewConstraints = [
            textHorStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(horStackViewConstraints)
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(textVerStackViewConstraints)
        NSLayoutConstraint.activate(textHorStackViewConstraints)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

