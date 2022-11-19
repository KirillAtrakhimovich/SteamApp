import Foundation
import UIKit

class NewsFilterTableCell: NiblessViewCell {
    static let identifier = Constants.identifier
    
    let gameTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let checkButton: FavouriteButton = {
        let checkButton = FavouriteButton()
        checkButton.isSelected = true
        checkButton.backgroundColor = Constants.backgroundColor
        checkButton.setBackgroundImage(UIImage(systemName: Constants.checked), for: .selected)
        checkButton.setBackgroundImage(UIImage(systemName: Constants.unchecked), for: .normal)
        return checkButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: Constants.identifier)
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

    func fillCell(game: GameFilterModel) {
        gameTitle.text = game.name
    }
}

extension NewsFilterTableCell {
    struct Constants {
        static let identifier = "NewsFilterTableCell"
        static let backgroundColor = UIColor(named: "navBarColor")
        static let checked = "checkmark"
        static let unchecked = "box"
    }
}
