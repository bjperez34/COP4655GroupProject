//
//  HealthAdviceDetailViewController.swift
//  COP4655GroupProject
//
//  Created by Bert Perez on 4/26/19.
//  Copyright © 2019 kpuli007. All rights reserved.
//

import UIKit

class HealthAdviceDetailController: UIViewController, UINavigationControllerDelegate {
    // initialize webview
    @IBOutlet var youtubeWebView: UIWebView!
    @IBOutlet var videoDescription: UILabel!
    
    func showVideo(videoCode: String) {
        //initialize the constant url for youtube videos
        let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(videoCode)")
        
        if let validURL = youtubeURL {
            youtubeWebView.loadRequest(URLRequest(url: validURL))
        } else {
            print("Invalid URL")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showVideo(videoCode: "dltvLXm2jCA&list=PLdnGsXIc_Vc3T4DsluI8FlQJh6fsCw5Ui&index=2&t=0s")
    }
}
