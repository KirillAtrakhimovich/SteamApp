import Foundation
import SnapKit
import UIKit

final class GameDetailView: NiblessView {

    private(set) var scrollView = UIScrollView()
    
    private(set) var contentView = UIView()
    
    private(set) var headerImage = UIImageView()
    
    private(set) var titleButtonView = UIView()
      
    private(set) var titleView: UILabel = {
        let titleView = UILabel()
        titleView.numberOfLines = 0
        titleView.font = Constants.font
        titleView.textColor = UIColor.white
        titleView.textAlignment = .center
        return titleView
    }()
    
    private(set) var favouriteButton: FavouriteButton = {
        let favouriteButton = FavouriteButton()
        favouriteButton.setBackgroundImage(UIImage(systemName: Constants.star), for: .normal)
        favouriteButton.tintColor = .orange
        favouriteButton.isUserInteractionEnabled = true
        return favouriteButton
    }()
    
    private(set) var genresLabel: UILabel = {
       let genresLabel = UILabel()
        genresLabel.numberOfLines = 0
        genresLabel.font = genresLabel.font.withSize(13.0)
        genresLabel.textAlignment = .center
        genresLabel.textColor = UIColor.white
        return genresLabel
    }()
    
    private(set) var stubView = UIView()
    
    private(set) var genresView = UIView()
    
    private(set) var releasePricePlatformView = UIView()

    private(set) var releaseLabel: UILabel = {
        let releaseLabel = UILabel()
        releaseLabel.textColor = UIColor.white
        releaseLabel.textAlignment = .center
        return releaseLabel
    }()
    
