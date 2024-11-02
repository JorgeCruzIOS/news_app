//
//  HomeView.swift
//  News
//
//  Created by Jorge Alfredo Cruz Acuña on 29/10/24.
//

import Foundation
import UIKit

class HomeView: ViewBuilder{
    
    let titleLabel = UILabel()
    let titleFilter = UILabel()
    var listNewDatasource : ArticleVMDatasource
    lazy var listCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let listCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        listCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return listCollectionView
    }()
    init() {
        let model = ArticleVM()
        self.listNewDatasource = model
        super.init(nibName: nil, bundle: nil)
        model.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Notices"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildData()
        buildReloadButton()
    }
    
    override func buildView() {
        super.buildView()
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.register(HomeHeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeHeaderViewCell")
        listCollectionView.register(HorizontalAdapterCell<ArticleCacheModel,HomeItemViewCell>.self, forCellWithReuseIdentifier: "HorizontalAdapterCell")
        view.addSubview(listCollectionView)
    }
    
    override func buildContraits() {
        super.buildContraits()
        NSLayoutConstraint.activate([
            listCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    @objc private func buildData(){
        print("pull")
        self.listNewDatasource.requestSectionBy(typo: 0, range: "1")
        self.listNewDatasource.requestSectionBy(typo: 1, range: "1")
        self.listNewDatasource.requestSectionBy(typo: 2, range: "1")
    }
    
    @objc private func watchMoreAction(_ sender: UIButton){
        navigationCoordinator?.start(controller: HomeMoreView(typo: sender.tag))
    }
    
    private func buildReloadButton() {
        let reloadButton = UIBarButtonItem(image: UIImage(named: "refresh_ic"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(self.reloadAction))
        reloadButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = reloadButton
    }
    
    @objc private func reloadAction() {
        buildData()
    }
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return listNewDatasource.sectionsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalAdapterCell", for: indexPath) as? HorizontalAdapterCell<ArticleCacheModel, HomeItemViewCell>{
            cell.itemSize = CGSize(width: 250, height: 190)
            cell.delegate = self
            cell.tag = indexPath.section
            cell.items = listNewDatasource.sectionList(section: indexPath.section)?.data ?? []
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeHeaderViewCell", for: indexPath) as! HomeHeaderViewCell
            let model = listNewDatasource.sectionList(section: indexPath.section)
            header.titleLabel.text = model?.title
            header.actionButton.tag = indexPath.section
            header.iconImg.image = UIImage(named: model?.image ?? "")
            header.actionButton.addTarget(self, action: #selector(watchMoreAction(_:)), for: .touchUpInside)
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 15, right: 0)
    }
}

extension HomeView : ArticleVMDelegate{
    func responseFailure(message: String) {
        let alertView = FloatingAlertView(message: message)
        alertView.show(in: self.view)
        listCollectionView.reloadData()
    }
    
    func responseItems() {
        listCollectionView.reloadData()
    }
}

extension HomeView: HorizontalAdapterCellDelegate{
    func didSelect(indexPath: IndexPath) {
        navigationCoordinator?.present(controller: DetailNoticeView(itemSelected: indexPath, article: listNewDatasource))
    }
}
