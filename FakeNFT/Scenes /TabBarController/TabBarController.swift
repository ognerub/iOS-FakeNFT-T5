import UIKit

final class TabBarController: UITabBarController {
    
    let servicesAssembly = ServicesAssembly(
        networkClient: DefaultNetworkClient(),
        nftStorage: NftStorageImpl()
    )
    
    private let catalogTabBarItem = UITabBarItem(
        title: NSLocalizedString("Tab.catalog", comment: ""),
        image: UIImage(systemName: "square.stack.3d.up.fill"),
        tag: 1
    )
    private let profileTabBarItem = UITabBarItem(
        title: "Профиль",
        image: UIImage(named: "Profile"),
        tag: 0
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.unselectedItemTintColor = .ypBlackDay
        
        let catalogController = TestCatalogViewController(
            servicesAssembly: servicesAssembly
        )
        catalogController.tabBarItem = catalogTabBarItem
        
        let profileController = ProfileViewController()
        profileController.tabBarItem = profileTabBarItem
        let profileNavigationController = UINavigationController(rootViewController: profileController)
        
        viewControllers = [profileNavigationController, catalogController]
        selectedIndex = 0
        
        view.backgroundColor = .systemBackground
    }
}
