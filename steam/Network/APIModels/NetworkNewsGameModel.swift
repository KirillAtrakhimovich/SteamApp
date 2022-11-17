import Foundation

struct News: Codable{
    let appnews: Items
}

struct Items: Codable{
    let appid: Int
    let newsitems: [Info]
}

struct Info: Codable{
    let title: String
    let author: String
    let contents: String
    let date: Int
    let appid: Int
}
