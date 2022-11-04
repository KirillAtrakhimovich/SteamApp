//
//  NewsFilterTableCell.swift
//  steam
//
//  Created by Kirill Atrakhimovich on 3.11.22.
//

import Foundation
import UIKit

class NewsFilterTableCell: NiblessViewCell {
    static let identifier = "NewsFilterTableCell"
    
    let gameTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "NewsFilterTableCell")
        setupView()
        self.backgroundColor = .clear
        
    }
    
    private func setupView() {
        self.addSubview(gameTitle)
        gameTitle.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(10)
            constraints.leading.equalToSuperview().offset(20)
            constraints.bottom.equalToSuperview().offset(-10)
            constraints.trailing.equalToSuperview().offset(-20)
        }
    }

    func fillCell(game: LocalFavoriteGame) {
        gameTitle.text = game.name
    }
}
