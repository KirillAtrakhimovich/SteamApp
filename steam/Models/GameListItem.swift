//
//  GameListItem.swift
//  steam
//
//  Created by Kirill Atrakhimovich on 31.08.22.
//

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
