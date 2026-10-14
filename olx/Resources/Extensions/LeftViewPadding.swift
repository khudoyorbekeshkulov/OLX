import UIKit

extension UITextField {
    func setLeftPadding(_ value: CGFloat) {
        leftView = UIView(frame: (CGRect(x: 0, y: 0, width: value, height: 0)))
        leftViewMode = .always
    }
}
