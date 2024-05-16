//
//  ViewController.swift
//  mnews
//
//  Created by jevania on 13/05/24.
//

import UIKit

class ViewController: BaseVC {
    
    var newsData: DAONewsBaseClass?
    var latestNewsData: DAONewsBaseClass?
    
    let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    var newsLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(withText: "News", textColor: .systemIndigo, size: 24, weight: .bold, alignment: .left)
        
        return label
    }()
    
    var latestNewsLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(withText: "Latest News", textColor: .systemBlue, size: 20, weight: .bold, alignment: .left)
        label.sizeToFit()
        
        return label
    }()
    
    var allNewsLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.configure(withText: "All News", textColor: .systemBlue, size: 20, weight: .bold, alignment: .left)
        label.sizeToFit()
        
        return label
    }()
    
    var newsImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "newspaper.fill")
        imageView.tintColor = .systemIndigo
        
        return imageView
    }()
    
    private let newsListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    private let latestNewsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 358, height: 256)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private func setupTableView(){
        newsListTableView.delegate = self
        newsListTableView.dataSource = self
    }
    
    private func setupCollectionView(){
        latestNewsCollectionView.delegate = self
        latestNewsCollectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        topStackView.addSubview(newsImageView)
        topStackView.addArrangedSubview(newsLabel)
        view.addSubview(topStackView)
        
        view.addSubview(latestNewsLabel)
        setupCollectionView()
        view.addSubview(latestNewsCollectionView)
        
        view.addSubview(allNewsLabel)
        setupTableView()
        view.addSubview(newsListTableView)
        
        self.getLatestNews()
        self.getNews()
        configureConstraints()
    }
    
    private func configureConstraints(){
        
        let topStackViewConstraints = [
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        
        let newsImageViewConstraints = [
            newsImageView.heightAnchor.constraint(equalToConstant: 30),
            newsImageView.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor),
        ]
        
        let newsLabelConstraints = [
            newsLabel.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.85),
            newsLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 8),
        ]
        
        let latestNewsLabelConstraints = [
            latestNewsLabel.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 16),
            latestNewsLabel.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor),
            latestNewsLabel.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor),
        ]
        
        let latestNewsCollectionViewConstraints = [
            latestNewsCollectionView.topAnchor.constraint(equalTo: latestNewsLabel.bottomAnchor, constant: 8),
            latestNewsCollectionView.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor),
            latestNewsCollectionView.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor),
            latestNewsCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ]
        
        let allNewsLabelConstraints = [
            allNewsLabel.topAnchor.constraint(equalTo: latestNewsCollectionView.bottomAnchor, constant: 16),
            allNewsLabel.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor),
            allNewsLabel.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor),
        ]
        
        let newsListTableViewConstraints = [
            newsListTableView.topAnchor.constraint(equalTo: allNewsLabel.bottomAnchor, constant: 8),
            newsListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            newsListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            newsListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ]
        
        NSLayoutConstraint.activate(topStackViewConstraints)
        NSLayoutConstraint.activate(newsImageViewConstraints)
        NSLayoutConstraint.activate(newsLabelConstraints)
        NSLayoutConstraint.activate(latestNewsLabelConstraints)
        NSLayoutConstraint.activate(latestNewsCollectionViewConstraints)
        NSLayoutConstraint.activate(allNewsLabelConstraints)
        NSLayoutConstraint.activate(newsListTableViewConstraints)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsData?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setup(with: self.newsData?.articles?[indexPath.row])
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.latestNewsData?.articles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as? NewsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(with: self.latestNewsData?.articles?[indexPath.row])
        
        return cell
    }
}

extension ViewController {
    func getLatestNews(){
        self.showSpinner(onView: self.view)
        APIDataSource.getNews(type: APIConstant.LATEST_NEWS_LIST, onSuccess: { response in
            self.removeSpinner()
            self.latestNewsData = response
            self.latestNewsCollectionView.reloadData()
            self.newsListTableView.reloadData()
        }, onFailed: { message  in
            self.removeSpinner()
            self.showAlert(title: "Oh no!", message: message ?? "Failed to load news. Please check your internet connection.")
        })
    }
    
    func getNews(){
        APIDataSource.getNews(type: APIConstant.NEWS_LIST, onSuccess: { response in
            self.newsData = response
            self.latestNewsCollectionView.reloadData()
            self.newsListTableView.reloadData()
        }, onFailed: { message  in
            self.showAlert(title: "Oh no!", message: message ?? "Failed to load news. Please check your internet connection.")
        })
    }
}

