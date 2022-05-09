//
//  RestaurantDetailHeaderView.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 27.04.2022.
//

import UIKit

class RestaurantDetailHeaderView: UIView {

    @IBOutlet private var headerImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = 0
            if let customFont = UIFont(name: "Nunito-Bold", size: 40.0) {
                nameLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
            }
        }
    }

    @IBOutlet private var typeLabel: UILabel! {
        didSet {
            if let customFont = UIFont(name: "Nunito-Bold", size: 20.0) {
                typeLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: customFont)
            }
        }
    }

    @IBOutlet private var ratingImageView: UIImageView!

    func configure(restaurant: Restaurant) {
        self.headerImageView.image = UIImage(data: restaurant.getImage())
        self.typeLabel.text = restaurant.getType()
        self.nameLabel.text = restaurant.getName()
        //self.ratingImageView.image = UIImage(named: restaurant.rating!.rawValue)
    }

    func setRatingImageView(imageRating: String) {
        self.ratingImageView.image = UIImage(named: imageRating)
    }

    func setTransformAlpha(transform: CGAffineTransform, alpha: CGFloat) {
        self.ratingImageView.transform = transform
        self.ratingImageView.alpha = alpha
    }
}
