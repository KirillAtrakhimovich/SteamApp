import Foundation
import UIKit

enum PriceStatus {
    case discountPrice(String)
    case defaultPrice(String)
    
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
    
    var value: String {
        switch self {
        case .defaultPrice(let value), .discountPrice(let value):
            return value
        }
    }
}


