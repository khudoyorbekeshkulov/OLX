import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let profileNav = toTabItem(
            rootViewController: ProfileController.instantiate(),
            title: L10n.Overall.profile,
            image: "person",
            selectedImage: "person.crop.circle"
        )
        
        let messageNav = toTabItem(
            rootViewController: MessageViewController(navigationTitle: L10n.Overall.message),
            title: L10n.Overall.message,
            image: "ellipsis.message",
            selectedImage: "ellipsis.message.fill"
        )
        
        let createNav = toTabItem(
            rootViewController: CreateController.instantiate(),
            title: L10n.Overall.create,
            image: "plus.circle",
            selectedImage: "plus.circle.fill"
        )
        
        let favouritesNav = toTabItem(
            rootViewController: FavoritesViewController(),
            title: L10n.Overall.favorites,
            image: "star",
            selectedImage: "star.fill"
        )
        
        let homeNav = toTabItem(
            rootViewController: HomePageController.instantiate(),
            title: L10n.Overall.home,
            image: "house",
            selectedImage: "house.fill"
        )
        
        let tabBar = UITabBarController().then {
            $0.tabBar.tintColor = ColorResourceManager.shared.mainManager
            $0.viewControllers = [homeNav,favouritesNav, createNav, messageNav, profileNav]
        }
        
        guard let windowScene = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene})
            .first else {
            return true
        }
        
        window = UIWindow(windowScene: windowScene).then {
            $0.rootViewController = tabBar
            $0.makeKeyAndVisible()
        }
        
        return true
    }
}

private extension AppDelegate {
    func toTabItem(
        rootViewController: UIViewController,
        title: String,
        image: String,
        selectedImage: String
    ) -> UINavigationController {
        
        UINavigationController(rootViewController: rootViewController).then {
            $0.tabBarItem.title = title
            $0.tabBarItem.image = UIImage(systemName: image)
            $0.tabBarItem.selectedImage = UIImage(systemName: selectedImage)
        }
    }
}
