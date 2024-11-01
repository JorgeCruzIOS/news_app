//
//  ImageArticleVM.swift
//  News
//
//  Created by Jorge Alfredo Cruz Acuña on 29/10/24.
//

import Foundation

protocol ImageArticleVMDelegate: AnyObject{
    func responseImage(data: Data)
}

protocol ImageArticleVMDataSource: AnyObject{
    func requestImageBy(url: String)
}
class ImageArticleVM: ImageArticleVMDataSource{
    weak var delegate: ImageArticleVMDelegate?
    var apiCoordinator : APICoordinator
    
    init(delegate: ImageArticleVMDelegate? = nil) {
        self.delegate = delegate
        self.apiCoordinator = APICoordinator()
    }
    
    func requestImageBy(url: String) {
        apiCoordinator.requestImage(from: url) { [weak self] responseData in
            self?.delegate?.responseImage(data: responseData)
        } failure: { error in
        }

    }
    
    
}
