//
//  ListNewModel.swift
//  News
//
//  Created by Jorge Alfredo Cruz Acuña on 28/10/24.
//

import Foundation


protocol ArticleVMDelegate: AnyObject{
    func responseItems()
    func responseFailure(message: String)
}

protocol ArticleVMDatasource: AnyObject{
    // var sections: [ArticleSectionModel] {get set}
    func sectionsCount()->Int
    func itemsCount(section: Int)->Int
    func sectionList(section: Int)-> ArticleSectionModel
    func itemBySection(section: Int, item: Int)-> ArticleCacheModel
    func requestSectionBy(typo: Int, range: String)
}

class ArticleVM: ArticleVMDatasource{
    private var apiCoordinator : APICoordinator
    private var db : DatabaseCoordinator
    private var sections: [ArticleSectionModel]
    weak var delegate: ArticleVMDelegate?
    
    init() {
        self.apiCoordinator = APICoordinator()
        self.db = DatabaseCoordinator()
        self.sections = [
            ArticleSectionModel(title: "Latest Viewed", identifier: "viewed", image: "visibility_ic"),
            ArticleSectionModel(title: "Latest Shared", identifier: "shared", image: "share_ic"),
            ArticleSectionModel(title: "Latest Emailed", identifier: "emailed", image: "send_ic")
        ]
    }
    
    func sectionsCount() -> Int {
        return sections.count
    }
    
    func itemsCount(section: Int) -> Int {
        return sections[section].data.count
    }
    
    func sectionList(section: Int) -> ArticleSectionModel {
        return sections[section]
    }
    
    func itemBySection(section: Int, item: Int) -> ArticleCacheModel {
        return sections[section].data[item]
    }
    
    func requestSectionBy(typo: Int, range: String){
        apiCoordinator.request(url: sections[typo].identifier + "/" + range) { [weak self] (apiResponse: BasicResponse<ArticleResponse>) in
            for object in apiResponse.results{
                self?.sections[typo].data.append(ArticleCacheModel(article: object, articleCacheImage: nil))
            }
            let encoder = JSONEncoder()
            do {
                let articlelistcache = ArticleListCache()
                articlelistcache.identifier = self?.sections[typo].identifier ?? ""
                articlelistcache.time = range
                let data = try encoder.encode(apiResponse)
                articlelistcache.list = data
                self?.db.updateOnDatabase(params: [FilterModel(key: "identifier", value: self?.sections[typo].identifier ?? ""), FilterModel(key: "time", value: range)], with: articlelistcache) { response in
                    self?.delegate?.responseItems()
                }
            } catch {
                self?.sections[typo].data = []
                self?.delegate?.responseFailure(message: NetwoorkError.EmptyData.rawValue)
            }
        } failure: { [weak self] error in
            self?.db.fetchOnDatabase(params: [FilterModel(key: "identifier", value: self?.sections[typo].identifier ?? ""), FilterModel(key: "time", value: range)], ArticleListCache.self, completation: { response in
                do {
                    let decodedData = try JSONDecoder().decode(BasicResponse<ArticleResponse>.self, from: response.list ?? Data())
                    for object in decodedData.results{
                        self?.sections[typo].data.append(ArticleCacheModel(article: object, articleCacheImage: nil))
                        self?.delegate?.responseItems()
                        self?.delegate?.responseFailure(message: error.localizedDescription)
                    }
                }
                catch {
                    self?.sections[typo].data = []
                    self?.delegate?.responseFailure(message: NetwoorkError.InternalError.rawValue)
                }
            }, failure: {
                self?.sections[typo].data = []
                self?.delegate?.responseFailure(message: NetwoorkError.EmptyData.rawValue)
            })
        }
        
    }
}
