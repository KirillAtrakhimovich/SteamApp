//
//  NewsViewController.swift
//  steam
//
//  Created by Kirill Atrakhimovich on 17.08.22.
//

import Foundation
import UIKit

final class NewsViewController: NiblessViewController {
    
    
    private var newsView = NewsView()
    private let networkManager: NetworkManager
    private let persistenceManager: PersistenceManager
    private var model: NewsModel?
    private var namesIds = [(String,Int)]()
    private let group = DispatchGroup()
    
    private let isolationQueue = DispatchQueue(label: "newsRequestQueue",attributes: .concurrent)
   
    init(networkManager: NetworkManager, persistenceManager: PersistenceManager) {
        self.networkManager = networkManager
        self.persistenceManager = persistenceManager
        super.init()
    }
    
    override func loadView() {
        view = newsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsView.setup()
        setupTableSettings()
        namesIds = persistenceManager.getFavoriteGames().map {($0.name, $0.id)}
        getNews()
    }
    
    private func getNews() {
       
        let gamesID = namesIds.map { $0.1 }
        for id in gamesID {
            group.enter()
            makeNetworkRequest(id)
            group.leave()
        }
        group.notify(queue: .main) {
            guard let model = self.model else { return }
            model.news.sort { $0.date > $1.date }
            self.newsView.tableView.reloadData()
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
            if self.model == nil {
                self.model = NewsModel()
            }
            self.model!.news += newsItems
        }
    }
    
    private func convertNews(_ newsInfo: Items) -> [NewsItem] {
        var newsItems = [NewsItem]()
        for kal in newsInfo.newsitems {
            let name = namesIds.filter { $0.1 == newsInfo.appid }.first.map { $0.0 } ?? "1"
            let model = NewsItem(id: kal.appid, name: name, title: kal.title, author: kal.author, date: kal.date, contents: kal.contents)
            newsItems.append(model)
        }
        return newsItems
    }
    
    private func setupTableSettings() {
        newsView.tableView.dataSource = self
        newsView.tableView.delegate = self
        newsView.tableView.separatorColor = UIColor.white
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isolationQueue.sync {
            return model?.news.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsViewCell.identifier, for: indexPath) as? NewsViewCell else {
            return UITableViewCell()
        }
        guard let model = model else { return UITableViewCell() }
        let item = model.news[indexPath.row]
        cell.fillCell(news: item)
        return cell
    }
}

extension NewsViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
