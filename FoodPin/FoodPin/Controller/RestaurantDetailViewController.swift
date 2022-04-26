//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 26.04.2022.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet private var restaurantImageView: UIImageView!
    @IBOutlet private var restaurantLocation: UILabel!
    @IBOutlet private var restaurantType: UILabel!
    @IBOutlet private var restaurantName: UILabel!
    private var restaurant: Restaurant = Restaurant.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never

        restaurantImageView.image = UIImage(named: restaurant.getImage())
        restaurantName.text = restaurant.getName()
        restaurantType.text = restaurant.getType()
        restaurantLocation.text = restaurant.getLocation()
    }

    func getRestaurat() -> Restaurant {
        return self.restaurant
    }

    func setRestaurat(restaurant: Restaurant) {
        self.restaurant = restaurant
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
