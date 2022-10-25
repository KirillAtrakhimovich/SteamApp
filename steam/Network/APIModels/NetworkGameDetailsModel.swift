import Foundation

struct GameModel: Decodable {
    let gameID: BrawlStars?

    private struct DynamicCodingKeys: CodingKey {

        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var game: BrawlStars?

        for key in container.allKeys {
            game = try container.decode(BrawlStars.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
        }

        if let gameDecode = game {
            gameID = gameDecode
        } else {
            gameID = nil
        }
    }
}

struct BrawlStars: Decodable {
    let success: Bool
    let data: GameInfo
}

struct GameInfo: Decodable {
    let headerImage: String
    let name: String
    let genres: [Genre]?
    let priceInfo: Price?
    let platforms: Platforms
    let shortDescription: String?
    let screenshots: [Screenshot]?
    let releaseDate: ReleaseDate
    let isFree: Bool
    
    enum CodingKeys: String, CodingKey {
        case name, genres, platforms, screenshots
        case headerImage = "header_image"
        case priceInfo = "price_overview"
        case shortDescription = "short_description"
        case releaseDate = "release_date"
        case isFree = "is_free"
    }
}

struct Genre: Decodable {
    let id: String
    let description: String
}

struct Price: Decodable {
    let priceDescription: String
    let discountPercent: Int
    let finalPrice: Int
    let startPrice: Int
    let currency: String
    
    enum CodingKeys: String, CodingKey {
        case currency
        case priceDescription = "final_formatted"
        case discountPercent = "discount_percent"
        case finalPrice = "final"
        case startPrice = "initial"
    }
}

struct Platforms: Decodable {
    let windows: Bool
    let mac: Bool
    let linux: Bool
}

struct Screenshot: Decodable {
    let id: Int
    let screenshotUrl: String
    let screenshotFullHd: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case screenshotUrl = "path_thumbnail"
        case screenshotFullHd = "path_full"
    }
}

struct ReleaseDate: Decodable {
    let comingSoon: Bool
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case date
        case comingSoon = "coming_soon"
    }
}
