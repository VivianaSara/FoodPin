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

    var restaurants: [Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong",
                   image: "cafedeadend", isFavorite: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong",
                   image: "homei", isFavorite: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavorite: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong",
                   image: "cafeloisl", isFavorite: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong",
                   image: "petiteoyster", isFavorite: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "HongKong",
                   image: "forkee", isFavorite: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier", isFavorite: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney",
                   image: "bourkestreetbakery", isFavorite: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haigh", isFavorite: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney",
                   image: "palomino", isFavorite: false),
        Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isFavorite: false),
        Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isFavorite: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York",
                   image: "graham", isFavorite: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "NewYork",
                   image: "waffleandwolf", isFavorite: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York",
                   image: "fiveleaves", isFavorite: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York",
                   image: "cafelore", isFavorite: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York",
                   image: "confessional", isFavorite: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isFavorite: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isFavorite: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isFavorite: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "cask", isFavorite: false)
    ]

    // MARK: - UITableView Diffable Data Source
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Restaurant > {
        let cellIdentifier = "datacell"
        let dataSource = UITableViewDiffableDataSource<Section, Restaurant>(
            tableView: tableView, cellProvider: {[self]tableView, indexPath, restaurant in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                    as? RestaurantTableViewCell
            else {
                return UITableViewCell()
            }
                cell.configureCell(nameLabel: restaurant.getName(), locationLabel: restaurant.getLocation(),
                                   typeLabel: restaurant.getType(),
                                   thumbnailImageView: restaurant.getImage())

                cell.setHeartImage(isFavorite: !restaurants[indexPath.row].getIsFavorite())

            return cell
        }
    )
        return dataSource
    }

    // MARK: - UITableViewDelegate Protocol
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
        let nameAction = restaurants[indexPath.row].getIsFavorite() ? "Remove from favorite": "Mark as favorite"

        let favoriteAction = UIAlertAction(title: nameAction, style: .default, handler: {(_:
                                                                                            UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath) as? RestaurantTableViewCell
            cell?.setHeartImage(isFavorite: self.restaurants[indexPath.row].getIsFavorite())

            self.restaurants[indexPath.row].setIsFavorite(isFavorite: !self.restaurants[indexPath.row].getIsFavorite())
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

    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // IPad configure
        tableView.cellLayoutMarginsFollowReadableWidth = true

        tableView.separatorStyle = .none

        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
