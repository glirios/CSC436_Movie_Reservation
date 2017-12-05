//
//  HomePage.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 12/2/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import UIKit
import Auth0
import TesseractOCR

class HomePage: UIViewController, UISearchBarDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate, G8TesseractDelegate {
    
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
    var imageSearchName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.sizeToFit()
        searchBar.showsBookmarkButton = true
        searchBar.setImage(UIImage(named: "cameraIcon"), for: UISearchBarIcon.bookmark, state: UIControlState.normal)
        
        navigationItem.titleView = searchBar
        
        updateCounter = 0
        pageControl.numberOfPages = 5
        timer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector:#selector(updateTimer), userInfo: nil, repeats: true)
        
        print("Getting API Date format")
        //print(API.getDate())
        API.getMoviesPlayingLocally(startDate: "", zip: "93405", lat: "", lng: "") { movies in
            self.movieData = movies
            //print(self.movieData?.count ?? 0)
        }
        movieDataFiltered = movieData
        searchBar.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
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
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        showImagePicker()
    }
    
    func performImageRecog(image : UIImage) {
        if let tesseract:G8Tesseract = G8Tesseract(language:"eng") {
            tesseract.delegate = self
            tesseract.charWhitelist = "01234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
            let inputImage = image
            tesseract.image = inputImage.g8_blackAndWhite()
            tesseract.recognize()
            imageSearchName = tesseract.recognizedText
        }
        print("Found Text", imageSearchName)
        movieDataFiltered = imageSearchName.isEmpty ? movieData : movieData?.filter { (item: Movies) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.title.range(of: imageSearchName, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        performSegue(withIdentifier: "showMovies", sender: self)
    }
    
    func showImagePicker() {
        let imagePickOptions = UIAlertController(title: "Add or Take Picture", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = UIAlertAction(title: "Take Picture", style: .default) {
                (alert) -> Void in
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
                
            }
            imagePickOptions.addAction(cameraButton)
        }
        
        let uploadButton = UIAlertAction(title: "Upload Picture", style: .default) {
            (alert) -> Void in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        }
        imagePickOptions.addAction(uploadButton)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        imagePickOptions.addAction(cancelButton)
        present(imagePickOptions, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage {
            dismiss(animated: true, completion: {
                self.performImageRecog(image: selectedPhoto)
            })
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


