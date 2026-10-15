import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let profileNav = toTabItem(
            rootViewController: ProfileViewController(),
            title: "Профиль",
            image: "person",
            selectedImage: "person.crop.circle"
        )
        
        let messageNav = toTabItem(
            rootViewController: MessageViewController(),
            title: "Сообщения",
            image: "ellipsis.message",
            selectedImage: "ellipsis.message.fill"
        )
        
        let addNav = toTabItem(
            rootViewController: AddViewController(),
            title: "Создать",
            image: "plus.circle",
            selectedImage: "plus.circle.fill"
        )
        
        let favouritesNav = toTabItem(
            rootViewController: FavouritesViewController(),
            title: "Избранное",
            image: "star",
            selectedImage: "star.fill"
        )
        
        let homeNav = toTabItem(
            rootViewController: HomeViewController(),
            title: "Главная",
            image: "house",
            selectedImage: "house.fill"
        )
        
        let tabBar = UITabBarController().then {
            $0.tabBar.tintColor = UIColor(named: "main_manager_color")
            $0.viewControllers = [homeNav,favouritesNav, addNav, messageNav, profileNav]
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
