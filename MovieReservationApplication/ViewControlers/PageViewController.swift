//
//  PageViewController.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 11/14/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    var arrPageTitle: NSArray = NSArray()
    var arrPagePhoto: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        arrPageTitle = ["Blade Runner 2049", "Thor: Ragnarok", "IT (2017)", "Thank you for your Service", "Only the Brave"];
        arrPagePhoto = ["blade_runner", "thor", "it", "thank_you_for_your_serive", "only_the_brave"];
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
