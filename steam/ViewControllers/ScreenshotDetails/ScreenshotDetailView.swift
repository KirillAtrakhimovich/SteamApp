import Foundation
import UIKit
import SnapKit

final class ScreenshotDetailView: NiblessView {
    
    private(set) var screenshotView: UIImageView = {
        let screenshotView = UIImageView()
        screenshotView.contentMode = .scaleAspectFit
        return screenshotView
    }()
    
    private(set) var scrollView = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        backgroundColor = Constants.backgroundColor
        setupScrollView()
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
    
    private func setupScreenshotView() {
        scrollView.addSubview(screenshotView)
        screenshotView.snp.makeConstraints { constraints in
            constraints.leading.centerY.trailing.equalToSuperview()
        }
    }
}
extension ScreenshotDetailView {
    struct Constants {
       static let backgroundColor = UIColor(named: "bgColor")
    }
}


