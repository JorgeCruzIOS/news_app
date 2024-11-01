//
//  HomeViewCell.swift
//  News
//
//  Created by Jorge Alfredo Cruz Acuña on 28/10/24.
//

import Foundation
import UIKit

class HomeMoreViewCell:UITableViewCell,ViewDesign{
    var imageArticleVM : ImageArticleVM
    var itemCache : ArticleCacheModel?
    let imageLetter = UIImageView()
    let titleLetter = UILabel()
    let descriptionLetter = UILabel()
    let categoryLetter = UILabel()
    let timeAgoLetter = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        imageArticleVM = ImageArticleVM()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageArticleVM.delegate = self
        buildView()
        buildContraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        selectionStyle = .none
        imageLetter.translatesAutoresizingMaskIntoConstraints = false
        imageLetter.contentMode = .scaleAspectFill
        imageLetter.clipsToBounds = true
        imageLetter.layer.cornerRadius = 8
        titleLetter.translatesAutoresizingMaskIntoConstraints = false
        titleLetter.font = .systemFont(ofSize: 16, weight: .bold)
        titleLetter.numberOfLines = 3
        descriptionLetter.translatesAutoresizingMaskIntoConstraints = false
        descriptionLetter.font = .systemFont(ofSize: 12, weight: .regular)
        descriptionLetter.numberOfLines = 2
        categoryLetter.translatesAutoresizingMaskIntoConstraints = false
        categoryLetter.font = .systemFont(ofSize: 13, weight: .medium)
        timeAgoLetter.translatesAutoresizingMaskIntoConstraints = false
        timeAgoLetter.font = .systemFont(ofSize: 10, weight: .light)
        addSubview(imageLetter)
        addSubview(titleLetter)
        addSubview(descriptionLetter)
        addSubview(categoryLetter)
        addSubview(timeAgoLetter)
    }
    
    func buildContraits() {
        NSLayoutConstraint.activate([
            imageLetter.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            imageLetter.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            imageLetter.heightAnchor.constraint(equalToConstant: 120),
            imageLetter.widthAnchor.constraint(equalToConstant: 150),
            imageLetter.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            titleLetter.topAnchor.constraint(equalTo: imageLetter.topAnchor),
            titleLetter.leadingAnchor.constraint(equalTo: imageLetter.trailingAnchor, constant: 8),
            titleLetter.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            descriptionLetter.topAnchor.constraint(equalTo: titleLetter.bottomAnchor, constant: 2),
            descriptionLetter.leadingAnchor.constraint(equalTo: titleLetter.leadingAnchor),
            descriptionLetter.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            
            categoryLetter.bottomAnchor.constraint(equalTo: imageLetter.bottomAnchor),
            categoryLetter.leadingAnchor.constraint(equalTo: titleLetter.leadingAnchor),
            
            timeAgoLetter.centerYAnchor.constraint(equalTo: categoryLetter.centerYAnchor),
            timeAgoLetter.leadingAnchor.constraint(equalTo: categoryLetter.trailingAnchor, constant: 4),
            
            self.heightAnchor.constraint(equalToConstant: 136)
        ])
    }
    
    func buildData(model: ArticleCacheModel){
        itemCache = model
        titleLetter.text = model.article.title
        descriptionLetter.text = model.article.abstract
        timeAgoLetter.text = model.article.publishedDate
        categoryLetter.text = model.article.subsection == "" ? model.article.section : model.article.subsection
        guard let cacheImage = model.articleCacheImage else{
            imageLetter.image = UIImage(named: "noimage")
            guard let urlNoNil = model.article.media.first?.mediaMetadata.last?.url else{ return }
            imageArticleVM.requestImageBy(url: urlNoNil)
            return
        }
        imageLetter.image = UIImage(data: cacheImage)
    }
}

extension HomeMoreViewCell: ImageArticleVMDelegate{
    func responseImage(data: Data) {
        itemCache?.articleCacheImage = data
        imageLetter.image = UIImage(data: data)
    }
    
}
