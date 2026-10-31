//
//  L10n.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 30/10/26.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

enum L10n {
    enum Overall {
        static var home: String { "home".localized }
        static var favorites: String { "favorites".localized }
        static var create: String { "create".localized }
        static var message: String { "message".localized }
        static var profile: String { "profile".localized }
        static var searchPlaceholder: String { "searchPlaceholder".localized }
        static var categoryTitle: String { "categoryTitle".localized }
        static var seeAll: String { "seeAll".localized }
        static var resultsLabel: String { "results".localized }
    }
    
    enum AllGategories {
        static var allListingsLabel: String { "allListings".localized }
        static var realEstateLabel: String { "realEstate".localized }
        static var childrenWorldLabel: String { "childrenWorld".localized }
        static var clothesLabel: String { "clothes".localized }
        static var carsLabel: String { "cars".localized }
        static var animalsLabel: String { "animals".localized }
        static var electronicsLabel: String { "electronics".localized }
    }
    
    enum Home {
        static var recommendedForYouLabel: String { "recommendedForYou".localized }
    }
    
    enum Detail {
        static var onlineTime: String { "onlineTime".localized }
        static var postedTimeToday: String { "postedTimeToday".localized }
        static var postedTimeYesterday: String { "postedTimeYesterday".localized }
        static var description: String { "description".localized }
        static var leaveFeedback: String { "leaveFeedback".localized }
        static var allListingsByUser: String { "allListingsByUser".localized }
        static var similarAdvertisements: String { "similarAdvertisements".localized }
    }
    
    enum Favorites {
        static var favoritesNavigationTitle: String { "favoritesNavigationTitle".localized }
        static var notFavoritesTitle: String { "notFavoritesTitle".localized }
    }
}
