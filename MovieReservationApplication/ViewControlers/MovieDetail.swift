//
//  MovieDetail.swift
//  MovieReservationApplication
//
//  Created by Bibek Shrestha on 12/4/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//
//  Changes have been made that shouldn't have
import Foundation
import UIKit

class MovieDetail : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var selectedMovie : Movies?
    @IBOutlet weak var movieImg: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieRunTime: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieSynopsis: UILabel!
    
    @IBOutlet weak var movieShowTimes: UITableView!
    
    @IBOutlet weak var movieDirector: UILabel!
    @IBOutlet weak var movieActors: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let url = URL(string: "http://tmsimg.com/" + (self.selectedMovie?.imageURL.URL)!)
            //print("Image url: ", url?.absoluteString ?? "")
            let responseData = try? Data(contentsOf: url!)
            let downloadedImage = UIImage(data: responseData!)
            
            DispatchQueue.main.async {
                self.movieImg.image = downloadedImage
            }
            
        }
        movieName.text = selectedMovie?.title
        var ratingsCodes = [String]()
        for r in (selectedMovie?.ratings)! {
            ratingsCodes.append(r.code)
        }
        movieRating.text = ratingsCodes.joined(separator: ", ")
        movieRating.numberOfLines = 10
        movieGenre.text = selectedMovie?.genres.joined(separator: "\n")
        movieRunTime.text = selectedMovie?.runTime
        movieReleaseDate.text = selectedMovie?.releaseDate
        
        let screensize = UIScreen.main.bounds
        let maxChar : Int = Int(screensize.width / 8.5)
        
        let textOnLabel : String = (selectedMovie?.synopsis)!
        let y = String(stride(from: 0, to: textOnLabel.count, by: maxChar).map {
            Array(Array(textOnLabel)[$0..<min($0 + maxChar, Array(textOnLabel).count)])
            }.joined(separator: "\n"))
        
        movieSynopsis.text = y
        movieSynopsis.numberOfLines = 50
        
        movieDirector.text = selectedMovie?.directors.joined(separator: ", ")
        movieActors.text = selectedMovie?.leadCast.joined(separator: "\n")
        movieActors.numberOfLines = 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print ((selectedMovie?.showtimes.count)!)
        return (selectedMovie?.showtimes.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showTimeCell", for: indexPath) as! ShowTimesTVCell
        
        let object = selectedMovie?.showtimes[(indexPath as NSIndexPath).row]
        cell.theatreName.text = object?.theatre.name
        cell.dateTime.text = object?.dateTime
        
        if(object?.barg == 1) {
            cell.theatreName.textColor = UIColor.green
            cell.dateTime.textColor = UIColor.green
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

