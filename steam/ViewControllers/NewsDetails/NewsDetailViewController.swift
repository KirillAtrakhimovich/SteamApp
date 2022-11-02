//
//  NewsDetailViewController.swift
//  steam
//
//  Created by Kirill Atrakhimovich on 21.09.22.
//

import Foundation
import UIKit
import WebKit

final class NewsDetailViewController: NiblessViewController, WKUIDelegate, WKNavigationDelegate {
    
    private let newsDetailView = NewsDetailView()
    private let persistenceManager: PersistenceManager
    private let model: NewsItem
    
    init(persistenceManager: PersistenceManager, model: NewsItem) {
        self.persistenceManager = persistenceManager
        self.model = model
        super.init()
    }
    
    override func loadView() {
        view = newsDetailView
    }
    
    override func viewDidLoad() {
        newsDetailView.setup()
        updateView()
    }
    
    func updateView() {
        DispatchQueue.main.async { [weak self] in
            self?.uploadGameNameLabel()
            self?.uploadAuthorLabel()
            self?.uploadTitleLabel()
            self?.uploadDateLabel()
//            self?.uploadDiscriptionLabel()
            self?.uploadWebView()
        }
    }
    
    private func uploadGameNameLabel() {
        self.newsDetailView.gameNameLabel.text = model.name
    }
    
    private func uploadAuthorLabel() {
        self.newsDetailView.authorLabel.text = model.author
    }
    
    private func uploadTitleLabel(){
        self.newsDetailView.titleLabel.text = model.title
    }
    
    private func uploadDateLabel(){
        self.newsDetailView.dateLabel.text = "\(model.date)"
    }
    
    private func uploadDiscriptionLabel(){
        self.newsDetailView.discriptionLabel.text = model.contents
        print(model.contents)
    }
    
    private func uploadWebView() {
        let font = UIFont.systemFont(ofSize: 40)

                let fontName =  "-apple-system"
                let linkColor = UIColor.blue
                let linkStyle = "<style>a:link { color: \(linkColor); }</style>"

                let htmlString = "\(linkStyle)<span style=\"font-family: \(fontName); font-size: \(font.pointSize); color: #FFFFFF\">\(model.contents)</span>"

        self.newsDetailView.webView.loadHTMLString(htmlString, baseURL: nil)
        self.newsDetailView.webView.uiDelegate = self
        self.newsDetailView.webView.allowsBackForwardNavigationGestures = true
        self.newsDetailView.webView.allowsLinkPreview = true
        self.newsDetailView.webView.navigationDelegate = self
    }
}



