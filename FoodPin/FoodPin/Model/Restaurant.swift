//
//  Restaurant.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 19.04.2022.
//

import Foundation
import CoreData
import UIKit

public class Restaurant: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant")
    }

    @NSManaged private var name: String
    @NSManaged private var type: String
    @NSManaged private var location: String
    @NSManaged private var phone: String
    @NSManaged private var summary: String
    @NSManaged private var image: Data
    @NSManaged private var ratingText: String?
    @NSManaged private var isFavorite: Bool

    func getName() -> String { return self.name }
    func getType() -> String { return self.type }
    func getLocation() -> String { return self.location }
    func getPhone() -> String { return self.phone }
    func getDescription() -> String { return self.summary }
    func getRatin() -> String? { return self.ratingText }
    func setRating(rating: String) { self.ratingText = rating }
    func getIsFavorite() -> Bool { return self.isFavorite }
    func setIsFavorite(isFavorite: Bool) { self.isFavorite = isFavorite }
    func getImage() -> Data { return self.image }
    func setImage(imageView: Data) { self.image = imageView  }

    func configure(name: String, type: String, description: String, location: String, phone: String, isFavorite: Bool) {
        self.isFavorite = isFavorite
        self.type = type
        self.name = name
        self.summary = description
        self.location = location
        self.phone = phone
        let image = UIImage(named: name.removingWhitespaces())

        if let imageData = image?.pngData() {
            self.image = imageData
        }
    }
}

extension Restaurant {

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

    var rating: Rating? {
        get {
            guard let ratingText = ratingText else {
            return nil
            }

            return Rating(rawValue: ratingText)
        }

        set {
            self.ratingText = newValue?.rawValue
        }
    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined().lowercased()
    }
}
