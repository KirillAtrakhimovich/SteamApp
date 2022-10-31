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
    private var model: NewsModel?
    
    init(networkManager: NetworkManager, persistenceManager: PersistenceManager) {
        self.networkManager = networkManager
        self.persistenceManager = persistenceManager
        super.init()
    }
    
    override func loadView() {
        view = newsDetailView
    }
    
    override func viewDidLoad() {
        newsDetailView.setup()
        
       
    }
    

}
