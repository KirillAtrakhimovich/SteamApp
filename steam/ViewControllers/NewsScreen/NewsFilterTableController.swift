import Foundation
import UIKit

final class NewsFilterTableController: NSObject, UITableViewDelegate, UITableViewDataSource {
  
    private var model: FavGameListModel?
    private let persist: PersistenceManager
    
    init(persist: PersistenceManager) {
        self.persist = persist
        super.init()
    }
    
    private func createModel(games: [Favorite]) {
        let gameItems = games.map { LocalFavoriteGame(id: $0.id, isFavorite: true, name: $0.name, discount: $0.discount, isDiscount: $0.isDiscount, price: $0.price, isFree: $0.isFree, finalPrice: $0.finalPrice)}
        
        model = FavGameListModel(games: gameItems, filteredGames: gameItems)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        createModel(games: persist.getFavoriteGames())
        return model?.filteredGames.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFilterTableCell", for: indexPath) as? NewsFilterTableCell else {
            return UITableViewCell()
        }
        guard let model = model else { return UITableViewCell() }
        let item = model.filteredGames[indexPath.row]
        cell.fillCell(game: item)
        cell.isUserInteractionEnabled = true
        cell.selectionStyle = .none
        cell.contentView.isHidden = true
        return cell
    }
    
    
}
