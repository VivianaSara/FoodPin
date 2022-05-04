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
        navigationItem.backButtonTitle = ""

        // Configure header view
        headerView.configure(restaurant: restaurant)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        // Content not to be blocked by navig. bar (superview)
        tableView.contentInsetAdjustmentBehavior = .never
    }

    func getRestaurat() -> Restaurant { return self.restaurant }
    func setRestaurat(restaurant: Restaurant) { self.restaurant = restaurant }

    // For every appearence, not just for the first loaded
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showMap":
            guard let destinationController = segue.destination as? MapViewController else {
                return
            }

            destinationController.restaurant = restaurant

        case "showReview":
            guard let destinationController = segue.destination as? ReviewViewController else {
                    return
            }

            destinationController.setRestaurant(restaurant: restaurant)

        default: break
        }
    }

    @IBAction func close(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func rateRestaurant(segue: UIStoryboardSegue) {
        guard let identifier = segue.identifier else {
            return
        }

        dismiss(animated: true, completion: {
               if let rating = Restaurant.Rating(rawValue: identifier) {
                   self.restaurant.setRating(rating: rating)
                   self.headerView.setRatingImageView(imageRating: rating.image)
               }

               let scaleTransform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
               self.headerView.setTransformAlpha(transform: scaleTransform, alpha: 0)
               UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3,
                              initialSpringVelocity: 0.7, options: [], animations: {
                   self.headerView.setTransformAlpha(transform: .identity, alpha: 1)
               }, completion: nil)
       })
    }
}

extension RestaurantDetailViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
            tableView.deselectRow(at: indexPath, animated: false)
            return cell

        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RestaurantDetailMapCell.self),
                                                           for: indexPath) as? RestaurantDetailMapCell else {
                return UITableViewCell()
            }

            cell.configure(location: restaurant.getLocation())
            return cell

        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
}
