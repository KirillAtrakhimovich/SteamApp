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
            guard let self = self else { return }
            switch result {
            case .success(let gameInfo):
                self.gameModel = Mapper.createGameDetailsModel(from: gameInfo.gameID?.data)
            case .failure(let error):
               print(error)
            }
        }
    }

    @objc func buttonTap(sender: FavouriteButton) {
        guard let gameModel = gameModel else { return }
        
        isFavorite.toggle()
        sender.changeIcon(isFavorite: isFavorite)
        changeParentButton()
        let model = LocalFavoriteGame(id:gameID ,
                                      isFavorite: isFavorite,
                                      name: gameModel.name,
                                      discount: gameModel.price.value.discount,
                                      isDiscount: gameModel.price.value.isDiscount,
                                      price: gameModel.price.value.priceDiscription,
                                      isFree: gameModel.isFree,
                                      finalPrice: gameModel.price.value.finalPrice)
        persistenceManager.saveFavorite(model: model)
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
            guard let self = self else { return }
            self.uploadName()
            self.uploadGenres()
            self.uploadReleaseDate()
            self.uploadPrice()
            self.uploadOSImages()
            self.uploadDiscription()
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
        if let screenshotUrls = gameModel?.screenshots {
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
        guard let name = gameModel?.name else { return }
        gameDetailView.titleView.text = name
        navigationItem.title = name
    }
    
    private func uploadGenres() {
        let description = gameModel?.genres
        gameDetailView.genresLabel.text = description?.joined(separator: Constants.separatorRange)
    }
    
    private func uploadReleaseDate() {
        guard let releaseDate = gameModel?.releaseDate else { return }
        gameDetailView.releaseLabel.text = releaseDate
    }
    
    func uploadPrice(){
        guard let gameModel = gameModel else { return }
        setupPriceLabel(price: gameModel.price)
    }
    
    func setupPriceLabel(price: PriceStatus) {
        gameDetailView.priceLabel.text = price.value.priceDiscription
        gameDetailView.priceLabel.font = price.textFont
        gameDetailView.priceLabel.textColor = price.textColor
    }
    
    private func uploadOSImages() {
        guard let platforms = gameModel?.platforms else { return }
        var imageFillsCounter = 0
        
        for _ in platforms {
            if imageFillsCounter == 0 {
                self.gameDetailView.thirdView.image = Constants.windowsImage
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

