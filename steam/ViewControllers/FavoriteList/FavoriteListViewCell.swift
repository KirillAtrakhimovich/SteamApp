import Foundation
import UIKit

class FavoriteListViewCell: NiblessViewCell {
    static let identifier = Constants.identifier
    
    let gameTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let gamePrice: UILabel = {
        let gamePrice = UILabel()
        gamePrice.textColor = .white
        return gamePrice
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: Constants.identifier)
        setupView()
        self.backgroundColor = .clear
        gameTitle.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
        gamePrice.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        gameTitle.setContentHuggingPriority(UILayoutPriority.defaultLow, for:.horizontal)
        gamePrice.setContentHuggingPriority(UILayoutPriority.defaultHigh, for:.horizontal)
    }
    
    private func setupView() {
        self.addSubview(gameTitle)
        gameTitle.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(10)
            constraints.leading.equalToSuperview().offset(20)
            constraints.bottom.equalToSuperview().offset(-10)
        }
        self.addSubview(gamePrice)
        gamePrice.snp.makeConstraints { constraints in
            constraints.trailing.equalToSuperview().offset(-10)
            constraints.leading.equalTo(gameTitle.snp.trailing).offset(10)
            constraints.centerY.equalToSuperview()
        }
    }
    
    func fillCell(game: LocalFavoriteGame) {
        if game.isFree == true {
            gamePrice.textColor = .white
            gamePrice.text = "Free"
        } else if game.isDiscount == true {
            gamePrice.text = "\(game.price)(-\(game.discount)%)"
            gamePrice.textColor = .systemGreen
        } else {
            gamePrice.textColor = .white
            gamePrice.text = "\(game.price)"
        }
        gameTitle.text = game.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
extension FavoriteListViewCell{
    struct Constants {
        static let identifier = "FavoriteListViewCell"
    }
}

