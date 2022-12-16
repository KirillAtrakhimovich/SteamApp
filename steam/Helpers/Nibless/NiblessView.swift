import UIKit

open class NiblessView: UIView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable, message: "Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    public required init?(coder: NSCoder) {
        fatalError(Constants.error)
    }
}

extension NiblessView {
    struct Constants {
        static let error = "Loading this view from a nib is unsupported in favor of initializer dependency injection."
    }
}
