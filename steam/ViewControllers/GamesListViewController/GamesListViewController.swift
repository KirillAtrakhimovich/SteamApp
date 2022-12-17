import UIKit

final class GamesListViewController: NiblessViewController {
    private let customView = GamesListView()
    private let networkManager: NetworkManager
    private let persistenceManager: PersistenceManager
    private var gameModel: GameInfo?
    private var favoriteGames = [Favorite]()
    private var model: GamesListModel? {
        didSet {
            updateUI()
        }
    }
   
    init(networkManager: NetworkManager, persistenceManager: PersistenceManager) {
        self.networkManager = networkManager
        self.persistenceManager = persistenceManager
        super.init()
    }
    
    override func loadView() {
        view = customView
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let model = model else { return }
        favoriteGames = persistenceManager.getFavoriteGames()
        for game in model.games {
            game.isFavorite = false
        }
        updateFavoriteStatus()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Constants.title
        favoriteGames = persistenceManager.getFavoriteGames()
        customView.tableView.refreshControl = customView.refreshControl
        setupTableSettings()
        setupSearchBarSettings()
        customView.setupViews()
        startIndicator()
        uploadData()
        navConntrollerSettings()
        customView.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    private func uploadData() {
        networkManager.getGamesList { [weak self] result in
            switch result {
            case .success(let games):
                self?.createModel(games: games)
                self?.updateFavoriteStatus()
            case .failure(let error):
                self?.showAlert(title: Constants.error, message: error.localizedDescription, completion: {
                    self?.stopIndicator()
                    self?.customView.tableView.refreshControl?.endRefreshing()
                })
            }
        }
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.customView.tableView.reloadData()
            self.stopIndicator()
            self.customView.tableView.refreshControl?.endRefreshing()
        }
    }
    
    @objc private func refresh() {
        favoriteGames = persistenceManager.getFavoriteGames()
        uploadData()
    }
    
    private func updateFavoriteStatus() {
        guard let games = model?.games else { return }
        for favGames in favoriteGames {
            if let game = games.filter({ $0.id == favGames.id }).first {
                game.isFavorite = true
            }
        }
        updateUI()
    }
    
    private func createModel(games: [Game]) {
        let filteredGames = games.filter { $0.name != Constants.empty }
        let sortedGames = filteredGames.sorted { $0.name < $1.name }
        let gameItems = sortedGames.map { GameListItem(id: $0.appid, name: $0.name, isFavorite: false) }
        
        model = GamesListModel(games: gameItems, filteredGames: gameItems)
    }
    
    private func setupTableSettings() {
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        customView.tableView.separatorColor = UIColor.white
    }
    
    private func setupSearchBarSettings() {
        customView.searchBar.delegate = self
        customView.searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    private func startIndicator() {
        customView.activityIndicator.startAnimating()
    }
    
    private func stopIndicator() {
        customView.activityIndicator.stopAnimating()
    }
}

extension GamesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.filteredGames.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GamesTableViewCell.identifier, for: indexPath) as? GamesTableViewCell else {
            return UITableViewCell()
        }
        guard let model = model else { return UITableViewCell() }
        let item = model.filteredGames[indexPath.row]
        cell.setup()
        cell.fillCell(game: item)
        cell.favoriteButton.index = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        return cell
    }
    
    @objc func buttonTap(sender: FavouriteButton) {
        guard let itemModel = model?.filteredGames[sender.index] else { return }
        itemModel.isFavorite.toggle()
        sender.changeIcon(isFavorite: itemModel.isFavorite)
        networkManager.getGameDetails(gameid: itemModel.id) { [weak self] result in
            switch result {
            case .success(let gameModel):
                guard let self = self else { return }
                let isDiscount = self.checkDiscount(discount: gameModel.gameID?.data.priceInfo?.discountPercent)
                let modal = LocalFavoriteGame(id: itemModel.id,
                                              isFavorite: itemModel.isFavorite ,
                                              name: itemModel.name,
                                              discount: gameModel.gameID?.data.priceInfo?.discountPercent ?? 0,
                                              isDiscount: isDiscount,
                                              price: gameModel.gameID?.data.priceInfo?.priceDescription ?? "",
                                              isFree: gameModel.gameID?.data.isFree ?? false,
                                              finalPrice: gameModel.gameID?.data.priceInfo?.finalPrice ?? 0 )
                self.persistenceManager.saveFavorite(model: modal)
            case .failure(let error):
               print(error)
            }
        }
    }
    
    private func checkDiscount(discount: Int?) -> Bool {
        if let discount = discount,
            discount != 0 {
           return true
        } else {
           return false
        }
    }
    
    @objc func refreshData(sender: UIRefreshControl ) {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            self.customView.tableView.reloadData()
        }
    }
    
    private func navConntrollerSettings() {
        navigationItem.backButtonTitle = Constants.empty
        navigationController?.navigationBar.tintColor = .white
    }
}

extension GamesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = model else { return }
        let itemModel =  model.filteredGames[indexPath.row]
        let changeButton: () -> Void = {
            itemModel.isFavorite.toggle()
            tableView.reloadData()
        }
        let viewController = GameDetailViewController(gameID: itemModel.id,
                                                      isFavorite: itemModel.isFavorite,
                                                      networkManager: networkManager,
                                                      persistenceManager: persistenceManager,
                                                      changeParentButton: changeButton )
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension GamesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model?.filterGames(with: searchText)
        customView.tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension GamesListViewController {
    struct Constants {
       static let title = "Games"
       static let empty = ""
       static let error = "Error"
    }
}
