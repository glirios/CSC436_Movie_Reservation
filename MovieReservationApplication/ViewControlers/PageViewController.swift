//
//  PageViewController.swift
//  MovieReservationApplication
//
//  Created by Giovanni Lirios Aguilar on 11/14/17.
//  Copyright © 2017 Giovanni Lirios Aguilar. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var arrPageTitle: NSArray = NSArray()
    var arrPagePhoto: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        arrPageTitle = ["Blade Runner 2049", "Thor: Ragnarok", "IT (2017)", "Thank you for your Service", "Only the Brave"];
        arrPagePhoto = ["blade_runner", "thor", "it", "thank_you_for_your_service", "only_the_brave"];
        // Do any additional setup after loading the view.
        self.dataSource = self
        self.setViewControllers([getViewControllerAtIndex(index: 0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let pageContent: PageContentViewController = viewController as! PageContentViewController
        
        var index = pageContent.pageIndex
        if ((index == 0)  || (index == NSNotFound)) {
            return nil
        }
        index = index - 1
        return getViewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContent: PageContentViewController = viewController as! PageContentViewController
        
        var index = pageContent.pageIndex
        if (index == NSNotFound) {
            return nil
        }
        index = index + 1
        if (index == arrPageTitle.count) {
            return nil
        }
        return getViewControllerAtIndex(index: index)

    }
    
    
    func getViewControllerAtIndex(index: NSInteger) -> PageContentViewController {
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageContentController") as! PageContentViewController

        pageContentViewController.labelText = "\(arrPageTitle[index])"
        pageContentViewController.moviePosterText = "\(arrPagePhoto[index])"
        pageContentViewController.pageIndex = index
        return pageContentViewController
    }

}
