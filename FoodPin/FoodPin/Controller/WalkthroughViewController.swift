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
            nextButton.setTitle(String(localized: "Skip"), for: .normal)
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
}

extension WalkthroughViewController: WalkthroughPageViewControllerDelegate {
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
}
