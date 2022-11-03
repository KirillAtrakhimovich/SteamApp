//
//  NewsFilterView.swift
//  steam
//
//  Created by Kirill Atrakhimovich on 3.11.22.
//

import Foundation
import UIKit
import SnapKit

class NewsFilterView: NiblessView {
        
    private(set) var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        tableView.register(NewsFilterTableCell.self, forCellReuseIdentifier: "NewsFilterTableCell")
        tableView.separatorColor = .white
        return tableView
    }()
    
    private(set) var saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.backgroundColor = UIColor(named: "navBarColor")
        saveButton.layer.cornerRadius = 5
        saveButton.setTitle("Save", for: .normal)
        return saveButton
    }()
    
    func setup() {
        setupTableView()
        setupSaveButton()
    }
    
    private func setupTableView() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(10)
            constraints.leading.equalToSuperview().offset(5)
            constraints.trailing.equalToSuperview().inset(-5)
        }
    }
    
    private func setupSaveButton() {
        self.addSubview(saveButton)
        saveButton.snp.makeConstraints { constraints in
            constraints.top.equalTo(tableView.snp.bottom).offset(10)
            constraints.leading.equalToSuperview().offset(25)
            constraints.trailing.equalToSuperview().inset(25)
            constraints.bottom.equalToSuperview().inset(10)
        }
    }
    
}
