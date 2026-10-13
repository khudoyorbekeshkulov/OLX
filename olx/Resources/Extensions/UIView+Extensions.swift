import UIKit

extension UIView {
    func addarrangedSubviews(_ views: [UIView]) {
        views.forEach {
            addSubview($0)
        }
    }
}
