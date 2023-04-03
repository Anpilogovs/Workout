import Foundation
import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .specialTabBar
        tabBar.tintColor = .specialDarkGreen
        tabBar.unselectedItemTintColor = .specialGrey
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.specialLightBrown.cgColor
    }
    
    private func setupItems() {
        let mainVC = MainViewController()
        let statisticVC = StatisticViewController()
        let profileVC = ProfilViewController()
        
       viewControllers = [mainVC,statisticVC,profileVC]
        
        guard let items = tabBar.items else { return }
        
        items[0].title = "Main"
        items[1].title = "Statistic"
        items[2].title = "Profile"
        
        items[0].image = UIImage(systemName: "text.justify")
        items[1].image = UIImage(systemName: "slider.horizontal.3")
        items[2].image = UIImage(systemName: "person")
        
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(name: "Roboto", size: 12) as Any], for: .normal)
    }
}
