//
//  Restaurant.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 19.04.2022.
//

import Foundation

struct Restaurant: Hashable {
    private var name: String
    private var type: String
    private var location: String
    private var image: String
    private var isFavorite: Bool
    init(name: String, type: String, location: String, image: String, isFavorite: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isFavorite = isFavorite
}
    init() {
        self.init(name: "", type: "", location: "", image: "", isFavorite: false) }

    func getName() -> String { return self.name }
    func getType() -> String { return self.type }
    func getLocation() -> String { return self.location }
    func getImage() -> String { return self.image }
    func getIsFavorite() -> Bool { return self.isFavorite }
    mutating func setIsFavorite(isFavorite: Bool) { self.isFavorite = isFavorite }
}
