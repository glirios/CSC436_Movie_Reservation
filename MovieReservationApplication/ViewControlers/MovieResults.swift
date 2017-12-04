//
//  MovieResults.swift
//  MovieReservationApplication
//
//  Created by Bibek Shrestha on 12/3/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import Foundation
import UIKit

class MovieResults : UITableViewController {
    var matchedMovies : [Movies]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(matchedMovies?.description ?? "Empty Array")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchedMovies!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTVCell
        
        let object = matchedMovies![(indexPath as NSIndexPath).row]
        cell.nameLabel.text = object.title
        
        var ratingsCodes = [String]()
        for r in object.ratings {
            ratingsCodes.append(r.code)
        }
        
        cell.ratingLabel.text = ratingsCodes.joined(separator: ",")
        cell.genreLabel.text = object.genres.joined(separator: ",")
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetail" {
            print("Preparing for detail....")
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = matchedMovies[(indexPath as NSIndexPath).row]
                (segue.destination as! MovieDetail).selectedMovie = object
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

