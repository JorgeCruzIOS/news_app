//
//  ArticleListCache.swift
//  News
//
//  Created by Jorge Alfredo Cruz Acuña on 31/10/24.
//

import Foundation
import RealmSwift

class ArticleListCache: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var time: String = ""
    @objc dynamic var list: Data?
}
