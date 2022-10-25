import Foundation

struct AppList: Codable {
    let applist: AllApps
}

struct AllApps: Codable {
    let apps: [Game]
}

struct Game: Codable{
    let appid: Int
    let name: String
}
