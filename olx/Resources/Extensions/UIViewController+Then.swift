import UIKit

// MARK: - To start the elements from tabbar
extension UIViewController {
    var topbarHeight: CGFloat {
        (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
        (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
