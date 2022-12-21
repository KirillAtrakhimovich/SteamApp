import Foundation
import UIKit
import SnapKit

final class FavoriteListView: NiblessView {
    
    private(set) var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barStyle = .black
        searchBar.layer.cornerRadius = searchBar.frame.height / 2
        searchBar.placeholder = Constants.placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = .white
        if let textField = searchBar.value(forKey: Constants.key) as? UITextField,
            let iconView = textField.leftView as? UIImageView {

            iconView.image = iconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            iconView.tintColor = Constants.iconColor
        }
        if let textView = searchBar.value(forKey: Constants.key) as? UITextField {
            textView.tintColor = .white
            textView.textColor = .white
         }
        return searchBar
    }()
    
    private(set) var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(FavoriteListViewCell.self, forCellReuseIdentifier: FavoriteListViewCell.identifier)
        tableView.separatorColor = .white
        return tableView
    }()
    
    func setup() {
        backgroundColor = Constants.backgroundColor
        setupSearchBar()
        setupTableView()
    }
    
    private func setupSearchBar() {
        self.addSubview(searchBar)
        searchBar.snp.makeConstraints { constraints in
            constraints.top.equalTo(safeAreaLayoutGuide)
            constraints.leading.equalToSuperview().offset(5)
            constraints.trailing.equalToSuperview().offset(-5)
        }
    }
    
    private func setupTableView() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { constraints in
            constraints.top.equalTo(searchBar.snp.bottom).offset(5)
            constraints.leading.equalToSuperview().offset(10)
            constraints.trailing.equalToSuperview().offset(-10)
            constraints.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
extension FavoriteListView {
    struct Constants {
       static let placeholder = "Search"
       static let iconColor = UIColor(named: "searchIconColor")
       static let key = "searchField"
       static let backgroundColor = UIColor(named: "bgColor")
    }
}
