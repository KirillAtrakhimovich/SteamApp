import Foundation
import UIKit

class FavouriteButton: UIButton {
    var index: Int
    
    init(index: Int = 0) {
        self.index = index
        super.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        self.index = 0
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    func changeIcon(isFavorite: Bool) {
        switch isFavorite {
        case true:
            self.setBackgroundImage(UIImage(systemName: Constants.starFill), for: .normal)
        case false:
            self.setBackgroundImage(UIImage(systemName: Constants.star), for: .normal)
        }
    }
}

extension FavouriteButton{
    struct Constants {
        static let fatalError = "init(coder:) has not been implemented"
        static let starFill = "star.fill"
        static let star = "star"
    }
}
