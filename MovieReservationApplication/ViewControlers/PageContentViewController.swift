//
//  PageContentViewController.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 11/11/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moviePosterView: UIImageView!
    
    var pageIndex : Int = 0
    var labelText : String!
    var moviePosterText : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = labelText
        moviePosterView.image = UIImage(named: moviePosterText)
        
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
