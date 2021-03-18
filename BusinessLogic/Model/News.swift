//
//  News.swift
//  pecodeNewsApplication
//
//  Created by mozeX on 17.03.2021.
//

import Foundation


struct Response: Codable {
    
    struct News: Codable {
        var title: String?
        var description: String?
        var urlToImage: String?
        var publishedAt: String?
    }
    var articles: [News]
   
}
