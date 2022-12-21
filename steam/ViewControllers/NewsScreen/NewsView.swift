import Foundation
import SnapKit
import UIKit

class NewsView: NiblessView {
    
    private(set) var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(NewsViewCell.self, forCellReuseIdentifier: NewsViewCell.identifier)
        tableView.separatorColor = .white
        return tableView
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .white
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    func setup(){
        setupTableView()
        setupActivityIndicator()
        backgroundColor = Constants.backgroundColor
    }
    
    private func setupTableView() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(10)
            constraints.leading.equalToSuperview().offset(10)
            constraints.trailing.equalToSuperview().offset(-10)
            constraints.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func setupActivityIndicator() {
    self.addSubview(activityIndicator)
    activityIndicator.snp.makeConstraints { constraints in
        constraints.center.equalToSuperview()
        constraints.height.equalTo(100)
        constraints.width.equalTo(100)
        }
    }
}

extension NewsView {
    struct Constants {
       static let backgroundColor = UIColor(named: "bgColor")
    }
}
