import Foundation
import UIKit

class GameListItem {
    
    let id: Int
    let name: String
    var isFavorite: Bool
    
    init(id: Int, name: String, isFavorite: Bool) {
        self.id = id
        self.name = name
        self.isFavorite = isFavorite
    }
}
