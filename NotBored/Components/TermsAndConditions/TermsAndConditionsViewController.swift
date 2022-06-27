//
//  TermsAndConditionsViewController.swift
//  NotBored
//
//  Created by Joao Victor Santana Santos on 20/06/22.
//

import UIKit

class TermsAndConditionsViewController: UIViewController {
    @IBOutlet weak var termsAndConditionsSwitch: UISwitch!
    
    var onTermsAndConditionsSwitchToggle: ((Bool) -> Void)?
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func termsAndConditionsSwitchToggled(_ sender: UISwitch) {
        onTermsAndConditionsSwitchToggle?(sender.isOn)
    }
}
