import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        let profileNav = UINavigationController(rootViewController: ProfilePage()).then {
            $0.tabBarItem.title = "Профиль"
            $0.tabBarItem.image = UIImage(systemName: "person")
            $0.tabBarItem.selectedImage = UIImage(systemName: "person.crop.circle")
        }
        
        let messageNav = UINavigationController(rootViewController: Message()).then {
            $0.tabBarItem.title = "Сообщения"
            $0.tabBarItem.image = UIImage(systemName: "ellipsis.message")
            $0.tabBarItem.selectedImage = UIImage(systemName: "ellipsis.message.fill")
        }
        
        let addNav = UINavigationController(rootViewController: Add()).then {
            $0.tabBarItem.title = "Создать"
            $0.tabBarItem.image = UIImage(systemName: "plus.circle")
            $0.tabBarItem.selectedImage = UIImage(systemName: "plus.circle.fill")
        }
        
        let favouritesNav = UINavigationController(rootViewController: Favourites()).then {
            $0.tabBarItem.title = "Избранное"
            $0.tabBarItem.image = UIImage(systemName: "star")
            $0.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        }
        
        let homeNav = UINavigationController(rootViewController: HomePage()).then {
            $0.tabBarItem.title = "Главная"
            $0.tabBarItem.image = UIImage(systemName: "house")
            $0.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        }
        
        let tabBar = UITabBarController()
        tabBar.tabBar.tintColor = ColorResourceManager.shared.mainColor
        tabBar.viewControllers = [homeNav,favouritesNav, addNav, messageNav, profileNav]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        return true
    }
}
