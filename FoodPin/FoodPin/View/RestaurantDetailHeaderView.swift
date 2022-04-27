//
//  RestaurantDetailHeaderView.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 27.04.2022.
//

import UIKit

class RestaurantDetailHeaderView: UIView {

    @IBOutlet private var headerImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var typeLabel: UILabel!
    @IBOutlet private var heartButton: UIButton!

    func configure(restaurant: Restaurant) {
        self.headerImageView.image = UIImage(named: restaurant.getImage())
        self.typeLabel.text = restaurant.getType()
        self.nameLabel.text = restaurant.getName()
        let heartImage = restaurant.getIsFavorite() ? "heart.fill" : "heart"
        self.heartButton.tintColor = restaurant.getIsFavorite() ? .systemYellow : .white
        self.heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
    }
}
