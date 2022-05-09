//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 08.04.2022.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController {

    lazy var dataSource = configureDataSource()
    private var fetchResultController: NSFetchedResultsController<Restaurant>!

    @IBOutlet private var emptyRestaurantView: UIView!

    var restaurants: [Restaurant] = []

    // MARK: - UITableView Diffable Data Source
    func configureDataSource() -> RestaurantDiffableDataSource {
        let cellIdentifier = "datacell"
        let dataSource = RestaurantDiffableDataSource(
            tableView: tableView, cellProvider: {[self]tableView, indexPath, restaurant in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                           for: indexPath) as? RestaurantTableViewCell else {
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

    // MARK: - Share and Delete left swipe action
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
                            indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Get the selected restaurant
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return nil
        }

        // Delete action
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Delete") { (_, _, completionHandler) in
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext

                // Delete the item
                context.delete(restaurant)
                appDelegate.saveContext()

                // Update the view
                self.updateSnapshot(animatingChange: true)
            }

            // Call completion handler to dismiss the action button
            completionHandler(true)
        }

        // Share action
        let shareAction = UIContextualAction(style: .normal,
                                             title: "Share") {(_, _, completionHandler) in
            let defaultText = "Just checking in at " + restaurant.getName()

            let activityController: UIActivityViewController

            if let imageToShare = UIImage(data: restaurant.getImage()) {
                    activityController = UIActivityViewController(activityItems: [defaultText, imageToShare],
                                                                  applicationActivities: nil)
            } else {
                    activityController = UIActivityViewController(activityItems: [defaultText],
                                                                  applicationActivities: nil)
            }

            // IPad configuration
            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }

            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }

        // Configure both actions as swipe action
        deleteAction.backgroundColor = UIColor.systemRed
        deleteAction.image = UIImage(systemName: "trash")
        shareAction.backgroundColor = UIColor.systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")

        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        return swipeConfiguration
    }

    // MARK: - Mark as favorite right-swipe action
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt
                            indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let markAsFavoriteAction = UIContextualAction(style: .normal,
                                                      title: "") { (_, _, completionHandler) in
            guard let cell = tableView.cellForRow(at: indexPath) as? RestaurantTableViewCell else {
                return
            }

            cell.setHeartImage(isFavorite: self.restaurants[indexPath.row].getIsFavorite())

            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {

                // Save isFavorite state
                self.restaurants[indexPath.row].setIsFavorite(isFavorite: !self.restaurants[indexPath.row].getIsFavorite())

                appDelegate.saveContext()
            }

            completionHandler(true)
        }

        markAsFavoriteAction.backgroundColor = UIColor.systemYellow

        switch self.restaurants[indexPath.row].getIsFavorite() {
        case true: markAsFavoriteAction.image = UIImage(systemName: "heart.slash.fill")
        case false: markAsFavoriteAction.image = UIImage(systemName: "heart.fill")
        }

        let swipeConfiguration = UISwipeActionsConfiguration(actions: [markAsFavoriteAction])
        return swipeConfiguration
    }

    // MARK: - DetailViewController connection
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let destinationController = segue.destination as? RestaurantDetailViewController else {
                    return
                }
                destinationController.setRestaurat(restaurant: restaurants[indexPath.row])
            }
        }
    }

    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set emptyImage as backround if there iis no restaurnat
        tableView.backgroundView = emptyRestaurantView
        tableView.backgroundView?.isHidden = restaurants.count == 0 ? false : true

        // Custom the app title (Food Pin)
        if let appearance = navigationController?.navigationBar.standardAppearance {
            appearance.configureWithTransparentBackground()
            if let customFont = UIFont(name: "Nunito-Bold", size: 45.0) {
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!,
                                                       .font: customFont]
            }

            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }

        // Large Title
        navigationController?.navigationBar.prefersLargeTitles = true

        // Back button from DetailView to have no name juust the arrow
        navigationItem.backButtonTitle = ""

        // IPad configure
        tableView.cellLayoutMarginsFollowReadableWidth = true

        // Without separator in tableView
        tableView.separatorStyle = .none

        // The cell has automatic dimension
        tableView.rowHeight = UITableView.automaticDimension

        fetchRestaurantData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // To hide when scoll
        navigationController?.hidesBarsOnSwipe = true

        // Title to be large (not just in the begining )
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Fetch data from data store
    func fetchRestaurantData() {

        // Fetch data from data store
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                               managedObjectContext: context,
                                                               sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                updateSnapshot()
            } catch {
                print(error)
            }
        }
    }

    func updateSnapshot(animatingChange: Bool = false) {
        if let fetchedObjects = fetchResultController.fetchedObjects {
            restaurants = fetchedObjects
        }

        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: animatingChange)
        tableView.backgroundView?.isHidden = restaurants.count == 0 ? false :true
    }
}

extension RestaurantTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            updateSnapshot()
        }
}
