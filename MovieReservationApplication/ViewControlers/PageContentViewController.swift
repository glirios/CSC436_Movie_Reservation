//
//  PageContentViewController.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 11/11/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import UIKit
import CoreImage

class PageContentViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moviePosterView: UIImageView!
    
    var pageIndex : Int = 0
    var labelText : String!
    var moviePosterText : String!
    var image : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = labelText
        image = UIImage(named: moviePosterText)!
        moviePosterView.image = UIImage(named: moviePosterText)!
        
    }
    
}
