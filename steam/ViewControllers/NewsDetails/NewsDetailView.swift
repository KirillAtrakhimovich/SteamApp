import Foundation
import UIKit
import SnapKit
import WebKit

class NewsDetailView: NiblessView {
    
    private(set) var scrollView = UIScrollView()
    
    private(set) var contentView = UIView()
    
    var gameNameLabel: UILabel = {
        var gameNameLabel = UILabel()
        gameNameLabel.textColor = .white
        gameNameLabel.numberOfLines = 0
        return gameNameLabel
    }()
    
    let authorLabel: UILabel = {
        let authorTitle = UILabel()
        authorTitle.textColor = .white
        authorTitle.numberOfLines = 0
        authorTitle.font = Constants.authorLabelFont
        return authorTitle
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.font = Constants.titleLabelFont
        return titleLabel
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = .white
        dateLabel.numberOfLines = 0
        return dateLabel
    }()
    
    private(set) var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.systemGray
        return lineView
    }()
    
    private(set) var discriptionView = UIView()
    
    private(set) var discriptionLabel: UILabel = {
        let discriptionLabel = UILabel()
        discriptionLabel.numberOfLines = 0
        discriptionLabel.textColor = UIColor.white
        discriptionLabel.font = Constants.discriptionLabelFont
        return discriptionLabel
    }()
    
//    private(set) var webView: WKWebView = {
//        let webView = WKWebView()
//        return webView
//    }()
    
    func setup() {
        setupScrollView()
        setupContentView()
        setupGameNameLabel()
        setupAuthorLabel()
        setupTitleLabel()
        setupDateLabel()
        setupLineView()
        setupDiscriptionView()
        setupDiscriptionLabel()
//        setupWebView()
        backgroundColor = Constants.backgroundColor
        contentPriority()
    }
    
    private func contentPriority() {
        gameNameLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
        dateLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        gameNameLabel.setContentHuggingPriority(UILayoutPriority.defaultLow, for:.horizontal)
        dateLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for:.horizontal)
    }
    
    private func setupScrollView() {
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { constraints in
            constraints.top.bottom.equalTo(safeAreaLayoutGuide)
            constraints.leading.trailing.equalToSuperview()
            constraints.width.equalToSuperview()
        }
    }
    
    private func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { constraints in
            constraints.centerX.width.top.bottom.equalToSuperview()
        }
    }
    
    private func setupGameNameLabel() {
        contentView.addSubview(gameNameLabel)
        gameNameLabel.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(5)
            constraints.leading.equalToSuperview().offset(5)
        }
    }
    
    private func setupAuthorLabel() {
        contentView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(gameNameLabel.snp.bottom).offset(20)
            constraints.leading.equalToSuperview().offset(5)
        }
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(authorLabel.snp.bottom).offset(20)
            constraints.leading.equalToSuperview().offset(5)
            constraints.trailing.equalToSuperview().offset(-5)
        }
    }
    
    private func setupDateLabel() {
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(5)
            constraints.leading.equalTo(gameNameLabel.snp.trailing).offset(20)
            constraints.bottom.equalTo(authorLabel.snp.top).offset(-20)
            constraints.trailing.equalToSuperview().offset(-10)
        }
    }
    
    private func setupLineView(){
        contentView.addSubview(lineView)
        lineView.snp.makeConstraints { constraints in
            constraints.top.equalTo(titleLabel.snp.bottom).offset(10)
            constraints.leading.equalToSuperview().offset(10)
            constraints.trailing.equalToSuperview().inset(10)
            constraints.height.equalTo(1)
        }
    }

    private func setupDiscriptionView(){
        contentView.addSubview(discriptionView)
        discriptionView.snp.makeConstraints { constraints in
            constraints.top.equalTo(lineView.snp.bottom).offset(10)
            constraints.leading.equalToSuperview().offset(10)
            constraints.trailing.equalToSuperview().inset(10)
            constraints.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func setupDiscriptionLabel(){
        discriptionView.addSubview(discriptionLabel)
        discriptionLabel.snp.makeConstraints { constraints in
            constraints.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
//    private func setupWebView(){
//        contentView.addSubview(webView)
//        webView.snp.makeConstraints { constraints in
//            constraints.top.equalTo(lineView.snp.bottom).offset(20)
//            constraints.leading.equalToSuperview().offset(10)
//            constraints.trailing.equalToSuperview().inset(10)
//            constraints.bottom.equalToSuperview().inset(20)
//        }
//    }
    
}

extension NewsDetailView {
    struct Constants {
        static let backgroundColor = UIColor(named: "bgColor")
        static let titleLabelFont = UIFont(name:"HelveticaNeue-Bold", size: 19.0)
        static let authorLabelFont = UIFont.italicSystemFont(ofSize: 15)
        static let discriptionLabelFont = UIFont(name:"ArialHebrew-Light", size: 25.0)
    }
}
