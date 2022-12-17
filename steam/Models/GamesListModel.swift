import Foundation
import UIKit

class GamesListModel {
    let games: [GameListItem]
    var filteredGames: [GameListItem]
    
    init(games: [GameListItem], filteredGames: [GameListItem]) {
        self.games = games
        self.filteredGames = filteredGames
    }
    
    func filterGames(with text: String) {
        if text == Constants.empty {
            filteredGames = games
        }
        else {
            filteredGames = games.filter { $0.name.contains(text) }
            filteredGames = games.filter { $0.name.localizedCaseInsensitiveContains(text) }
        }
    }
}

extension GamesListModel {
    struct Constants {
        static let empty = ""
    }
}
