import Foundation
import UIKit

class FavoriteListViewController: NiblessViewController, UITableViewDelegate {
    
    private var favoriteListView = FavoriteListView()
    private let persistanceManager = PersistenceManager()
    private var model: FavGameListModel?
    
    override func loadView() {
        view = favoriteListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let favoriteGames = persistanceManager.getFavoriteGames()
        createModel(games: favoriteGames)
        favoriteListView.setup()
        navigationControllerSetup()
        setupSearchBarSettings()
        setupTableSettings()

    }
    override func viewWillAppear(_ animated: Bool) {
        let refreshedGames = persistanceManager.getFavoriteGames()
        createModel(games: refreshedGames)
        favoriteListView.tableView.reloadData()
    }
    
    func navigationControllerSetup() {
        navigationController?.navigationBar.topItem?.title = Constants.title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: Constants.titleSort, style: .done, target: self, action: #selector(self.sort(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    private func setupTableSettings() {
        favoriteListView.tableView.dataSource = self
        favoriteListView.tableView.delegate = self
        
    }

    @objc func sort(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: Constants.sorting,
                                      message: Constants.message,
                                      preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: Constants.sortByTitle ,
                                      style: UIAlertAction.Style.default,
                                      handler: { _ in
            self.sortByName()
        }))
        alert.addAction(UIAlertAction(title: Constants.sortByPrice,
                                      style: UIAlertAction.Style.default,
                                      handler: { _ in
            self.sortByPrice()
        }))
        alert.addAction(UIAlertAction(title: Constants.cancel,
                                      style: UIAlertAction.Style.cancel,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func sortByName() {
        guard let filtGames = self.model?.filteredGames else { return }
        let sortGamesByNames = filtGames.sorted { $0.name < $1.name }
        self.model?.filteredGames = sortGamesByNames
        self.favoriteListView.tableView.reloadData()
    }
    
    private func sortByPrice() {
        guard let filtGames = self.model?.filteredGames else { return }
        let sortGamesByPrice = filtGames.sorted { $0.finalPrice < $1.finalPrice }
        self.model?.filteredGames = sortGamesByPrice
        self.favoriteListView.tableView.reloadData()
    }
    
    private func setupSearchBarSettings() {
        favoriteListView.searchBar.delegate = self
        favoriteListView.searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    private func createModel(games: [Favorite]) {
        let gameItems = games.map { LocalFavoriteGame(id: $0.id, isFavorite: true, name: $0.name, discount: $0.discount, isDiscount: $0.isDiscount, price: $0.price, isFree: $0.isFree, finalPrice: $0.finalPrice)}
        
        model = FavGameListModel(games: gameItems, filteredGames: gameItems)
    }
}

extension FavoriteListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model?.filterGames(with: searchText)
        favoriteListView.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension FavoriteListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.filteredGames.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteListViewCell.identifier, for: indexPath) as? FavoriteListViewCell else {
            return UITableViewCell()
        }
        guard let model = model else { return UITableViewCell() }
        let item = model.filteredGames[indexPath.row]
        cell.fillCell(game: item)
        cell.isUserInteractionEnabled = true
        cell.selectionStyle = .none
        cell.contentView.isHidden = true
        print(item.id)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            persistanceManager.delete(id: model?.filteredGames[indexPath.row].id ?? 0)
            model?.filteredGames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            tableView.reloadData()
        }
    }
}

extension FavoriteListViewController {
    struct Constants {
        static let title = "Favorites"
        static let titleEdit = "Edit"
        static let titleSort = "Sort"
        static let message = "You can sort your favourites games alphabetically or in the price ascending order."
        static let sorting = "SORTING"
        static let sortByTitle = "Sort by Title"
        static let sortByPrice = "Sort by Price"
        static let cancel = "Cancel"
    }
}

