//
//  WebViewController.swift
//  Week01
//
//  Created by Asif Ahmed Jesi on 31/5/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    let urlInString = "https://en.wikipedia.org/wiki/RGB_color_model"

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: urlInString)!
        let request = URLRequest(url: url)
        webView.load(request)
    }
  
    @IBAction func buttonCloseTapped(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}
