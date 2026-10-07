

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let mainColor = UIColor(red: 0/255, green: 47/255, blue: 52/255, alpha: 1.0)

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let profile = ProfilePage()
        let profileNav = UINavigationController(rootViewController: profile)
        profileNav.tabBarItem.title = "Профиль"
        profileNav.tabBarItem.image = UIImage(systemName: "person")
        profileNav.tabBarItem.selectedImage = UIImage(systemName: "person.crop.circle")
        
        
        let message = Message()
        let messageNav = UINavigationController(rootViewController: message)
        messageNav.tabBarItem.title = "Сообщения"
        messageNav.tabBarItem.image = UIImage(systemName: "ellipsis.message")
        messageNav.tabBarItem.selectedImage = UIImage(systemName: "ellipsis.message.fill")
        
        let add = Add()
        let addNav = UINavigationController(rootViewController: add)
        addNav.tabBarItem.title = "Создать"
        addNav.tabBarItem.image = UIImage(systemName: "plus.circle")
        addNav.tabBarItem.selectedImage = UIImage(systemName: "plus.circle.fill")
        
        
        
        let favourites = Favourites()
        let favouritesNav = UINavigationController(rootViewController: favourites)
        favouritesNav.tabBarItem.title = "Избранное"
        favouritesNav.tabBarItem.image = UIImage(systemName: "star")
        favouritesNav.tabBarItem.selectedImage = UIImage(systemName: "star.fill")
        
        
        // MARK: - Home page controller system
        let homePage = HomePage()
        let homeNav = UINavigationController(rootViewController: homePage)
        homeNav.tabBarItem.title = "Главная"
        homeNav.tabBarItem.image = UIImage(systemName: "house")
        homeNav.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        
        // MARK: - Main tabbar controller system
        let tabBar = UITabBarController()
        // Tabbardagi selected iconni rangini uzgartirayapmiz
        tabBar.tabBar.tintColor = mainColor
        tabBar.viewControllers = [homeNav,favouritesNav, addNav, messageNav, profileNav]
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        return true
    }

    
}

