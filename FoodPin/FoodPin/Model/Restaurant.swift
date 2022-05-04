//
//  Restaurant.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 19.04.2022.
//

import Foundation

struct Restaurant: Hashable {
    enum Rating: String {
        case awesome
        case good
        case okay
        case bad
        case terrible

        var image: String {
            switch self {
            case .awesome: return "love"
            case .good: return "cool"
            case .okay: return "happy"
            case .bad: return "sad"
            case .terrible: return "angry"
            }
        }
    }

    private var name: String
    private var type: String
    private var location: String
    private var image: String
    private var isFavorite: Bool
    private var phone: String = ""
    private var description: String = ""
    private var rating: Rating?

    init(name: String, type: String, location: String, phone: String,
         description: String, image: String, isFavorite: Bool) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isFavorite = isFavorite
        self.phone = phone
        self.description = description
}
    init() {
        self.init(name: "", type: "", location: "", phone: "", description: "", image: "", isFavorite: false) }

    func getName() -> String { return self.name }
    func getType() -> String { return self.type }
    func getLocation() -> String { return self.location }
    func getImage() -> String { return self.image }
    func getIsFavorite() -> Bool { return self.isFavorite }
    func getPhone() -> String { return self.phone }
    func getDescrption() -> String { return self.description }
    mutating func setIsFavorite(isFavorite: Bool) { self.isFavorite = isFavorite }
    mutating func setRating(rating: Rating) { self.rating = rating }
}
