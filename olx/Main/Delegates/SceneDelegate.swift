import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        guard let windowScene = scene as? UIWindowScene else {
            return
        }

        let homeNav = toTabItem(
            rootViewController: HomePageController.instantiate(),
            title: L10n.Overall.home,
            image: "house",
            selectedImage: "house.fill"
        )

        let favouritesNav = toTabItem(
            rootViewController: FavoritesViewController(),
            title: L10n.Overall.favorites,
            image: "star",
            selectedImage: "star.fill"
        )

        let createNav = toTabItem(
            rootViewController: CreateController.instantiate(),
            title: L10n.Overall.create,
            image: "plus.circle",
            selectedImage: "plus.circle.fill"
        )

        let messageNav = toTabItem(
            rootViewController: MessageViewController(
                navigationTitle: L10n.Overall.message
            ),
            title: L10n.Overall.message,
            image: "ellipsis.message",
            selectedImage: "ellipsis.message.fill"
        )

        let profileNav = toTabItem(
            rootViewController: ProfileController.instantiate(),
            title: L10n.Overall.profile,
            image: "person",
            selectedImage: "person.crop.circle"
        )

        let tabBar = UITabBarController().then {
            $0.tabBar.tintColor = ColorResourceManager.shared.mainManager
            $0.viewControllers = [
                homeNav,
                favouritesNav,
                createNav,
                messageNav,
                profileNav
            ]
            $0.selectedIndex = 0
        }

        window = UIWindow(windowScene: windowScene).then {
            $0.rootViewController = tabBar
            $0.makeKeyAndVisible()
        }
    }
}

private extension SceneDelegate {

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
