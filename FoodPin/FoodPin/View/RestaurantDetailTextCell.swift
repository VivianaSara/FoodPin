//
//  RestaurantDetailTextCell.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 27.04.2022.
//

import UIKit

class RestaurantDetailTextCell: UITableViewCell {

    @IBOutlet private var descriptionLabel: UILabel!
    func setDescriptionLabel(text: String) { self.descriptionLabel.text = text }

}
