//
//  ArticleCacheModel.swift
//  News
//
//  Created by Jorge Alfredo Cruz Acuña on 29/10/24.
//

import Foundation

class ArticleCacheModel{
    var article : ArticleResponse
    var articleCacheImage : Data?
    
    init(article: ArticleResponse, articleCacheImage: Data?) {
        self.article = article
        self.articleCacheImage = articleCacheImage
    }
    
}
