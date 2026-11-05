import UIKit.UIView

public protocol ViewInstaller: AnyObject {
    /// The parent (root) view of all subviews
    var mainView: UIView { get }

    var safeAreaInsets: UIEdgeInsets { get }

    /// Installs all subviews (init, add, constraint)
    func installSubviews()

    /// Initializes all subview elements
    func initSubViews()

    /// Places each subview to its super-view
    func addSubViews()

    /// Adds constraints of placed subviews
    func addSubViewConstraints()

    /// Layout subviews
    func willLayout()

    func didLayout()

    func localizeTexts()
}


public extension ViewInstaller {
    var safeAreaInsets: UIEdgeInsets { .zero }

    func installSubviews() {
        initSubViews()
        addSubViews() 
        addSubViewConstraints()
    }

    func initSubViews() {
        fatalError("Implementation pending...")
    }

    func addSubViews() {
        fatalError("Implementation pending...")
    }

    func addSubViewConstraints() {
        fatalError("Implementation pending...")
    }

    func willLayout() {
    }

    func didLayout() {
    }

    func localizeTexts() {
    }
}
