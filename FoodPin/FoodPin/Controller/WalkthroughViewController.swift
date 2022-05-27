//
//  WalkthroughViewController.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 11.05.2022.
//
import UIKit

class WalkthroughViewController: UIViewController {

    @IBOutlet private var pageControl: UIPageControl!
    @IBOutlet private var nextButton: UIButton! {
        didSet {
            nextButton.setTitle(String(localized: "Next"), for: .normal)
        }
    }

    @IBOutlet private var skipButton: UIButton! {
        didSet {
            skipButton.setTitle(String(localized: "Skip"), for: .normal)
        }
    }

    private var walkthroughPageViewController: WalkthroughPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func skipButtonTapped(sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
        dismiss(animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? WalkthroughPageViewController {
            walkthroughPageViewController = pageViewController
            walkthroughPageViewController?.walkthroughDelegate = self
        }
    }

    @IBAction func nextButtonTapped(sender: UIButton) {
        if let index = walkthroughPageViewController?.getCurrentIndex() {
            switch index {
            case 0...1:
                walkthroughPageViewController?.forwardPage()
            case 2:
                UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
                createQuickActions()
                dismiss(animated: true, completion: nil)
            default: break
            }
        }

        updateUI()
    }

    func updateUI() {
        if let index = walkthroughPageViewController?.getCurrentIndex() {
            switch index {
            case 0...1:
                nextButton.setTitle(String(localized: "NEXT"), for: .normal)
                skipButton.isHidden = false
            case 2:
                nextButton.setTitle(String(localized: "GET STARTED"), for: .normal)
                skipButton.isHidden = true
            default: break
            }

            pageControl.currentPage = index
        }
    }

    func createQuickActions() {
        // Add Quick Actions
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            let shortcutItem1 = UIApplicationShortcutItem(type: "\(bundleIdentifier).OpenFavorites",
                                                          localizedTitle: "Show Favorites",
                                                          localizedSubtitle: nil,
                                                          icon: UIApplicationShortcutIcon(systemImageName: "tag"),
                                                          userInfo: nil)
            let shortcutItem2 = UIApplicationShortcutItem(type: "\(bundleIdentifier).OpenDiscover",
                                                          localizedTitle: "Discover Restaurants",
                                                          localizedSubtitle: nil,
                                                          icon: UIApplicationShortcutIcon(systemImageName: "eyes"),
                                                          userInfo: nil)
            let shortcutItem3 = UIApplicationShortcutItem(type: "\(bundleIdentifier).NewRestaurant",
                                                          localizedTitle: "New Restaurant",
                                                          localizedSubtitle: nil,
                                                          icon: UIApplicationShortcutIcon(type: .add),
                                                          userInfo: nil)
            UIApplication.shared.shortcutItems = [shortcutItem1, shortcutItem2, shortcutItem3]
        }
    }
}

extension WalkthroughViewController: WalkthroughPageViewControllerDelegate {
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
}
