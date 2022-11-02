//
//  NewsDetailViewController.swift
//  steam
//
//  Created by Kirill Atrakhimovich on 21.09.22.
//

import Foundation
import UIKit
import WebKit

final class NewsDetailViewController: NiblessViewController{
    
    private let newsDetailView = NewsDetailView()
    private let model: NewsItem
    
    init(model: NewsItem) {
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
            self?.uploadDiscriptionLabel()
        }
    }
    
    private func getFormatedDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"

        if let newDate = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM d, yyyy"
            let stringDate = dateFormatter.string(from: newDate)
            return stringDate
        }
        return ""
    }
    
    private func uploadGameNameLabel() {
        self.newsDetailView.gameNameLabel.text = model.name
    }
    
    private func uploadAuthorLabel() {
        self.newsDetailView.authorLabel.text = model.author
    }
    
    private func uploadTitleLabel(){
        self.newsDetailView.titleLabel.text = model.title
        self.navigationItem.title = model.title
    }
    
    private func uploadDateLabel(){
        let date = NSDate(timeIntervalSince1970: TimeInterval(model.date))
        self.newsDetailView.dateLabel.text = getFormatedDate(dateString: "\(date)")
    }
    
    private func uploadDiscriptionLabel(){
        self.newsDetailView.discriptionLabel.text = model.contents
    }
    
//    private func uploadWebView() {
//        let font = UIFont.systemFont(ofSize: 40)
//
//                let fontName =  "-apple-system"
//                let linkColor = UIColor.blue
//                let linkStyle = "<style>a:link { color: \(linkColor); }</style>"
//
//                let htmlString = "\(linkStyle)<span style=\"font-family: \(fontName); font-size: \(font.pointSize); color: #FFFFFF\">\(model.contents)</span>"
//
//        self.newsDetailView.webView.loadHTMLString(htmlString, baseURL: nil)
//        self.newsDetailView.webView.uiDelegate = self
//        self.newsDetailView.webView.allowsBackForwardNavigationGestures = true
//        self.newsDetailView.webView.allowsLinkPreview = true
//        self.newsDetailView.webView.navigationDelegate = self
//    }
}



