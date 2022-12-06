import Foundation

struct GameDetailsModel {
    let headerImage: String
    let name: String
    let genres: [String]
    let price: PriceStatus
    let platforms: [OSPlatforms]
    let shortDescription: String
    let screenshots: [String]
    let releaseDate: String
    let isFree: Bool
}
