//
//  ArticleSectionModel.swift
//  News
//
//  Created by Jorge Alfredo Cruz Acuña on 29/10/24.
//

import Foundation

struct ArticleSectionModel{
    let title : String
    let identifier: String
    let image: String
    var data: [ArticleCacheModel] = [ArticleCacheModel]()
}
