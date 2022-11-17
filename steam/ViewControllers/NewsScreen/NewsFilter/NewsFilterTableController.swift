import Foundation
import UIKit

final class NewsFilterTableController: NSObject, UITableViewDelegate, UITableViewDataSource {
    var games = [GameFilterModel]()
    
    func configure(_ games: [GameFilterModel]) {
        self.games = games
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFilterTableCell", for: indexPath) as? NewsFilterTableCell else {
            return UITableViewCell()
        }
        let item = games[indexPath.row]
        cell.fillCell(game: item)
        cell.isUserInteractionEnabled = true
        cell.selectionStyle = .none
        cell.contentView.isHidden = true
        cell.checkButton.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        cell.checkButton.index = indexPath.row
        return cell
    }
    
    @objc func buttonTap(_ handler: FavouriteButton) {
        handler.isSelected.toggle()
        let itemModel = games[handler.index]
        itemModel.isChecked.toggle()
    }
}
