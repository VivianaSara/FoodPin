//
//  RestaurantDiffableDataSource.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 20.04.2022.
//

import UIKit

enum Section {
    case all
}

class RestaurantDiffableDataSource: UITableViewDiffableDataSource<Section, Restaurant> {

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
