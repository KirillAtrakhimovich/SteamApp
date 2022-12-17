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
//            self?.uploadWebView()
        }
    }
    
    private func getFormatedDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatTo

        if let newDate = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = Constants.dateFormatFrom
            let stringDate = dateFormatter.string(from: newDate)
            return stringDate
        }
        return Constants.empty
    }
    
    private func uploadGameNameLabel() {
        self.newsDetailView.gameNameLabel.text = model.gameName
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

extension NewsDetailViewController {
    struct Constants {
        static let dateFormatFrom = "MMM d, yyyy"
        static let dateFormatTo = "yyyy-MM-dd HH:mm:ss Z"
        static let empty = ""
    }
}

