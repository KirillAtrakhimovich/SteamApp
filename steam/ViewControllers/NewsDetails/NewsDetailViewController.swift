//
//  NewsDetailViewController.swift
//  steam
//
//  Created by Kirill Atrakhimovich on 21.09.22.
//

import Foundation
import UIKit

class NewsDetailViewController: NiblessViewController {
    
    private var newsDetailView = NewsDetailView()
    private let networkManager: NetworkManager
    private let persistenceManager: PersistenceManager
    private let gameId: Int
    private let name: String
    private var model: Info?
    
    init(networkManager: NetworkManager, persistenceManager: PersistenceManager, gameId: Int, name: String) {
        self.networkManager = networkManager
        self.persistenceManager = persistenceManager
        self.gameId = gameId
        self.name = name
        super.init()
    }
    
    override func loadView() {
        view = newsDetailView
    }
    
    override func viewDidLoad() {
        newsDetailView.setup()
        
    }
    private func getInfo() {
        networkManager.getNewsInfo(gameId: gameId) { [weak self] result in
            switch result {
            case .success(let gameModel):
                let newModal = NewsItem(id: self?.gameId ?? 0, name: self?.name ?? "" , title: self?.model?.title ?? "", author: self?.model?.author ?? "", date: self?.model?.date ?? 0, contents: self?.model?.contents ?? "")
            case .failure(let error):
               print(error)
            }
        }
    }

}
