import Foundation
import UIKit

class NewsViewCell: NiblessViewCell {
    static let identifier = "NewsViewCell"
    
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
        authorTitle.font = UIFont.italicSystemFont(ofSize: 15)
        return authorTitle
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 19.0)
        return titleLabel
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = .white
        dateLabel.numberOfLines = 0
        return dateLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        gameNameLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
        dateLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
        gameNameLabel.setContentHuggingPriority(UILayoutPriority.defaultLow, for:.horizontal)
        dateLabel.setContentHuggingPriority(UILayoutPriority.defaultHigh, for:.horizontal)
        self.backgroundColor = .clear
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
        gameNameLabel.text = news.name
        authorLabel.text = "by \(news.author)"
        titleLabel.text = news.title
        dateLabel.text = getFormatedDate(dateString: "\(date)")
    }
    
    private func getFormatedDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"

        if let newDate = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM d, yyyy"
            let stringDate = dateFormatter.string(from: newDate)
            return stringDate
        }
        return ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
