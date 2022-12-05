import Foundation
import UIKit

var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
var blurEffectView = UIVisualEffectView(effect: blurEffect)

final class NewsViewController: NiblessViewController {
    
    private var newsView = NewsView()
    private var newsFilterView = NewsFilterView()
    private let networkManager: NetworkManager
    private let persistenceManager: PersistenceManager
    private var model: NewsModel?
    private var namesIds = [(String,Int)]()
    private let group = DispatchGroup()
    private let filterTableController: NewsFilterTableController
    private let isolationQueue = DispatchQueue(label: Constants.label, attributes: .concurrent)
    private var allNews = [NewsItem]()
    
    init(networkManager: NetworkManager, persistenceManager: PersistenceManager, filterTableController: NewsFilterTableController) {
        self.networkManager = networkManager
        self.persistenceManager = persistenceManager
        self.filterTableController = filterTableController
        super.init()
    }
    
    override func loadView() {
        view = newsView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavGames()
        getNews()
        newsView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navControllerSetings()
        getFavGames()
        newsView.setup()
        navItemSettings()
        setupTableSettings()
        startIndicator()
        getNews()
    }
    
    private func getFavGames() {
        let favoriteGames = persistenceManager.getFavoriteGames()
        let gamesFilterList = favoriteGames.map { GameFilterModel(id: $0.id,
                                                                  name: $0.name,
                                                                  isChecked: true) }
        namesIds = favoriteGames.map { ($0.name, $0.id) }
        filterTableController.configure(gamesFilterList)
    }
    
    private func navItemSettings() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: Constants.title,
                                                                      style: .done, target: self,
                                                                      action: #selector(self.filterButtonTapped(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        newsFilterView.saveButton.addTarget(self,
                                            action: #selector(saveButtonTapped),
                                            for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        let filteredGames = filterTableController.games.filter { $0.isChecked }
        let filtedIds = filteredGames.map { $0.id }
        model?.filterNews(with: filtedIds)
        removeBlur()
        newsFilterView.removeFromSuperview()
        newsView.tableView.reloadData()
    }
    
    @objc func filterButtonTapped(sender: UIBarButtonItem) {
        newsFilterViewSetting()
        addBlur()
        newsView.addSubview(newsFilterView)
    }
    
    private func newsFilterViewSetting() {
        newsFilterView.setup()
        newsFilterView.frame = CGRect(x: view.frame.width / 6, y: view.frame.height / 4, width: view.frame.width / 1.5, height: view.frame.height / 2)
        newsFilterView.backgroundColor = Constants.backgroundColor
        newsFilterView.layer.borderWidth = 1
        newsFilterView.layer.borderColor = UIColor.white.cgColor
    }
    
    private func getNews() {
        allNews = []
        let gamesID = namesIds.map { $0.1 }
        for id in gamesID {
            group.enter()
            makeNetworkRequest(id)
            group.leave()
        }
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.model = NewsModel(news: self.allNews, filteredNews: self.allNews)
            self.model?.filteredNews.sort { $0.date > $1.date }
            self.newsView.tableView.reloadData()
            self.stopIndicator()
        }
    }
    
    private func makeNetworkRequest(_ id: Int) {
        networkManager.getNewsInfo(gameId: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let news):
                self.successNewsRequest(news)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func successNewsRequest(_ news: Items) {
        self.isolationQueue.async(flags: .barrier) {
            let newsItems = self.convertNews(news)
            self.allNews += newsItems
        }
    }
    
    private func startIndicator() {
        newsView.activityIndicator.startAnimating()
    }
    
    private func stopIndicator() {
        newsView.activityIndicator.stopAnimating()
    }
    
    private func convertNews(_ newsInfo: Items) -> [NewsItem] {
        var newsItems = [NewsItem]()
        for item in newsInfo.newsitems {
            let name = namesIds.filter { $0.1 == newsInfo.appid }.first.map { $0.0 } ?? "1"
            let model = NewsItem(gameId: item.appid, gameName: name, title: item.title, author: item.author, date: item.date, contents: item.contents)
            newsItems.append(model)
        }
        return newsItems
    }
    
    private func setupTableSettings() {
        newsView.tableView.dataSource = self
        newsView.tableView.delegate = self
        newsView.tableView.separatorColor = .white
        newsFilterView.tableView.dataSource = filterTableController
        newsFilterView.tableView.delegate = filterTableController
        newsFilterView.tableView.reloadData()
    }
    
    private func navControllerSetings() {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
       
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return model?.filteredNews.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsViewCell.identifier, for: indexPath) as? NewsViewCell else {
            return UITableViewCell()
        }
        guard let model = model else { return UITableViewCell() }
        let item = model.filteredNews[indexPath.row]
        cell.fillCell(news: item)
        return cell
    }
}

extension NewsViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = model else { return }
        let item = model.filteredNews[indexPath.row]
        let viewController = NewsDetailViewController(model: item)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension UIViewController {
    func addBlur() {
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        blurEffectView.alpha = 0.7
    }
    
    func removeBlur() {
        blurEffectView.alpha = 0
    }
}

extension NewsViewController{
    struct Constants {
        static let label = "newsRequestQueue"
        static let backgroundColor = UIColor(named: "bgColor")
        static let title = "Filter"
        static let unchecked = "box"
    }
}

