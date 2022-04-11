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
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Aenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional","Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, String >{
        let cellIdentifier = "datacell"
        let dataSource = UITableViewDiffableDataSource<Section, String>(tableView: tableView, cellProvider: { [self]
            tableView, indexPath, restaurantName in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
            cell.configureCell(nameLabel: restaurantName, locationLabel: "Location", typeLabel: "Type", thumbnailImageView: self.restaurantImages[indexPath.row])

            return cell
        }
    )
        return dataSource
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurantNames, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
