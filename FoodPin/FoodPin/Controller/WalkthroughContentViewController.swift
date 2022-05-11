//
//  WalkthroughContentViewController.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 11.05.2022.
//

import UIKit

class WalkthroughContentViewController: UIViewController {

    @IBOutlet private var headingLabel: UILabel!
    @IBOutlet private var subHeadingLabel: UILabel!
    @IBOutlet private var contentImageView: UIImageView!
    private var index = 0
    private var heading = ""
    private var subHeading = ""
    private var imageFile = ""

    private var walkthroughPageViewController: WalkthroughPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        contentImageView.image = UIImage(named: imageFile)
    }

    func configure(index: Int, heading: String, subHeading: String, imageFile: String) {
        self.index = index
        self.heading = heading
        self.subHeading = subHeading
        self.imageFile = imageFile
    }

    func getIndex() -> Int { return self.index}
}
