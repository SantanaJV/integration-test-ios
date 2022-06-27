//
//  ActivitiesViewController.swift
//  NotBored
//
//  Created by Joao Victor Santana Santos on 21/06/22.
//

import UIKit

class ActivitiesViewController: UIViewController {
    @IBOutlet weak var activitiesTableView: UITableView!
    
    private let categories: [String] = [
        "Education",
        "Recreational",
        "Social",
        "DIY",
        "Charity",
        "Cooking",
        "Relaxation",
        "Music",
        "Busywork"
    ]
    var activityQueryOptions: ActivityQueryOptions!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Activities"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activitiesTableView.dataSource = self
        activitiesTableView.delegate = self
        activitiesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let backArrowImage = UIImage(systemName: "chevron.left.2")
        let backArrowButtonAction = UIAction { _ in
            self.dismiss(animated: true)
        }
        
        navigationItem
            .leftBarButtonItem = UIBarButtonItem(title: "Test",
                                                 image: backArrowImage,
                                                 primaryAction: backArrowButtonAction,
                                                 menu: nil)
    }
}

extension ActivitiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = categories[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.contentConfiguration = configuration
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = SuggestionViewController()
        activityQueryOptions.type = categories[indexPath.row].lowercased()
        viewController.activityQueryOptions = activityQueryOptions
        viewController.title = categories[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}
