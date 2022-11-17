import UIKit

class GamesTableViewCell: NiblessViewCell {

    static let identifier = Constants.identifier
    
    let gameTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let favoriteButton: FavouriteButton = {
        let button = FavouriteButton()
        button.setBackgroundImage(UIImage(systemName: Constants.star), for: .normal)
        button.tintColor = .orange
        return button 
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        self.backgroundColor = .clear
    }

    func setup() {
        isUserInteractionEnabled = true
        selectionStyle = .none
        contentView.isHidden = true
    }
    
    private func setupView() {
        self.addSubview(gameTitle)
        gameTitle.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(10)
            constraints.leading.equalToSuperview().offset(20)
            constraints.bottom.equalToSuperview().offset(-10)
        }
        self.addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { constraints in
            constraints.trailing.equalToSuperview().offset(-10)
            constraints.leading.equalTo(gameTitle.snp.trailing).offset(10)
            constraints.width.equalTo(favoriteButton.snp.height)
            constraints.centerY.equalToSuperview()
        }
    }

    func fillCell(game: GameListItem) {
        gameTitle.text = game.name
        favoriteButton.changeIcon(isFavorite: game.isFavorite)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
extension GamesTableViewCell {
    struct Constants {
        static let identifier = "GamesTableViewCell"
        static let star = "star"
    }
}

