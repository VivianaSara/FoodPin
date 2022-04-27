//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 26.04.2022.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var headerView: RestaurantDetailHeaderView!

    private var restaurant: Restaurant = Restaurant.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = false

        // Configure header view
        headerView.configure(restaurant: restaurant)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }

    func getRestaurat() -> Restaurant { return self.restaurant }
    func setRestaurat(restaurant: Restaurant) { self.restaurant = restaurant }
}

extension RestaurantDetailViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: RestaurantDetailTextCell.self),
                for: indexPath) as? RestaurantDetailTextCell else {
                return UITableViewCell()
        }

            cell.setDescriptionLabel(text: restaurant.getDescrption())
            return cell

        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: RestaurantDetailTwoColumnCell.self),
                for: indexPath) as? RestaurantDetailTwoColumnCell else {
                return UITableViewCell()
            }

            cell.configure(address: "Address", fullAddress: restaurant.getLocation(),
                           phone: "Phone", phoneNumber: restaurant.getPhone())
            return cell

        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
}
