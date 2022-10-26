//
//  NewsView.swift
//  steam
//
//  Created by Kirill Atrakhimovich on 17.08.22.
//

import Foundation
import SnapKit
import UIKit


class NewsView: NiblessView {
    
    private(set) var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.register(NewsViewCell.self, forCellReuseIdentifier: NewsViewCell.identifier)
        tableView.separatorColor = .white
        return tableView
    }()
    
    func setup(){
        setupTableView()
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
}

extension NewsView {
    struct Constants {
       static let backgroundColor = UIColor(named: "bgColor")
    }
}
