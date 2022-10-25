//
//  FavGameListModel.swift
//  steam
//
//  Created by Kirill Atrakhimovich on 7.09.22.
//


import Foundation
import UIKit

class FavGameListModel {
    let games: [LocalFavoriteGame]
    var filteredGames: [LocalFavoriteGame]
    
    init(games: [LocalFavoriteGame], filteredGames: [LocalFavoriteGame]) {
        self.games = games
        self.filteredGames = filteredGames
    }
    
    func filterGames(with text: String) {
        if text == "" {
            filteredGames = games
        }
        else {
            filteredGames = games.filter { $0.name.contains(text) }
            filteredGames = games.filter { $0.name.localizedCaseInsensitiveContains(text) }
        }
    }
}
