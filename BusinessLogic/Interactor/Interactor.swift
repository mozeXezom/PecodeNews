//
//  Interactor.swift
//  pecodeNewsApplication
//
//  Created by mozeX on 17.03.2021.
//

import Foundation


class Interactor {
    
    // MARK: - Public
    var errorMessage = ""
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
        
    
    // MARK: - Class funcs
    class func getLentaFromApi(completion: @escaping ([Response.News]) -> Void) {
        
        let session = URLSession(configuration: .default)
        let url = AppDelegate.baseUrl
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            guard let jsonData = data else { return }
            do {
                let news = try JSONDecoder().decode(Response.self, from: jsonData)
                DispatchQueue.main.async {
                    completion(news.articles)
                }
            } catch {
                print(error)
            }
        })
    task.resume()
   }
}
