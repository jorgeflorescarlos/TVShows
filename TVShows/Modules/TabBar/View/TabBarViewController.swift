    //
    //  TabBarController.swift
    //  TVShows
    //
    //  Created by Jorge Flores Carlos on 29/09/21.
    //

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        
        let tvShowsRouter = TVShowsRouter.start()
        let favoritesRouter = FavoritesRouter.start()
        
        let vc1 = tvShowsRouter.entry
        let vc2 = favoritesRouter.entry
        
        vc1?.title = "TV Shows"
        vc2?.title = "Favorite Shows"
        
        guard let vc1 = vc1, let vc2 = vc2 else {
            return
        }

        let nav1 = TVSNavigationController(rootViewController: vc1)
        let nav2 = TVSNavigationController(rootViewController: vc2)
    
        
        if #available(iOS 13.0, *) {
            nav1.tabBarItem = UITabBarItem(title: "TV Shows", image: UIImage(systemName: "tv"), tag: 1)
            nav2.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 2)
        } else {
            nav1.tabBarItem = UITabBarItem(title: "TV Shows", image: nil, tag: 1)
            nav2.tabBarItem = UITabBarItem(title: "Favorites", image: nil, tag: 2)
        }
        
        tabBar.tintColor = .indigo
        
        setViewControllers([nav1, nav2], animated: false)
    }
}
