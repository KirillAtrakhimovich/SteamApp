import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            DispatchQueue.main.async {
               completion()
            }
        }))
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
}
