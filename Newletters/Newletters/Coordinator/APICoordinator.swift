//
//  APICoordinator.swift
//  News
//
//  Created by Jorge Alfredo Cruz Acuña on 28/10/24.
//

import Foundation

class APICoordinator {
    
    func request<T: Decodable>(url: String,
                               completion: @escaping (BasicResponse<T>) -> Void,
                               failure: @escaping (Error) -> Void) {
        guard NetwoorkManager.shared.isConnected == true else{
            failure(NSError(domain: "No Internet Connection", code: 0, userInfo: nil))
            return
        }
        guard let urlCompleate = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/" + url + ".json") else {
            DispatchQueue.main.async {
                failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            }
            return
        }
        
        var components = URLComponents(url: urlCompleate, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "api-key", value: "qTl6HA9lEk9bHwEMNSrdjRAceMnSqQEZ")]
        
        guard let finalURL = components?.url else {
            DispatchQueue.main.async {
                failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No data", code: 0, userInfo: nil)
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(BasicResponse<T>.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            } catch {
                DispatchQueue.main.async {
                    failure(error)
                }
            }
        }
        task.resume()
    }
    
    func requestImage(from urlString: String,
                      completion: @escaping (Data) -> Void,
                      failure: @escaping (Error) -> Void) {
        guard NetwoorkManager.shared.isConnected == true else{
            failure(NSError(domain: "No Internet Connection", code: 0, userInfo: nil))
            return
        }
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            guard let data = data else {
                let error = NSError(domain: "No data", code: 0, userInfo: nil)
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(data)
            }
        }.resume()
    }
}
