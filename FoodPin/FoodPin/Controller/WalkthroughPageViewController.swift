//
//  WalkthroughPageViewController.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 11.05.2022.
//

import UIKit

protocol WalkthroughPageViewControllerDelegate: AnyObject {
    func didUpdatePageIndex(currentIndex: Int)
}

class WalkthroughPageViewController: UIPageViewController {

    weak var walkthroughDelegate: WalkthroughPageViewControllerDelegate?

    private var pageHeadings = ["CREATE YOUR OWN FOOD GUIDE", "SHOW YOU THE LOCATION", "DISCOVER GREAT RESTAURANTS"]
    private var pageImages = ["onboarding-1", "onboarding-2", "onboarding-3"]
    private var pageSubHeadings = ["Pin your favorite restaurants and create your own food guide",
                                   "Search and locate your favourite restaurant on Maps",
                                   "Find restaurants shared by your friends and other foodies"]
    private var currentIndex = 0

    func getCurrentIndex() -> Int { return self.currentIndex }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the data source to itself
        dataSource = self

        // Create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }

        delegate = self
    }

    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension WalkthroughPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard var index = (viewController as? WalkthroughContentViewController)?.getIndex() else {
            return UIViewController()
        }

        index -= 1
        return contentViewController(at: index)
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard var index = (viewController as? WalkthroughContentViewController)?.getIndex() else {
            return UIViewController()
        }

        index += 1
        return contentViewController(at: index)
    }

    func contentViewController(at index: Int) -> WalkthroughContentViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }

        // Create a new view controller and pass suitable data.
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController {
            pageContentViewController.configure(index: index, heading: pageHeadings[index],
                                                subHeading: pageSubHeadings[index], imageFile: pageImages[index])
            return pageContentViewController
        }

        return nil
    }
}

extension WalkthroughPageViewController: UIPageViewControllerDelegate {
    // The method will be automatically called after a gesture-driven transition completes
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? WalkthroughContentViewController {
                currentIndex = contentViewController.getIndex()
                walkthroughDelegate?.didUpdatePageIndex(currentIndex: contentViewController.getIndex())
            }
        }
    }
}
