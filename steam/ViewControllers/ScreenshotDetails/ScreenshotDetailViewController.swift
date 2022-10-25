
import UIKit

final class ScreenshotDetailViewController: NiblessViewController{
    
    private var screenshotDetailView = ScreenshotDetailView()
    private let image: UIImage
    
                                                                    
    override func loadView() {
        view = screenshotDetailView
    }
    
    init(image: UIImage) {
        self.image = image
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenshotDetailView.screenshotView.image = image
        zoomImage()
    }

    private func zoomImage() {
        screenshotDetailView.scrollView.maximumZoomScale = 4
        screenshotDetailView.scrollView.minimumZoomScale = 1
        screenshotDetailView.scrollView.delegate = self
    }
}

extension ScreenshotDetailViewController: UIScrollViewDelegate {
       func viewForZooming(in scrollView: UIScrollView) -> UIView? {
           return screenshotDetailView.screenshotView
    }
}

