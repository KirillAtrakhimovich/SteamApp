import UIKit

final class GameDetailViewController: NiblessViewController {
    
    private var gameDetailView = GameDetailView()
    private let gameID: Int
    private var isFavorite: Bool
    private let networkManager: NetworkManager
    private var persistenceManager = PersistenceManager()
    private var gameModel: GameDetailsModel? {
        didSet {
            updateView()
        }
    }
    private let changeParentButton: () -> Void
    
    override func loadView() {
        view = gameDetailView
    }
    
    init(gameID: Int, isFavorite: Bool, networkManager: NetworkManager, persistenceManager: PersistenceManager, changeParentButton: @escaping () -> Void ) {
        self.gameID = gameID
        self.isFavorite = isFavorite
        self.networkManager = networkManager
        self.persistenceManager = persistenceManager
        self.changeParentButton = changeParentButton
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameDetailView.favouriteButton.changeIcon(isFavorite: isFavorite)
        gameDetailView.favouriteButton.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        
        networkManager.getGameDetails(gameid: gameID) { [weak self] result in
            switch result {
            case .success(let gameModel):
                self?.gameModel = gameModel.gameID?.data
            case .failure(let error):
               print(error)
            }
        }
    }

    @objc func buttonTap(sender: FavouriteButton) {
        guard let gameModel = gameModel,
              let priceInfo = gameModel.priceInfo else {
            return
        }
        isFavorite.toggle()
        sender.changeIcon(isFavorite: isFavorite)
        changeParentButton()
        let model = LocalFavoriteGame(id:gameID ,
                                      isFavorite: isFavorite,
                                      name: gameModel.name,
                                      discount: priceInfo.discountPercent,
                                      isDiscount: isDiscount(),
                                      price: priceInfo.priceDescription,
                                      isFree: gameModel.isFree,
                                      finalPrice: priceInfo.finalPrice)
        persistenceManager.saveFavorite(model: model)
    }
    private func isDiscount() -> Bool {
        var isDiscount = false
        if let discountPercent = gameModel?.priceInfo?.discountPercent {
            if discountPercent != 0 {
                isDiscount = true
            }
        }
        return isDiscount
    }
    
    private func setupScreenshotSettings() {
        for imageView in gameDetailView.screenshotViews {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            imageView.addGestureRecognizer(tap)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if let imageView = sender?.view as? UIImageView,
            let image = imageView.image {
                createScreenshotVC(image: image)
        }
    }
    
    func updateView() {
        uploadHeaderImage()
        uploadScreenshots()
        DispatchQueue.main.async { [weak self] in
            self?.uploadName()
            self?.uploadGenres()
            self?.uploadReleaseDate()
            self?.uploadPrice()
            self?.uploadOSImages()
            self?.uploadDiscription()
        }
    }
    
    private func createScreenshotVC(image: UIImage) {
        let viewController = ScreenshotDetailViewController(image: image)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func uploadHeaderImage() {
        guard let imageUrl = gameModel?.headerImage else { return }
        networkManager.downloadImage(imageURL: imageUrl) { [weak self] result in
            switch result {
            case .success(let headerImage):
                DispatchQueue.main.async {
                    self?.gameDetailView.headerImage.image = headerImage
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func uploadScreenshots() {
        if let screenshotUrls = gameModel?.screenshots?.map({ $0.screenshotUrl }) {
            DispatchQueue.main.async {
                self.gameDetailView.addScreenshotViews(number: screenshotUrls.count)
                self.setupScreenshotSettings()
            }
            for (index, url) in screenshotUrls.enumerated() {
                networkManager.downloadImage(imageURL: url) { [weak self] result in
                    switch result {
                    case .success(let screenshot):
                        DispatchQueue.main.async {
                            self?.gameDetailView.screenshotViews[index].image = screenshot
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    private func uploadName() {
        self.gameDetailView.titleView.text = self.gameModel?.name
        if let title = self.gameModel?.name {
            self.navigationItem.title = title
        }
    }
    
    private func uploadGenres() {
        let description = self.gameModel?.genres?.map{ $0.description }
        self.gameDetailView.genresLabel.text = description?.joined(separator: Constants.separatorRange)
    }
    
    private func uploadReleaseDate() {
        let releaseDate = self.gameModel?.releaseDate.date
        if let comingSoon = self.gameModel?.releaseDate.comingSoon {
            if comingSoon {
                self.gameDetailView.releaseLabel.text = Constants.releaseComingSoon
            } else {
                self.gameDetailView.releaseLabel.text = releaseDate
            }
        }
    }
    
    func uploadPrice(){
        guard let gameModel = gameModel else { return }

        setupPriceLabel(price: gameModel.price)
        
        
        
//        let discountPercent = gameModel.priceInfo?.discountPercent
//        let priceLabel = gameDetailView.priceLabel
//
//        switch gameModel.priceStatus {
//        case .isFree:
//            freeGameSettings(priceLabel: priceLabel)
//        case .isDiscount:
//            discountGameSettings(priceLabel: priceLabel, discountPercent: discountPercent ?? 0)
//        case .comingSoon:
//            gameDetailView.priceLabel.text = "Coming soon"
//        case .defaultPrice:
//            gameDetailView.priceLabel.text = gameModel.priceInfo?.priceDescription
//        }
//
//        if let isFree = self.gameModel?.isFree {
//            if isFree {
//                hah = .isFree
//            } else if discountPercent != 0 {
//                discountGameSettings(priceLabel: priceLabel, discountPercent: discountPercent ?? 0)
//            } else {
//                self.gameDetailView.priceLabel.text = self.gameModel?.priceInfo?.priceDescription
//            }
//        }
    }
    
    func setupPriceLabel(price: PriceStatus) {
        gameDetailView.priceLabel.text = price.value
        gameDetailView.priceLabel.font = price.textFont
        gameDetailView.priceLabel.textColor = price.textColor
    }
    
    private func uploadOSImages(_ platforms: [OSPlatforms]) {
        var imageFillsCounter = 0
        
        for element in platforms {
            if imageFillsCounter == 0 {
                self.gameDetailView.thirdView.image = 
            }
            if imageFillsCounter == 1 {
                self.gameDetailView.secondView.image = Constants.appleImage
            }
            if imageFillsCounter == 2 {
                self.gameDetailView.firstView.image = Constants.linuxImage
            }
            imageFillsCounter += 1
        }
    }
    
    private func uploadDiscription(){
        self.gameDetailView.discriptionLabel.text = self.gameModel?.shortDescription
    }
}

extension GameDetailViewController {
    struct Constants {
       static let releaseComingSoon = "Coming soon"
       static let separatorRange = "     "
       static let font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
       static let freeToPlay = "Free to play"
       static let windowsImage = UIImage(named: "windows_image")
       static let appleImage = UIImage(named: "apple_image")
       static let linuxImage = UIImage(named: "linux_image")
    }
}

