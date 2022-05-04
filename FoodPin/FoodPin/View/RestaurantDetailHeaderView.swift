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

    @IBOutlet private var heartButton: UIButton!
    @IBOutlet private var ratingImageView: UIImageView!

    func configure(restaurant: Restaurant) {
        self.headerImageView.image = UIImage(named: restaurant.getImage())
        self.typeLabel.text = restaurant.getType()
        self.nameLabel.text = restaurant.getName()
        let heartImage = restaurant.getIsFavorite() ? "heart.fill" : "heart"
        self.heartButton.tintColor = restaurant.getIsFavorite() ? .systemYellow : .white
        self.heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
    }

    func setRatingImageView(imageRating: String) {
        self.ratingImageView.image = UIImage(named: imageRating)
    }

    func setTransformAlpha(transform: CGAffineTransform, alpha: CGFloat) {
        self.ratingImageView.transform = transform
        self.ratingImageView.alpha = alpha
    }
}
