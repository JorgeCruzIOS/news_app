//
//  HomeView.swift
//  News
//
//  Created by Jorge Alfredo Cruz Acuña on 28/10/24.
//

import Foundation
import UIKit

class HomeMoreView: ViewBuilder{
    var listNewDatasource : ArticleVMDatasource
    let titleLabel = UILabel()
    let titleFilter = UILabel()
    let listTableView = UITableView()
    let typo : Int
    init(typo: Int) {
        self.typo = typo
        let model = ArticleVM()
        self.listNewDatasource = model
        super.init(nibName: nil, bundle: nil)
        model.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildData()
        buildReloadButton()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "More notices"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func buildView() {
        super.buildView()
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(HomeMoreViewCell.self, forCellReuseIdentifier: "HomeViewCell")
        
        view.addSubview(listTableView)
    }
    
    override func buildContraits() {
        super.buildContraits()
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func buildReloadButton() {
        let reloadButton = UIBarButtonItem(image: UIImage(named: "refresh_ic"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(self.reloadAction))
        reloadButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = reloadButton
    }
    
    @objc func reloadAction() {
        buildData()
    }
    
    private func buildData(){
        self.listNewDatasource.requestSectionBy(typo: typo, range: "30")
    }
}


extension HomeMoreView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNewDatasource.sectionList(section: typo)?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeViewCell", for: indexPath) as? HomeMoreViewCell{
            cell.buildData(model: listNewDatasource.itemBySection(section: typo, item: indexPath.row))
            return cell
        }
        return UITableViewCell(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationCoordinator?.present(controller: DetailNoticeView(itemSelected: indexPath, article: listNewDatasource))
    }
}

extension HomeMoreView: ArticleVMDelegate{
    func responseFailure(message: String) {
        let alertView = FloatingAlertView(message: message)
        alertView.show(in: self.view)
        listTableView.reloadData()
    }
    
    func responseItems() {
        listTableView.reloadData()
    }
}
