//  
//  Details PageViewInstaller.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 20/11/26.
//

import UIKit
import SnapKit

protocol Details_PageViewInstaller: ViewInstaller {
    var image: UIImageView! { get set }
    var infoFrame: UIView! { get set }
    var postedTime: UILabel! { get set }
    var nameProduct: UILabel! { get set }
    var saleProduct: UILabel! { get set }
    var infoLabel: UILabel! { get set }
    var infoProduct: UILabel! { get set }
    var phoneNumber: UILabel! { get set }
    var productOwner: UILabel! { get set }
    var onlineTime: UILabel! { get set }
    var feedbackButton: UIButton! { get set }
    var allAdsByUserLabel: UILabel! { get set }
    var similarAdsHeaderLabel: UILabel! { get set }
    var layout: UICollectionViewFlowLayout! { get set }
    var detailCollectionView: UICollectionView! { get set }
}

extension Details_PageViewInstaller {
    
    func initSubViews() {
        image = .init().then {
            $0.clipsToBounds = true
        }
        
        infoFrame = .init().then {
            $0.backgroundColor = ColorResourceManager.shared.cardBackground
        }
        
        postedTime = .init().then {
            $0.font = UIFont.systemFont(ofSize: 10)
            $0.textColor = ColorResourceManager.shared.secondaryText
        }
        
        nameProduct = .init().then {
            $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 2
        }
        
        saleProduct = .init().then {
            $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        }
        
        infoLabel = .init().then {
            $0.font = UIFont.systemFont(ofSize: 13, weight: .medium)
            $0.text = L10n.Overall.description
        }
        
        infoProduct = .init().then {
            $0.font = UIFont.systemFont(ofSize: 12)
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 3
        }
        
        phoneNumber = .init().then {
            $0.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        }
        
        productOwner = .init().then {
            $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            $0.isUserInteractionEnabled = true
        }
        
        onlineTime = .init().then {
            $0.font = UIFont.systemFont(ofSize: 10)
            $0.textColor = ColorResourceManager.shared.secondaryText
        }
        
        feedbackButton = .init().then {
            $0.setTitle(L10n.Detail.leaveFeedback, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
            $0.setTitleColor(ColorResourceManager.shared.mainManager, for: .normal)
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 10
        }
        
        allAdsByUserLabel = .init().then {
            $0.attributedText = NSAttributedString(
                string: L10n.Detail.allListingsByUser,
                attributes: [
                    .underlineStyle: NSUnderlineStyle.single.rawValue,
                    .font: UIFont.systemFont(ofSize: 13, weight: .medium),
                    .foregroundColor: ColorResourceManager.shared.mainManager
                ]
            )
        }
        
        similarAdsHeaderLabel = .init().then {
            $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            $0.text = L10n.Detail.similarAdvertisements
        }
        
        layout = .init().then {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 15
            $0.itemSize = CGSize(width: 155, height: 175)
            $0.sectionInset = .init(top: 0, left: 15, bottom: 0, right: 0)
        }
        
        detailCollectionView = .init().then {
            $0.backgroundColor = .clear
        }
    }
    
    func addSubViews() {
        
    }
    
    func addSubViewConstraints() {
        
    }
    
    func willLayout() {
        
    }
    
    func didLayout() {
        
    }
    
    func localizeTexts() {
        
    }
}
