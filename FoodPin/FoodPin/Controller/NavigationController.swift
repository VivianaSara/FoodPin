//
//  NavigationController.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 02.05.2022.
//

import UIKit

class NavigationController: UINavigationController {

    // To changee from default to custom style for navigation bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return topViewController?.preferredStatusBarStyle ?? .default
   }
}
