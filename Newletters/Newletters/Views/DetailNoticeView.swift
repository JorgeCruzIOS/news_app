//
//  DetailNoticeView.swift
//  News
//
//  Created by Jorge Alfredo Cruz Acuña on 30/10/24.
//

import Foundation
import UIKit

class DetailNoticeView: ViewBuilder{
    
    private let itemSelected : IndexPath
    private weak var articleVM: ArticleVMDatasource?
    private let boxContainer = UIStackView()
    private let scrollContainer = UIScrollView()
    private let backButton = UIButton()
    private let backViewContainer = UIView()
    
    init(itemSelected: IndexPath, article:ArticleVMDatasource) {
        self.itemSelected = itemSelected
        self.articleVM = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Detail"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func buildView() {
        super.buildView()
        boxContainer.translatesAutoresizingMaskIntoConstraints = false
        boxContainer.axis = .vertical
        boxContainer.spacing = 10
        scrollContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollContainer.delegate = self
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(named:"arrowback_ic"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        backViewContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollContainer)
        view.addSubview(backViewContainer)
        backViewContainer.addSubview(backButton)
        scrollContainer.addSubview(boxContainer)
        buildHeaderBox()
        buildTitleBox()
        buildInformationBox()
    }
    
    override func buildContraits() {
        super.buildContraits()
        NSLayoutConstraint.activate([
            backViewContainer.topAnchor.constraint(equalTo: view.topAnchor),
            backViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backViewContainer.heightAnchor.constraint(equalToConstant: 98),
            
            backButton.heightAnchor.constraint(equalToConstant: 46),
            backButton.widthAnchor.constraint(equalToConstant: 46),
            backButton.bottomAnchor.constraint(equalTo: backViewContainer.bottomAnchor),
            backButton.leadingAnchor.constraint(equalTo: backViewContainer.leadingAnchor, constant: 8),
            
            scrollContainer.topAnchor.constraint(equalTo: view.topAnchor),
            scrollContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            boxContainer.topAnchor.constraint(equalTo: scrollContainer.topAnchor),
            boxContainer.leadingAnchor.constraint(equalTo: scrollContainer.leadingAnchor),
            boxContainer.trailingAnchor.constraint(equalTo: scrollContainer.trailingAnchor),
            boxContainer.bottomAnchor.constraint(equalTo: scrollContainer.bottomAnchor),
            boxContainer.centerXAnchor.constraint(equalTo: scrollContainer.centerXAnchor),
        ])
    }
    
    @objc private func backAction(){
        self.dismiss(animated: true)
    }
    
    private func buildHeaderBox(){
        guard let model = articleVM?.itemBySection(section: itemSelected.section, item: itemSelected.row) else{return}
        let imageTop = UIImageView()
        let maskTitle = UIView()
        let tagNotici = UIView()
        let titleNotici = UILabel()
        let datePublish = UILabel()
        let box = UIView()
        
        box.translatesAutoresizingMaskIntoConstraints = false
        maskTitle.translatesAutoresizingMaskIntoConstraints = false
        imageTop.translatesAutoresizingMaskIntoConstraints = false
        tagNotici.translatesAutoresizingMaskIntoConstraints = false
        titleNotici.translatesAutoresizingMaskIntoConstraints = false
        datePublish.translatesAutoresizingMaskIntoConstraints = false
        
        imageTop.image = UIImage(data: model.articleCacheImage ?? Data())
        imageTop.contentMode = .scaleAspectFill
        imageTop.clipsToBounds = true
        titleNotici.font = .systemFont(ofSize: 16, weight: .bold)
        titleNotici.numberOfLines = 0
        titleNotici.text = model.article.byline
        titleNotici.textColor = .white
        datePublish.font = .systemFont(ofSize: 14, weight: .semibold)
        datePublish.text = model.article.publishedDate
        datePublish.textColor = .white
        maskTitle.backgroundColor = .black.withAlphaComponent(0.25)
        
        box.addSubview(imageTop)
        box.addSubview(maskTitle)
        box.addSubview(tagNotici)
        box.addSubview(titleNotici)
        box.addSubview(datePublish)
        boxContainer.addArrangedSubview(box)
        NSLayoutConstraint.activate([
            imageTop.topAnchor.constraint(equalTo: box.topAnchor),
            imageTop.leadingAnchor.constraint(equalTo: box.leadingAnchor),
            imageTop.trailingAnchor.constraint(equalTo: box.trailingAnchor),
            imageTop.bottomAnchor.constraint(equalTo: box.bottomAnchor),
            imageTop.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.35),
            
            maskTitle.topAnchor.constraint(equalTo: imageTop.topAnchor),
            maskTitle.leadingAnchor.constraint(equalTo: imageTop.leadingAnchor),
            maskTitle.trailingAnchor.constraint(equalTo: imageTop.trailingAnchor),
            maskTitle.bottomAnchor.constraint(equalTo: imageTop.bottomAnchor),
            
            datePublish.bottomAnchor.constraint(equalTo: imageTop.bottomAnchor, constant: -8),
            datePublish.leadingAnchor.constraint(equalTo: imageTop.leadingAnchor, constant: 8),
            
            titleNotici.bottomAnchor.constraint(equalTo: datePublish.topAnchor, constant: -8),
            titleNotici.leadingAnchor.constraint(equalTo: imageTop.leadingAnchor, constant: 8),
            titleNotici.widthAnchor.constraint(equalTo: imageTop.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func buildTitleBox(){
        guard let model = articleVM?.itemBySection(section: itemSelected.section, item: itemSelected.row) else{return}
        let box = UIView()
        box.translatesAutoresizingMaskIntoConstraints = false
        let bytitle = UILabel()
        bytitle.translatesAutoresizingMaskIntoConstraints = false
        bytitle.font = .systemFont(ofSize: 32, weight: .bold)
        bytitle.numberOfLines = 0
        bytitle.text = model.article.title
        box.addSubview(bytitle)
        NSLayoutConstraint.activate([
            bytitle.topAnchor.constraint(equalTo: box.topAnchor),
            bytitle.leadingAnchor.constraint(equalTo: box.leadingAnchor, constant: 16),
            bytitle.trailingAnchor.constraint(equalTo: box.trailingAnchor),
            bytitle.bottomAnchor.constraint(equalTo: box.bottomAnchor)
        ])
        boxContainer.addArrangedSubview(box)
    }
    
    private func buildInformationBox(){
        guard let model = articleVM?.itemBySection(section: itemSelected.section, item: itemSelected.row) else{return}
        let extratitle = model.article.media.map({ "\n\n" + ($0.caption ?? "")}).joined()
        let box = UIView()
        box.translatesAutoresizingMaskIntoConstraints = false
        let bytitle = UILabel()
        bytitle.translatesAutoresizingMaskIntoConstraints = false
        bytitle.font = .systemFont(ofSize: 20, weight: .light)
        bytitle.text = model.article.abstract + extratitle
        bytitle.numberOfLines = 0
        box.addSubview(bytitle)
        NSLayoutConstraint.activate([
            bytitle.topAnchor.constraint(equalTo: box.topAnchor),
            bytitle.leadingAnchor.constraint(equalTo: box.leadingAnchor, constant: 16),
            bytitle.trailingAnchor.constraint(equalTo: box.trailingAnchor),
            bytitle.bottomAnchor.constraint(equalTo: box.bottomAnchor)
        ])
        boxContainer.addArrangedSubview(box)
    }
}

extension DetailNoticeView: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollViewDidScroll")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDecelerating")
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print("scrollViewDidScrollToTop")
    }
    
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("scrollViewDidEndScrollingAnimation")
    }
}
