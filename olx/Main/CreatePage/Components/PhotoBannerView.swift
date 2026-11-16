//
//  PhotoBannerView.swift
//  olx
//

import UIKit
import SnapKit

protocol PhotoBannerViewDelegate: AnyObject {
    func photoBannerViewDidTap(_ banner: PhotoBannerView)
}

/// Tappable banner: shows an "Add photo" placeholder until an image is picked, then shows that image.
/// Taps are reported through `PhotoBannerViewDelegate`.
final class PhotoBannerView: UIControl {

    private enum Constants {
        static let cornerRadius: CGFloat = 8
        static let heightToWidthRatio: CGFloat = 0.5
        static let iconPointSize: CGFloat = 50
        static let placeholderSpacing: CGFloat = 12
    }

    private let selectedImageView = UIImageView()
    private let placeholderStack = UIStackView()

    weak var delegate: PhotoBannerViewDelegate?

    /// The picked image, or `nil` while the placeholder is visible.
    var image: UIImage? { selectedImageView.image }

    init(title: String) {
        super.init(frame: .zero)
        setup(title: title)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Shows the picked image and hides the placeholder.
    func setImage(_ image: UIImage) {
        selectedImageView.image = image
        selectedImageView.isHidden = false
        placeholderStack.isHidden = true
    }
}

private extension PhotoBannerView {
    func setup(title: String) {
        backgroundColor = ColorResourceManager.shared.addImgBackground
        layer.cornerRadius = Constants.cornerRadius
        clipsToBounds = true
        addTarget(self, action: #selector(handleTap), for: .touchUpInside)

        selectedImageView.contentMode = .scaleAspectFill
        selectedImageView.clipsToBounds = true
        selectedImageView.isHidden = true

        let iconView = UIImageView(
            image: UIImage(
                systemName: "photo.badge.plus.fill",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: Constants.iconPointSize)
            )
        )
        iconView.tintColor = ColorResourceManager.shared.white
        iconView.contentMode = .scaleAspectFit

        let titleLabel = UILabel()
        titleLabel.attributedText = NSAttributedString(
            string: title,
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .font: UIFont.systemFont(ofSize: 16, weight: .semibold),
                .foregroundColor: ColorResourceManager.shared.white
            ]
        )

        placeholderStack.addArrangedSubview(iconView)
        placeholderStack.addArrangedSubview(titleLabel)
        placeholderStack.axis = .vertical
        placeholderStack.alignment = .center
        placeholderStack.spacing = Constants.placeholderSpacing
        // Let touches pass through to the banner itself.
        placeholderStack.isUserInteractionEnabled = false

        addSubviews([selectedImageView, placeholderStack])

        selectedImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        placeholderStack.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        snp.makeConstraints {
            $0.height.equalTo(self.snp.width).multipliedBy(Constants.heightToWidthRatio)
        }
    }

    @objc func handleTap() {
        delegate?.photoBannerViewDidTap(self)
    }
}
