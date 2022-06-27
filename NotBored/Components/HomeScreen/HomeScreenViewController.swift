//
//  HomeScreenViewController.swift
//  NotBored
//
//  Created by Joao Victor Santana Santos on 17/06/22.
//

import UIKit

class HomeScreenViewController: UIViewController {
    // deixar privados
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var participantsTextField: UITextField!
    
    @IBOutlet weak var minimumPriceLabel: UILabel!
    @IBOutlet weak var minimumPriceSlider: UISlider!
    
    @IBOutlet weak var maximumPriceLabel: UILabel!
    @IBOutlet weak var maximumPriceSlider: UISlider!
    
    private let sliderStepValue: Float = 0.05
    var switchIsOn = false
    
    @IBAction func participantsTextFieldChanged(_ sender: UITextField) {
        let textFieldValueIsValid = sender.text == "" || (Int(sender.text ?? "") ?? 0 > 0)
        
        startButton.isEnabled = textFieldValueIsValid
        startButton.alpha = textFieldValueIsValid ? 1 : 0.5
    }
    
    @IBAction func priceSliderChanged(_ sender: UISlider) {
        let label: UILabel! = sender === minimumPriceSlider ? minimumPriceLabel : maximumPriceLabel
        
        let newStep = roundf(sender.value / sliderStepValue)
        sender.value = newStep * sliderStepValue
        
        validateSliderValues(sliding: sender)
        
        label!.text = String(format: "%.2f", sender.value)
    }
    
    private func validateSliderValues(sliding sliderToModify: UISlider) {
        let lockedSlider: UISlider! = sliderToModify === maximumPriceSlider ? minimumPriceSlider : maximumPriceSlider
        
        if(minimumPriceSlider.value > maximumPriceSlider.value) {
            sliderToModify.value = lockedSlider.value
        }
        
        if(maximumPriceSlider.value < minimumPriceSlider.value) {
            sliderToModify.value = lockedSlider.value
        }
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        guard switchIsOn else { // separar guards em metodos
            let alert = UIAlertController(title: "You did not accepted the Terms and Conditions!",
                                          message: "Tap on \"Terms and Conditions\" and accept the terms.",
                                          preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil
            ))

            present(alert, animated: true, completion: nil)
            return
        }
        
        let queryOptions = ActivityQueryOptions(participants: Int(participantsTextField.text ?? ""),
                                               minimumPrice: minimumPriceSlider.value,
                                               maximumPrice: maximumPriceSlider.value)
        
        let tabBarController = MainTabBarController(queryOptions: queryOptions)
        
        tabBarController.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(tabBarController, animated: true)
    }
    
    @IBAction func termsAndConditionsTapped(_ sender: Any) {
        let viewController = TermsAndConditionsViewController(nibName: "TermsAndConditionsViewController",
                                                              bundle: nil
        )
        viewController.onTermsAndConditionsSwitchToggle = { switchIsOn in
            self.switchIsOn = switchIsOn
        }
        
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
}
