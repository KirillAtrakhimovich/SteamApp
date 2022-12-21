import Foundation
import UIKit

class NewsViewCell: NiblessViewCell {
    static let identifier = Constants.identifier
    
    var gameNameLabel: UILabel = {
        var gameNameLabel = UILabel()
        gameNameLabel.textColor = .white
        gameNameLabel.numberOfLines = 0
        return gameNameLabel
    }()
    
    let authorLabel: UILabel = {
        let authorTitle = UILabel()
        authorTitle.textColor = .white
        authorTitle.numberOfLines = 0
        authorTitle.font = Constants.authorLabelFont
        return authorTitle
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.font = Constants.titleLabelFont
        return titleLabel
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = .white
        dateLabel.numberOfLines = 0
        return dateLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setupView()
        contentPriority()
        viewSettings()
    }

    private func contentPriority() {
        gameNameLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
        dateLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        gameNameLabel.setContentHuggingPriority(UILayoutPriority.defaultLow, for:.horizontal)
        dateLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for:.horizontal)
    }
    
    private func viewSettings() {
        isUserInteractionEnabled = true
        selectionStyle = .none
        contentView.isHidden = true
    }
    
    private func setupView() {
        self.addSubview(gameNameLabel)
        gameNameLabel.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(5)
            constraints.leading.equalToSuperview().offset(5)
       
        }
        
        self.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(gameNameLabel.snp.bottom).offset(20)
            constraints.leading.equalToSuperview().offset(5)
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(authorLabel.snp.bottom).offset(20)
            constraints.leading.equalToSuperview().offset(5)
            constraints.bottom.equalToSuperview().offset(-10)
            constraints.trailing.equalToSuperview().offset(-5)
        }
        
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(5)
            constraints.leading.equalTo(gameNameLabel.snp.trailing).offset(20)
            constraints.bottom.equalTo(authorLabel.snp.top).offset(-20)
            constraints.trailing.equalToSuperview().offset(-10)
        }
    }
    
    func fillCell(news: NewsItem) {
        let date = NSDate(timeIntervalSince1970: TimeInterval(news.date))
        gameNameLabel.text = news.gameName
        authorLabel.text = "by \(news.author)"
        titleLabel.text = news.title
        dateLabel.text = getFormatedDate(dateString: "\(date)")
    }
    
    private func getFormatedDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatTo
        if let newDate = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = Constants.dateFormatFrom
            let stringDate = dateFormatter.string(from: newDate)
            return stringDate
        }
        return Constants.empty
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension NewsViewCell {
    struct Constants {
        static let identifier = "NewsViewCell"
        static let authorLabelFont = UIFont.italicSystemFont(ofSize: 15)
        static let titleLabelFont = UIFont(name:"HelveticaNeue-Bold", size: 19.0)
        static let dateFormatFrom = "MMM d, yyyy"
        static let dateFormatTo = "yyyy-MM-dd HH:mm:ss Z"
        static let empty = ""
    }
}
