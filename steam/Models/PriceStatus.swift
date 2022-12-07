import Foundation
import UIKit

enum PriceStatus {
    case discountPrice(PriceItem)
    case defaultPrice(PriceItem)
    
    var textColor: UIColor {
        switch self {
        case .defaultPrice:
            return .white
        case .discountPrice:
            return .green
        }
    }
    
    var textFont: UIFont {
        switch self {
        case .discountPrice:
            return UIFont.systemFont(ofSize: 15.0)
        case .defaultPrice:
            return UIFont(name:"HelveticaNeue-Bold", size: 17.0)!
        }
    }
    
    var value: PriceItem {
        switch self {
        case .defaultPrice(let value), .discountPrice(let value):
            return value
        }
    }
}

struct PriceItem {
    let priceDiscription: String
    var discount: Int = 0
    var isDiscount: Bool = false
    var finalPrice: Int = 0
}

