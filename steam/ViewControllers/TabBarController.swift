//
//  TabBar.swift
//  steam
//
//  Created by Kirill Atrakhimovich on 2.03.22.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.navBarColor
        tabBar.backgroundColor = .systemGray
        setupVCs()
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: GamesListViewController(networkManager: NetworkManager(), persistenceManager: PersistenceManager()), image: Constants.listIcon),
            createNavController(for: FavoriteListViewController(), title: NSLocalizedString(Constants.favsTitle, comment: Constants.empty), image: Constants.favsIcon),
            createNavController(for: NewsViewController(networkManager: NetworkManager(), persistenceManager: PersistenceManager(), filterTableController: NewsFilterTableController(persist: PersistenceManager())), title: NSLocalizedString(Constants.newsTitle, comment: Constants.empty), image: Constants.newsIcon)
        ]
    }

     func createNavController(for rootViewController: UIViewController,
                                                      title: String? = Constants.listTitle,
                                                      image: UIImage
                                                      ) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)

         if #available(iOS 15, *) {
             let navigationBarAppearance = UINavigationBarAppearance()
                             navigationBarAppearance.configureWithOpaqueBackground()
                             navigationBarAppearance.titleTextAttributes = [
                                 NSAttributedString.Key.foregroundColor : UIColor.white
                             ]
             navigationBarAppearance.backgroundColor = Constants.navBarColor
                             UINavigationBar.appearance().standardAppearance = navigationBarAppearance
                             UINavigationBar.appearance().compactAppearance = navigationBarAppearance
                             UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
             
             let tabBarApperance = UITabBarAppearance()
                         tabBarApperance.configureWithOpaqueBackground()
                         tabBarApperance.backgroundColor = UIColor.lightGray
                         UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
                         UITabBar.appearance().standardAppearance = tabBarApperance
         }
         
         navController.tabBarItem.title = title
         navController.tabBarItem.image = image
         navController.navigationBar.topItem?.title = title
         navController.navigationItem.backButtonTitle = Constants.empty
         
        return navController
    }
}

extension TabBarController {
    struct Constants {
        static let empty = ""
        static let navBarColor = UIColor(named: "navBarColor")!
        static let listIcon = UIImage(systemName: "list.star")!
        static let favsIcon = UIImage(systemName: "star.fill")!
        static let newsIcon = UIImage(systemName: "book.fill")!
        static let listTitle = "Games"
        static let favsTitle = "Favs"
        static let newsTitle = "News"
    }
}

