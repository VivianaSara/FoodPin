//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 08.04.2022.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    lazy var dataSource = configureDataSource()
    enum Section {
        case all
    }
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl",
                           "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery",
                           "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Aenue Meats",
                           "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia",
                           "Royal Oak", "CASK Pub and Kitchen" ]
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier",
                            "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf",
                            "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong",
                               "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York",
                               "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian/ Causual Drink", "French", "Bakery",
                           "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American",
                           "Breakfast & Brunch", "Coffee &Tea", "Coffee & Tea", "Latin American", "Spanish",
                           "Spanish", "Spanish", "British", "Thai"]
    var restaurantIsFavorites = Array(repeating: false, count: 21)

    func configureDataSource() -> UITableViewDiffableDataSource<Section, String > {
        let cellIdentifier = "datacell"
        let dataSource = UITableViewDiffableDataSource<Section, String>(
            tableView: tableView, cellProvider: {[self]tableView, indexPath, restaurantName in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                    as? RestaurantTableViewCell
            else {
                return UITableViewCell()
            }
            cell.configureCell(nameLabel: restaurantName, locationLabel: restaurantLocations[indexPath.row],
                               typeLabel: restaurantTypes[indexPath.row],
                               thumbnailImageView: restaurantImages[indexPath.row])

            cell.setHeartImage(isFavorite: !self.restaurantIsFavorites[indexPath.row])

            return cell
        }
    )
        return dataSource
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create an option menu as an action sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)

        // Add cancel actions
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)

        // Add "Reserve a table" action
        let reserveActionHandler = { (_: UIAlertAction!) -> Void in
        let alertMessage = UIAlertController(title: "Not available yet",
                                             message: "Sorry, this feature is not available yet. Please retry later.",
                                             preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        let reserveAction = UIAlertAction(title: "Reserve a table", style: .default, handler: reserveActionHandler)
        optionMenu.addAction(reserveAction)

        // Mark as favorite action
        let nameAction = restaurantIsFavorites[indexPath.row] ? "Remove from favorite": "Mark as favorite"

        let favoriteAction = UIAlertAction(title: nameAction, style: .default, handler: {(_:
                                                                                            UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath) as? RestaurantTableViewCell
            cell?.setHeartImage(isFavorite: self.restaurantIsFavorites[indexPath.row])

            self.restaurantIsFavorites[indexPath.row] = !self.restaurantIsFavorites[indexPath.row]
        })
        optionMenu.addAction(favoriteAction)

        // IPad configure
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
        }

        // Display the menu
        present(optionMenu, animated: true, completion: nil)

        // Deselect the row
        tableView.deselectRow(at: indexPath, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // IPad configure
        tableView.cellLayoutMarginsFollowReadableWidth = true

        tableView.separatorStyle = .none

        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurantNames, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
