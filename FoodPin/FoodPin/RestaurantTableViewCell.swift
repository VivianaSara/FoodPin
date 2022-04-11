//
//  RestaurantTableViwCell.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 11.04.2022.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var typeLabel: UILabel!
    @IBOutlet private var thumbnailImageView: UIImageView!

    func configureCell(nameLabel: String, locationLabel: String, typeLabel: String, thumbnailImageView: String) -> Void{
        self.thumbnailImageView.image = UIImage(named: thumbnailImageView)
        self.typeLabel.text = typeLabel
        self.locationLabel.text = locationLabel
        self.nameLabel.text = nameLabel
    }
}
