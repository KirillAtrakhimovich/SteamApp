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
    
    func filterGames(with text: String) {
        if text == "" {
            filteredGames = games
        }
        else {
            filteredGames = games.filter { $0.name.contains(text) }
            filteredGames = games.filter { $0.name.localizedCaseInsensitiveContains(text) }
        }
    }
}
