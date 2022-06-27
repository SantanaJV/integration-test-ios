//
//  SuggestionViewController.swift
//  NotBored
//
//  Created by Joao Victor Santana Santos on 22/06/22.
//

import UIKit
import Alamofire

class SuggestionViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var participantsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var loadingView: UIView!
    
    var activityQueryOptions: ActivityQueryOptions!
    let service = ActivitiesService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNewActivity()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if activityQueryOptions.type == nil  { self.tabBarController?.navigationItem.title = "Random" }
    }
    
    
    @IBAction func tryAnotherButtonTapped(_ sender: UIButton) {
        loadNewActivity()
    }
    
    private func loadNewActivity() {
        guard loadingView.isHidden == true else {
            return
        }
        
        loadingView.isHidden = false
        service.getActivity(queryOptions: activityQueryOptions) { [weak self] (activity, error) in
            guard let activity = activity else {
                self?.activityLabel.text = error
                self?.activityLabel.textColor = .systemRed
                self?.loadingView.isHidden = true
                self?.contentStackView.isHidden = true
                return
            }
            self?.activityLabel.text = activity.activity
            self?.activityLabel.textColor = .label
            self?.participantsLabel.text = String(activity.participants)
            self?.categoryLabel.text = activity.type.capitalized
            self?.priceLabel.text = String(activity.price)
            self?.categoryStackView.isHidden = self?.activityQueryOptions.type != nil
            
            self?.loadingView.isHidden = true
            self?.contentStackView.isHidden = false
        }
    }
    
}
