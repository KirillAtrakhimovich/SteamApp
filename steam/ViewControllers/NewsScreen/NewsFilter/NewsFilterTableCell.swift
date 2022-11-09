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
    
    let checkButton: UIButton = {
        let checkButton = UIButton()
        checkButton.isSelected = true
        checkButton.backgroundColor = UIColor(named: "navBarColor")
        checkButton.setBackgroundImage(UIImage(systemName: "checkmark"), for: .selected)
        checkButton.setBackgroundImage(UIImage(systemName: "box"), for: .normal)
        return checkButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "NewsFilterTableCell")
        setupView()
        self.backgroundColor = .clear
        gameTitle.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
        checkButton.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        gameTitle.setContentHuggingPriority(UILayoutPriority.defaultLow, for:.horizontal)
        checkButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for:.horizontal)
    }
    
    private func setupView() {
        self.addSubview(gameTitle)
        gameTitle.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(10)
            constraints.leading.equalToSuperview().offset(20)
            constraints.bottom.equalToSuperview().offset(-10)
        }
        
        self.addSubview(checkButton)
        checkButton.snp.makeConstraints { constraints in
            constraints.leading.equalTo(gameTitle.snp.trailing).offset(20)
            constraints.trailing.equalToSuperview().offset(-20)
            constraints.centerY.equalToSuperview()
            constraints.width.equalTo(checkButton.snp.height)
            constraints.height.equalTo(20)
        }
    }

    func fillCell(game: LocalFavoriteGame) {
        gameTitle.text = game.name
        
    }
}
