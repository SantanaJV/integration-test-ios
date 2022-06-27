//
//  TabBarController.swift
//  NotBored
//
//  Created by Joao Victor Santana Santos on 23/06/22.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    var activityQueryOptions: ActivityQueryOptions
    
    init(queryOptions activityQueryOptions: ActivityQueryOptions) {
        self.activityQueryOptions = activityQueryOptions
        super.init(nibName: nil, bundle: nil)
        setupViewControllers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //override func viewDidLoad() {
    //    this is called first
    //    super.viewDidLoad()
    //    setupViewControllers()
    //}
    
    private func setupViewControllers() {
        let firstTabTitle = "Activities"
        let firstTabImage = UIImage(systemName: "creditcard")
        
        let firstTab = ActivitiesViewController()
        firstTab.activityQueryOptions = activityQueryOptions
        let firstTabNavigationController = UINavigationController(rootViewController: firstTab)
        
        
        firstTab.title = firstTabTitle
        firstTab.tabBarItem = UITabBarItem(title: firstTabTitle,
                                                               image: firstTabImage,
                                                               selectedImage: firstTabImage
        )
        
        let secondTabTitle = "Random"
        let secondTabImage = UIImage(systemName: "shuffle")
        
        let secondTab = SuggestionViewController()
        let secondTabNavigationController = UINavigationController(rootViewController: secondTab)
        
        secondTab.title = secondTabTitle
        secondTab.activityQueryOptions = activityQueryOptions
        secondTab.tabBarItem = UITabBarItem(title: secondTabTitle,
                                            image: secondTabImage,
                                            selectedImage: secondTabImage
        )
        
        viewControllers = [firstTab, secondTab]
    }
}
