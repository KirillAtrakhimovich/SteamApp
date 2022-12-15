//
//  Mapper.swift
//  steam
//
//  Created by Kirill Atrakhimovich on 6.12.22.
//

import Foundation

struct Mapper {
    
    static func createGameDetailsModel(from gameInfo: GameInfo?) -> GameDetailsModel? {
        guard let gameInfo = gameInfo else { return nil }

        return GameDetailsModel(headerImage: gameInfo.headerImage,
                         name: gameInfo.name,
                         genres: mapGenres(gameInfo.genres),
                         price: mapPrice(gameInfo.priceInfo, gameInfo.releaseDate.comingSoon, gameInfo.isFree),
                         platforms: mapPlatforms(gameInfo.platforms),
                                shortDescription: gameInfo.shortDescription ?? Constants.empty,
                         screenshots: mapScreenshots(gameInfo.screenshots),
                         releaseDate: mapReleaseDate(gameInfo.releaseDate),
                         isFree: gameInfo.isFree)
    }
}

private extension Mapper {
    
    static func mapGenres(_ genres: [Genre]?) -> [String] {
        guard let genres = genres else { return [] }
        return genres.map { $0.description }
    }
    
    static func mapPlatforms(_ platforms: Platforms) -> [OSPlatforms] {
        var result = [OSPlatforms]()
        if platforms.mac {
            result.append(.mac)
        }
        if platforms.linux {
            result.append(.linux)
        }
        if platforms.windows {
            result.append(.windows)
        }
        return result
    }
    
    static func mapScreenshots(_ screenshots: [Screenshot]?) -> [String] {
        guard let screenshots = screenshots else { return [] }
        return screenshots.map { $0.screenshotUrl }
    }
    
    static func mapReleaseDate(_ releaseDate: ReleaseDate) -> String {
        releaseDate.comingSoon ? Constants.comingSoon : releaseDate.date
    }
    
    static func mapPrice(_ price: Price?, _ comingSoon: Bool, _ isFree: Bool) -> PriceStatus {
        if isFree {
            return .defaultPrice(PriceItem(priceDiscription: Constants.freeToPlay))
        }
        if comingSoon {
            return .defaultPrice(PriceItem(priceDiscription: Constants.comingSoon))
        }
        guard let price = price else { return .defaultPrice(PriceItem(priceDiscription: Constants.noPrice)) }
        if price.discountPercent != 0 {
            let priceDiscription = "\(price.priceDescription) (-\(price.discountPercent)%)"
            let priceItem = PriceItem(priceDiscription: priceDiscription,
                                      discount: price.discountPercent,
                                      isDiscount: true,
                                      finalPrice: price.finalPrice)
            return .discountPrice(priceItem)
        } else {
            let priceDiscription = "\(price.priceDescription)"
            let priceItem = PriceItem(priceDiscription: priceDiscription,
                                      discount: price.discountPercent,
                                      isDiscount: false,
                                      finalPrice: price.finalPrice)
            return .defaultPrice(priceItem)
        }
    }
}

extension Mapper {
    struct Constants {
        static let empty = ""
        static let comingSoon = "Comming soon"
        static let freeToPlay = "Free to play"
        static let noPrice = "No price"
    }
}
