import Foundation

class NewsModel {
    private let news: [NewsItem]
    var filteredNews: [NewsItem]
    
    init(news: [NewsItem], filteredNews: [NewsItem]) {
        self.news = news
        self.filteredNews = filteredNews
    }
    
    func filterNews(with filteredIds: [Int]) {
        var newArr: [NewsItem] = []
        for id in filteredIds {
            newArr += news.filter { $0.gameId == id }
        }
        filteredNews = newArr
    }
}

struct NewsItem {
    let gameId: Int
    let gameName: String
    let title: String
    let author: String
    let date: Int
    let contents: String
}
