//
//  NewsArrayModel.swift
//  steam
//
//  Created by Kirill Atrakhimovich on 11.11.22.
//

import Foundation
import UIKit

class NewsArrayModel {
    let news: [NewsItem]
    var filteredNews: [NewsItem]

    init(news: [NewsItem], filteredNews: [NewsItem]) {
        self.news = news
        self.filteredNews = filteredNews
    }
    
    func filterNews(with ids: [Int]) {
        var newsIds = news.map {$0.id}
        if newsIds == ids {
            filteredNews = news
        }
        else {
            filteredNews = news.filter { $0.id == ids }
          
        }
    }
}
