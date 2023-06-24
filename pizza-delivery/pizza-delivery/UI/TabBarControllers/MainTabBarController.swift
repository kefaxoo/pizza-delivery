//
//  MainTabBarController.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 23.06.23.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        let menuVC = MenuViewController(nibName: nil, bundle: nil).configureNavigationController()
        menuVC.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(named: "menuImage"), tag: 1000)
        let contactsVC = UIViewController(nibName: nil, bundle: nil)
        contactsVC.tabBarItem = UITabBarItem(title: "Contacts", image: UIImage(named: "pinImage"), tag: 1001)
        let profileVC = UIViewController(nibName: nil, bundle: nil)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1002)
        let cartVC = UIViewController(nibName: nil, bundle: nil)
        cartVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "cartImage"), tag: 1003)
        
        self.tabBar.tintColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00)
        self.viewControllers = [
            menuVC,
            contactsVC,
            profileVC,
            cartVC
        ]
    }
}
