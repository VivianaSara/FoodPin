//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 04.05.2022.
//

import UIKit

class ReviewViewController: UIViewController {
    @IBOutlet private var backgroundImageView: UIImageView!
    @IBOutlet private var rateButtons: [UIButton]!
    @IBOutlet private var closeButton: UIButton!
    private var restaurant = Restaurant()

    func setRestaurant(restaurant: Restaurant) { self.restaurant = restaurant }

    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundImageView.image = UIImage(data: restaurant.getImage())

        // Applying the blur effect
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)

        // Move outside the view - right (for left we should use negative x)
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
        let moveDownTransform = CGAffineTransform.init(translationX: 0, y: -200)

        // Scale fr 5X and then concatenate these 2 tranformations
        let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
        let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransform)

        // Make the button invisible
        for rateButton in rateButtons {
            rateButton.transform = moveScaleTransform
            rateButton.alpha = 0
        }

        // Add transform to cllose button
        closeButton.transform = moveDownTransform
    }

    override func viewWillAppear(_ animated: Bool) {

        for rateButton in rateButtons {
            UIView.animate(withDuration: 1, delay: 0.1, options: [], animations: {
                rateButton.alpha = 1.0
                rateButton.transform = .identity
           }, completion: nil)
        }

        // Animate close buttn
        UIView.animate(withDuration: 1, delay: 0.35, options: [], animations: {
            self.closeButton.transform = .identity
       }, completion: nil)
    }

}
