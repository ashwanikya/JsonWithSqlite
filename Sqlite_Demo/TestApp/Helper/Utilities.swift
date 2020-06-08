//
//  TestApp
//
//  Created by ashwani yadav on 24/05/20.
//  Copyright © 2020 ashwani yadav. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

import UserNotifications

// MARK: Storyboards Constants

struct Constants {
 static let cornerRadius : CGFloat = 3.0

 struct Storyboards {
    static let main = UIStoryboard(name: "Main", bundle: nil)
 }
    
}

extension UIViewController {
    func setUpNavigationBar() {
           navigationItem.hidesBackButton = true
           navigationController?.navigationBar.viewWithTag(100001)?.removeFromSuperview()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
           navigationController?.navigationBar.tintColor = UIColor.white
           navigationController?.navigationBar.isTranslucent = false
           navigationController?.navigationBar.shadowImage = UIImage()
       }
    func addTitleLabel (text: String = "") {
            guard let navigationBar = self.navigationController?.navigationBar else {
                return
            }
          //  let labelFrame = CGRect.init(x: 55, y: 0, width: 300, height: 44)
            let labelFrame = CGRect(x: navigationBar.frame.size.width/2 - 110, y: 0, width: 250, height: 44)

            let labelSetting = UILabel(frame: labelFrame)
    //        labelSetting.textAlignment = .left
            labelSetting.textAlignment = .center
            labelSetting.tag = 100001
            labelSetting.text = text
            labelSetting.font = UIFont.systemFont(ofSize: 15)
            labelSetting.textColor = UIColor.white
            //labelSetting.numberOfLines = 2
            //labelSetting.lineBreakMode = .byWordWrapping
            self.navigationController?.navigationBar.addSubview(labelSetting)
        }
    
    @objc
       func setupNavigationBarWithMenu(animated : Bool,title : String = "") {
           setUpNavigationBar()
           let backButton  = UIBarButtonItem(image:#imageLiteral(resourceName: "hamburger"), style: .plain, target: self, action: #selector(self.toggleLeftPanel))
           backButton.style = .plain
           self.navigationItem.leftBarButtonItem = backButton
           self.navigationItem.leftItemsSupplementBackButton = true
           if title != "" {
               addTitleLabel(text: "  " +  title)
           }
       }
       
    @objc func toggleLeftPanel() {
        revealViewController().revealLeftView()
    }
}

extension UIView {

/// Smoothens/Sharpens the edges of a View
///
/// - Parameters:
///   - enable: Smoothening/Sharpening of edges toggled with enable
///   - radius: Curve radius for the edges
func round(enable: Bool = true, withRadius radius: CGFloat? = Constants.cornerRadius) {
    let cornerRadius = radius ?? min(bounds.width, bounds.height)/10
    layer.cornerRadius = enable ? cornerRadius : 0
    layer.masksToBounds = enable
}
}

class Utilities{
    

    
    //MARK: NETWORK REACHABILITY
    static func startNetworkReachabilityObserver() -> Bool{
        
        guard let manager = NetworkReachabilityManager(host: "www.apple.com") else {
            
            return false
        }
        manager.startListening()
        if manager.isReachable == false{
            
            if(ShawPulseLoaderView.sharedInstance.isAnimating){
                ShawPulseLoaderView.sharedInstance.stopShawLogoIndicator()
                UIApplication.shared.endIgnoringInteractionEvents()
                
            }
        }
        AshwaniAnalytics.sharedInstance.logEvent(logName: "NetworkReachability \(manager.isReachable.hashValue)")

        return manager.isReachable
        
    }
    
    static func customErrorAlertView (errorTitle:String, errorMessage:String, errorButtonTitle: String) -> UIAlertController{
        
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: errorButtonTitle, style: UIAlertActionStyle.default, handler: nil))
        return alert
        
    }
    
    
    
    }
    



