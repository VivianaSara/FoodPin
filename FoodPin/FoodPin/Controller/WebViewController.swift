//
//  WebViewController.swift
//  FoodPin
//
//  Created by Viviana Mesaros on 16.05.2022.
//
import WebKit
import UIKit

class WebViewController: UIViewController {

    @IBOutlet private var webView: WKWebView!
    private var targetURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: targetURL) {
                let request = URLRequest(url: url)
                webView.load(request)
        }
    }

    func setTargetURL(targetURL: String) { self.targetURL = targetURL }
}
