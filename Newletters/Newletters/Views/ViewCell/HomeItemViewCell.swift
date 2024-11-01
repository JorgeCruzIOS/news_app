//
//  HomeViewCell.swift
//  News
//
//  Created by Jorge Alfredo Cruz Acuña on 29/10/24.
//

import Foundation
import UIKit

class HomeItemViewCell: UICollectionViewCell, ConfigurableCell{
    typealias DataType = ArticleCacheModel
    
    var imageArticleVM : ImageArticleVM
    var itemCache : ArticleCacheModel?
    let imageLetter = UIImageView()
    let titleLetter = UILabel()
    let categoryLetter = UILabel()
    let timeAgoLetter = UILabel()
    
    override init(frame: CGRect) {
        imageArticleVM = ImageArticleVM()
        super.init(frame: frame)
        imageArticleVM.delegate = self
        buildView()
        buildContraits()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        imageLetter.translatesAutoresizingMaskIntoConstraints = false
        imageLetter.contentMode = .scaleAspectFill
        imageLetter.clipsToBounds = true
        imageLetter.layer.cornerRadius = 8
        titleLetter.translatesAutoresizingMaskIntoConstraints = false
        titleLetter.numberOfLines = 2
        titleLetter.font = .systemFont(ofSize: 18, weight: .bold)
        categoryLetter.translatesAutoresizingMaskIntoConstraints = false
        categoryLetter.font = .systemFont(ofSize: 15, weight: .medium)
        timeAgoLetter.translatesAutoresizingMaskIntoConstraints = false
        timeAgoLetter.font = .systemFont(ofSize: 12, weight: .light)
        contentView.addSubview(imageLetter)
        contentView.addSubview(titleLetter)
        contentView.addSubview(categoryLetter)
        contentView.addSubview(timeAgoLetter)
    }
    
    func buildContraits() {
        NSLayoutConstraint.activate([
            imageLetter.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            imageLetter.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            imageLetter.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            imageLetter.heightAnchor.constraint(equalToConstant: 120),
            
            titleLetter.topAnchor.constraint(equalTo: imageLetter.bottomAnchor),
            titleLetter.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLetter.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            
            categoryLetter.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            categoryLetter.leadingAnchor.constraint(equalTo: titleLetter.leadingAnchor),
            
            timeAgoLetter.centerYAnchor.constraint(equalTo: categoryLetter.centerYAnchor),
            timeAgoLetter.leadingAnchor.constraint(equalTo: categoryLetter.trailingAnchor, constant: 4),
            
            titleLetter.bottomAnchor.constraint(equalTo: categoryLetter.topAnchor),
        ])
    }
    
    func configure(with item: ArticleCacheModel) {
        self.itemCache = item
        titleLetter.text = item.article.title
        timeAgoLetter.text = item.article.publishedDate
        categoryLetter.text = item.article.subsection == "" ? item.article.section : item.article.subsection
        guard let cacheImage = item.articleCacheImage else{
            imageLetter.image = UIImage(named: "noimage")
            guard let urlNoNil = item.article.media.first?.mediaMetadata.last?.url else{ return }
            imageArticleVM.requestImageBy(url: urlNoNil)
            return
        }
        imageLetter.image = UIImage(data: cacheImage)
    }
    
}

extension HomeItemViewCell: ImageArticleVMDelegate{
    func responseImage(data: Data) {
        itemCache?.articleCacheImage = data
        imageLetter.image = UIImage(data: data)
    }
}
