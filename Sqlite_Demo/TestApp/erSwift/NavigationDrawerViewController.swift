//
//  NavigationDrawerViewController.swift
//  TestApp
//
//  Created by Ashwani Kumar on 24/05/20.
//  Copyright © 2020 ashwani yadav. All rights reserved.
//

import SwiftyJSON
import NVActivityIndicatorView

// Venue Model

struct Venue {
    let name: String
    let venueId: String
    var isSelected = false
    
    init(fromJSON json: JSON) {
        self.name = json["name"].stringValue
        self.venueId = json["id"].stringValue
    }
    
    init(name: String, id: String) {
        self.name = name
        self.venueId = id
    }
}

class NavigationDrawerViewController: UIViewController, NVActivityIndicatorViewable {

    // MARK: Outlets
    
    @IBOutlet weak var menuItemContainerView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    var venueList = [Venue]()
    var savedVenueList = [Venue]()
   private let database = DatabaseHandler()
    // MARK: Properties
    
    weak var delegate: NavigateViaSidePanelDelegate?
    
    private lazy var allMatchesViewController: AllMatchesViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var allMatchesVC = storyboard.instantiateViewController(withIdentifier: "AllMatchesViewController") as! AllMatchesViewController
        allMatchesVC.allMatches = self.venueList
        self.add(asChildViewController: allMatchesVC)

        return allMatchesVC
    }()

    private lazy var savedMatchesViewController: SavedMatchesViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var savedMatchesVC = storyboard.instantiateViewController(withIdentifier: "SavedMatchesViewController") as! SavedMatchesViewController
        savedMatchesVC.savedMatches = self.savedVenueList
        self.add(asChildViewController: savedMatchesVC)
        
        return savedMatchesVC
    }()
    
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apiexecute()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateView(selectedIndex: 0)
       // segmentedControl.addTarget(self, action: indexChanged(), for:.TouchUpInside)
        segmentedControl.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)

    }
    
    
    // MARK: Segment Control Methods
    
   @objc  func indexChanged(_ sender: UISegmentedControl) {
        self.updateView(selectedIndex: sender.selectedSegmentIndex)
    }
    
    
    // MARK: Methods
    
    private func updateView(selectedIndex: Int) {
           
           if selectedIndex == 0 {
              remove(asChildViewController: savedMatchesViewController)
              add(asChildViewController: allMatchesViewController)
           }
           
           if selectedIndex == 1 {
               remove(asChildViewController: allMatchesViewController)
               let savedItems = database.fetchSavedVenues()
               savedMatchesViewController.savedMatches = savedItems
               add(asChildViewController: savedMatchesViewController)
           }
       }
    
    // MARK: - Helper Methods

       private func add(asChildViewController viewController: UIViewController) {
           // Add Child View Controller
        addChildViewController(viewController)

           // Add Child View as Subview
           menuItemContainerView.addSubview(viewController.view)

           // Configure Child View
           viewController.view.frame = menuItemContainerView.bounds
           viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

           // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
       }
       
       private func remove(asChildViewController viewController: UIViewController) {
           // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)

           // Remove Child View From Superview
           viewController.view.removeFromSuperview()

           // Notify Child View Controller
        viewController.removeFromParentViewController()
       }
    
    
    // MARK: API call
    
    func apiexecute() {
             self.startAnimating()
           if(Utilities.startNetworkReachabilityObserver()){
                   let api = Api()
                   api.apiCall(section: "Venue"){
                       responseObject, error in
                       if responseObject != nil{
                           let json = JSON(responseObject!)
                        if !json.isEmpty {
                               print("Response>>>>>>>>>", json)
                               if let venuesItems = json["response"]["venues"].array {
                                          for item in venuesItems {
                                           let aVenue = Venue(fromJSON: item)
                                           self.venueList.append(aVenue)
                                          }
                                   }
                               
                               self.stopAnimating()
                               self.checkSelectedItems()
                               self.updateView(selectedIndex: 0)
                                
                           }else{
                              self.stopAnimating()
                              self.showError(title:"Invalid Deatils", message: "Please Try Again")
                           }
                       }
                       else{
                           print(error!)
                           self.stopAnimating()
                           self.showError(title:"Invalid Deatils", message: "Please Try Again")
                       }
                   }
             
           }else{
               self.stopAnimating()
               self.showError(title: " No Internet Connection", message: "You must connect to the internet to use the Test App")
           }
       }
       
       func showError(title: String, message: String){
          
               let alert = Utilities.customErrorAlertView(errorTitle: "\(title)", errorMessage:  "\(message)", errorButtonTitle: "Ok")
               self.present(alert, animated: true, completion: nil)
           
       }
   
    func checkSelectedItems() {
        let savedItems = database.fetchSavedVenues()
        for (index, item)  in self.venueList.enumerated() {
            for sItems in savedItems {
                if item.venueId == sItems.venueId {
                    self.venueList[index].isSelected = true
                }
            }
        }
    }
}


