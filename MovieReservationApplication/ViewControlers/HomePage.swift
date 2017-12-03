//
//  HomePage.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 12/2/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import UIKit
import Auth0

class HomePage: UIViewController {
    
    @IBOutlet weak var featuredMovie: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var timer : Timer!
    var updateCounter: Int!
    var arrPagePhoto = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCounter = 0
        arrPagePhoto = ["blade_runner", "thor", "it", "thank_you_for_your_serive", "only_the_brave"]
        pageControl.numberOfPages = arrPagePhoto.count
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector:#selector(updateTimer), userInfo: nil, repeats: true)
        //self.extendedLayoutIncludesOpaqueBars = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc internal func updateTimer() {
        if (updateCounter <= 4) {
            pageControl.currentPage = updateCounter
            featuredMovie.image = UIImage(named: arrPagePhoto[updateCounter])
            updateCounter = updateCounter + 1
        } else {
            updateCounter = 0
        }
    }
    
    @IBAction func LoginButtonAction(_ sender: UIButton) {
        guard let clientInfo = plistValues(bundle: Bundle.main) else { return }
        Auth0
            .webAuth()
            .scope("openid profile")
            .audience("https://" + clientInfo.domain + "/userinfo")
            .start {
                switch $0 {
                case .failure(let error):
                    print("Error: \(error)")
                case .success(let credentials):
                    guard let accessToken = credentials.accessToken else { return }
                    self.showSuccessAlert(accessToken)
                }
        }
    }
    
    fileprivate func showSuccessAlert(_ accessToken: String) {
        let alert = UIAlertController(title: "Success", message: "accessToken: \(accessToken)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

func plistValues(bundle: Bundle) -> (clientId: String, domain: String)? {
    guard
        let path = bundle.path(forResource: "Auth0", ofType: "plist"),
        let values = NSDictionary(contentsOfFile: path) as? [String: Any]
        else {
            print("Missing Auth0.plist file with 'ClientId' and 'Domain' entries in main bundle!")
            return nil
    }
    
    guard
        let clientId = values["ClientId"] as? String,
        let domain = values["Domain"] as? String
        else {
            print("Auth0.plist file at \(path) is missing 'ClientId' and/or 'Domain' entries!")
            print("File currently has the following entries: \(values)")
            return nil
    }
    return (clientId: clientId, domain: domain)
}


