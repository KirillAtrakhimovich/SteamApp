import Foundation

class NewsModel {
    var news = [NewsItem]()
}

struct NewsItem {
    let id: Int
    let name: String
    let title: String
    let author: String
    let date: Int
    let contents: String
}