    private(set) var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.numberOfLines = 0
        priceLabel.textColor = UIColor.white
        priceLabel.textAlignment = .center
        return priceLabel
    }()
    
    private(set) var platformsView = UIView()
    
    private(set) var releaseView = UIView()
    
    private(set) var priceView = UIView()
    
    private(set) var firstView: UIImageView = {
        let firstView = UIImageView()
        firstView.contentMode = .scaleAspectFit
        return firstView
    }()
    
    private(set) var secondView: UIImageView = {
        let secondView = UIImageView()
        secondView.contentMode = .scaleAspectFit
        return secondView
    }()
    
    private(set) var thirdView: UIImageView = {
        let thirdView = UIImageView()
        thirdView.contentMode = .scaleAspectFit
        return thirdView
    }()
    
    private(set) var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.systemGray
        return lineView
    }()
    
    private(set) var discriptionView = UIView()
    
    private(set) var discriptionLabel: UILabel = {
        let discriptionLabel = UILabel()
        discriptionLabel.numberOfLines = 0
        discriptionLabel.textColor = UIColor.white
        discriptionLabel.font = discriptionLabel.font.withSize(25.0)
        return discriptionLabel
    }()
    
    private(set) var screenshotsView = UIView()
    
    private(set) var screenshotViews = [UIImageView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        backgroundColor = Constants.backgroundColor
        setupScrollView()
        setupContentView()
        setupHeaderImage()
        setupTitleButtonView()
        setupTitleView()
        setupFavouriteButton()
        setupStubView()
        setupGenresView()
        setupGenresLabel()
        setupReleasePricePlatformsView()
        setupReleaseView()
        setupPriceView()
        setupPlatformsView()
        setupReleaseLabel()
        setupPriceLabel()
        setupFirstView()
        setupSecondView()
        setupThirdView()
        setupLineView()
        setupDiscriptionView()
        setupDiscriptionLabel()
        setupScreenshotView()
    }
    
    private func setupScrollView() {
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { constraints in
            constraints.top.bottom.equalTo(safeAreaLayoutGuide)
            constraints.leading.trailing.equalToSuperview()
            constraints.width.equalToSuperview()
        }
    }
    
    private func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { constraints in
            constraints.centerX.width.top.bottom.equalToSuperview()
        }
    }
    
    private func setupHeaderImage() {
        contentView.addSubview(headerImage)
        headerImage.snp.makeConstraints { constraints in
            constraints.top.leading.trailing.equalToSuperview()
            constraints.height.equalTo(headerImage.snp.width).multipliedBy(0.5)
        }
    }
    
    private func setupTitleButtonView() {
        contentView.addSubview(titleButtonView)
        titleButtonView.snp.makeConstraints { constraints in
            constraints.top.equalTo(headerImage.snp.bottom)
            constraints.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupTitleView() {
        titleButtonView.addSubview(titleView)
        titleView.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(10)
            constraints.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func setupStubView() {
        titleButtonView.addSubview(stubView)
        stubView.snp.makeConstraints { constraints in
            constraints.leading.equalToSuperview().offset(10)
            constraints.trailing.equalTo(titleView.snp.leading).inset(-10)
            constraints.width.equalTo(favouriteButton.snp.width)
            constraints.centerY.equalToSuperview()
        }
    }
    
    private func setupFavouriteButton() {
        titleButtonView.addSubview(favouriteButton)
        favouriteButton.snp.makeConstraints { constraints in
            constraints.trailing.equalToSuperview().inset(10)
            constraints.leading.equalTo(titleView.snp.trailing).offset(10)
            constraints.width.equalTo(favouriteButton.snp.height)
            constraints.centerY.equalToSuperview()
            constraints.width.greaterThanOrEqualTo(15)
        }
    }

    private func setupGenresView(){
        contentView.addSubview(genresView)
        genresView.snp.makeConstraints { constraints in
            constraints.top.equalTo(titleButtonView.snp.bottom)
            constraints.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupGenresLabel(){
        genresView.addSubview(genresLabel)
        genresLabel.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(10)
            constraints.bottom.equalToSuperview().inset(10)
            constraints.leading.trailing.equalToSuperview()
            constraints.centerY.equalToSuperview()
        }
        
    }
    
    private func setupReleasePricePlatformsView(){
        contentView.addSubview(releasePricePlatformView)
        releasePricePlatformView.snp.makeConstraints { constraints in
            constraints.top.equalTo(genresView.snp.bottom).offset(15)
            constraints.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupReleaseView(){
        releasePricePlatformView.addSubview(releaseView)
        releaseView.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview()
            constraints.bottom.equalToSuperview()
            constraints.leading.equalToSuperview()
        }
    }

    private func setupPriceView(){
        releasePricePlatformView.addSubview(priceView)
        priceView.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview()
            constraints.bottom.equalToSuperview()
            constraints.leading.equalTo(releaseView.snp.trailing)
        }
    }

    private func setupPlatformsView(){
        releasePricePlatformView.addSubview(platformsView)
        platformsView.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview()
            constraints.bottom.equalToSuperview()
            constraints.trailing.equalToSuperview()
            constraints.leading.equalTo(priceView.snp.trailing)
            constraints.width.equalTo(releaseView.snp.width)
            constraints.width.equalTo(priceView.snp.width)
        }
    }
    
    private func setupReleaseLabel(){
        releaseView.addSubview(releaseLabel)
        releaseLabel.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview()
            constraints.bottom.equalToSuperview()
            constraints.leading.equalToSuperview().offset(10)
            constraints.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setupPriceLabel(){
        priceView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview()
            constraints.bottom.equalToSuperview()
            constraints.leading.equalToSuperview().offset(10)
            constraints.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setupFirstView(){
        platformsView.addSubview(firstView)
        firstView.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview()
            constraints.bottom.equalToSuperview()
            constraints.leading.equalToSuperview().offset(10)
        }
    }
    
    private func setupSecondView(){
        platformsView.addSubview(secondView)
        secondView.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview()
            constraints.bottom.equalToSuperview()
            constraints.leading.equalTo(firstView.snp.trailing).offset(20)
        }
    }
   
    private func setupThirdView(){
        platformsView.addSubview(thirdView)
        thirdView.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview()
            constraints.bottom.equalToSuperview()
            constraints.leading.equalTo(secondView.snp.trailing).offset(20)
            constraints.trailing.equalToSuperview().inset(10)
            constraints.width.equalTo(firstView.snp.width)
            constraints.width.equalTo(secondView.snp.width)
        }
    }
    
    private func setupLineView(){
        contentView.addSubview(lineView)
        lineView.snp.makeConstraints { constraints in
            constraints.top.equalTo(releasePricePlatformView.snp.bottom).offset(20)
            constraints.leading.equalToSuperview().offset(10)
            constraints.trailing.equalToSuperview().inset(10)
            constraints.height.equalTo(1)
        }
    }
    
    private func setupDiscriptionView(){
        contentView.addSubview(discriptionView)
        discriptionView.snp.makeConstraints { constraints in
            constraints.top.equalTo(lineView.snp.bottom).offset(20)
            constraints.leading.equalToSuperview().offset(10)
            constraints.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setupDiscriptionLabel(){
        discriptionView.addSubview(discriptionLabel)
        discriptionLabel.snp.makeConstraints { constraints in
            constraints.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupScreenshotView(){
        contentView.addSubview(screenshotsView)
        screenshotsView.snp.makeConstraints { constraints in
            constraints.top.equalTo(discriptionView.snp.bottom).offset(20)
            constraints.leading.equalToSuperview()
            constraints.trailing.equalToSuperview()
            constraints.bottom.equalToSuperview()
        }
    }

    func addScreenshotViews(number: Int) {
        var currentImageView: UIImageView?
        for index in 0..<number {
            let imageView = UIImageView()
            imageView.isUserInteractionEnabled = true
            screenshotsView.addSubview(imageView)
            screenshotViews.append(imageView)
            imageView.snp.makeConstraints { make in
                if let currentImageView = currentImageView {
                    make.top.equalTo(currentImageView.snp.bottom).offset(10)
                } else {
                    make.top.equalToSuperview()
                }
                make.trailing.leading.equalToSuperview()
                make.height.equalTo(screenshotsView.snp.width).multipliedBy(0.5)
                if index == number - 1 {
                    make.bottom.equalToSuperview()
                }
            }
            currentImageView = imageView
        }
    }
}

extension GameDetailView {
    struct Constants {
        static let font = UIFont(name:"HelveticaNeue-Bold", size: 19.0)
        static let star = "star"
        static let backgroundColor = UIColor(named: "bgColor")
    }
}

