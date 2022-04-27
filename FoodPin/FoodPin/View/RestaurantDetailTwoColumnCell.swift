//
//  RestaurantDetailTwoColumnCell.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 27.04.2022.
//

import UIKit

class RestaurantDetailTwoColumnCell: UITableViewCell {

    @IBOutlet private var addressLabel: UILabel!
    @IBOutlet private var fullAdreessLabel: UILabel!
    @IBOutlet private var phoneLabel: UILabel!
    @IBOutlet private var phoneNumberLabel: UILabel!

    func configure(address: String, fullAddress: String, phone: String, phoneNumber: String) {
        self.phoneLabel.text = phoneNumber.uppercased()
        self.fullAdreessLabel.text = fullAddress
        self.addressLabel.text = address.uppercased()
        self.phoneNumberLabel.text = phoneNumber
    }
}
