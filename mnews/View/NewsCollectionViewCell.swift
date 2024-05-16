//
//  NewsCollectionViewCell.swift
//  mnews
//
//  Created by jevania on 15/05/24.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewsCollectionViewCell"
    
    let verStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    let textHorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.configure(withText: nil, textColor: .black, size: 18, weight: .semibold, alignment: .left)
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
        
        self.image.setLoad(isLoad: true, style: .large)
        self.image.sd_setImage(with: URL(string: article?.urlToImage ?? "")) { (img, err, cache, url) in
            self.image.setLoad(isLoad: false, style: .large)
            if err == nil {
                self.image.image = img
            } else {
                self.image.image = UIImage(systemName: "photo")
                self.image.tintColor = .gray
                self.image.backgroundColor = .lightGray
                self.image.contentMode = .scaleAspectFit
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContentView()
        
        verStackView.addArrangedSubview(image)
        verStackView.addArrangedSubview(title)
        
        textHorStackView.addArrangedSubview(author)
        textHorStackView.addArrangedSubview(publicationTime)
        verStackView.addArrangedSubview(textHorStackView)
        
        contentView.addSubview(verStackView)
        
        configureConstraints()
    }
    
    private func configureContentView(){
        contentView.backgroundColor = .white
    }
    
    private func configureConstraints() {
        let verStackViewConstraints = [
            verStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            verStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            verStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            verStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        let imageConstraints = [
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: verStackView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: verStackView.trailingAnchor),
            image.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7)
        ]
        
        let textHorStackViewConstraints = [
            textHorStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(verStackViewConstraints)
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(textHorStackViewConstraints)
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}



