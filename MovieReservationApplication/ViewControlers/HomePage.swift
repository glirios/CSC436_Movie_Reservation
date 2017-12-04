//
//  HomePage.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 12/2/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import UIKit
import Auth0

class HomePage: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var featuredMovie: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searched: UILabel!
    
    var timer : Timer!
    var updateCounter: Int!
    var searchActive : Bool?
    
    let moviesCall = "https://data.tmsapi.com/v1.1/movies/MV009897380000/showings?startDate=2017-12-03&zip=93405&api_key=fa4yd8erkydjmhdevq6zb8rz"
    var movieData : [Movies]?
    var movieDataFiltered : [Movies]?
    var API = MovieAPI()
    var date : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        updateCounter = 0
        pageControl.numberOfPages = 5
        timer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector:#selector(updateTimer), userInfo: nil, repeats: true)
        
        print("Getting API Date format")
        print(API.getDate())
        API.getMoviesPlayingLocally(startDate: "", zip: "93405", lat: "", lng: "") { movies in
            self.movieData = movies
            print(self.movieData?.count ?? 0)
        }
        movieDataFiltered = movieData
        searchBar.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //  http://developer.tmsimg.com/
    @objc internal func updateTimer() {
        if (updateCounter <= 4) {
            pageControl.currentPage = updateCounter
            DispatchQueue.global(qos: .userInitiated).async {
                
                let url = URL(string: "http://tmsimg.com/" + (self.movieData![self.updateCounter]).imageURL.URL)
                //print("Image url: ", url?.absoluteString ?? "")
                let responseData = try? Data(contentsOf: url!)
                let downloadedImage = UIImage(data: responseData!)
                
                DispatchQueue.main.async {
                    self.featuredMovie.image = downloadedImage
                }
                
            }
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
                    self.storyboard?.instantiateInitialViewController()
                }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showMovies" {
            let destVC = segue.destination as? MovieResults
            destVC?.matchedMovies = movieDataFiltered
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            // here is text from the search bar
            print(text)
            //print("Search result count: ", movieDataFiltered?.count)
            performSegue(withIdentifier: "showMovies", sender: self)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        movieDataFiltered = searchText.isEmpty ? movieData : movieData?.filter { (item: Movies) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        searched.text = movieDataFiltered?.description
    }
    func getFilteredMovies() -> [Movies] {
        return movieDataFiltered!
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


