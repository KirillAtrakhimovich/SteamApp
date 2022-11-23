import UIKit
import SnapKit

class GamesListView: NiblessView {
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(GamesTableViewCell.self, forCellReuseIdentifier: GamesTableViewCell.identifier)
        return tableView
    }()
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barStyle = .black
        searchBar.layer.cornerRadius = searchBar.frame.height / 2
        searchBar.placeholder = Constants.searchBarPlaceholder
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = .white
        if let textField = searchBar.value(forKey: "searchField") as? UITextField,
            let iconView = textField.leftView as? UIImageView {
            textField.tintColor = .white
            textField.textColor = .white
            iconView.image = iconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            iconView.tintColor = Constants.iconColor
        }
        return searchBar
    }()
    
    let refreshControl = UIRefreshControl()
    
    var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .white
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    func setupViews() {
        self.backgroundColor = Constants.backgroundColor
        self.addSubview(searchBar)
        searchBar.snp.makeConstraints { constraints in
            constraints.top.equalTo(safeAreaLayoutGuide)
            constraints.leading.equalToSuperview().offset(5)
            constraints.trailing.equalToSuperview().offset(-5)
        }
        
        self.addSubview(tableView)
        tableView.snp.makeConstraints { constraints in
            constraints.top.equalTo(searchBar.snp.bottom).offset(5)
            constraints.leading.equalToSuperview().offset(10)
            constraints.trailing.equalToSuperview().offset(-10)
            constraints.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        self.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { constraints in
            constraints.center.equalToSuperview()
            constraints.height.equalTo(100)
            constraints.width.equalTo(100)
        }
    }
}

extension GamesListView {
    struct Constants {
        static let searchBarPlaceholder = "Search"
        static let backgroundColor = UIColor(named: "bgColor")!
        static let iconColor = UIColor(named: "searchIconColor")
    }
}
