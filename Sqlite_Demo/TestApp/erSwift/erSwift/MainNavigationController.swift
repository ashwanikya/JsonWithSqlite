//
//  MainNavigationController.swift
//  TestApp
//
//  Created by Ashwani Kumar on 24/05/20.
//  Copyright © 2020 ashwani yadav. All rights reserved.
//

import UIKit

import UIKit
import PBRevealViewController

protocol NavigateViaSidePanelDelegate: class {
    
    func navigate(to viewControllerID: String?, in storyboard: UIStoryboard?, sender: Any?, shouldPush: Bool)
    func sendDataFromController(sender: Any)
    // func didSelect(sender: Any?)
}

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupReveal()
        let vc = Constants.Storyboards.main.instantiateViewController(withIdentifier: "MainViewController")
        self.setViewControllers([vc], animated: false)
    }
    
    
    // MARK: Methods
    
    fileprivate func setupReveal() {
        if let navigationDrawer = revealViewController().leftViewController as? NavigationDrawerViewController {
            navigationDrawer.delegate = self
        }
        revealViewController()?.delegate = self
        revealViewController()?.panGestureRecognizer.isEnabled = false
        revealViewController().leftToggleSpringDampingRatio = 1.0
    }
    
    fileprivate func addOverlay() {
        removeOverlay()
        let overlay = UIView(frame: UIScreen.main.bounds)
        overlay.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.7483946918)
        overlay.tag = 107
        view.addSubview(overlay)
    }
    
    fileprivate func removeOverlay() {
        if let overlay = view.viewWithTag(107) {
            overlay.removeFromSuperview()
        }
    }
}

// MARK: PBReveal Methods

extension MainNavigationController: PBRevealViewControllerDelegate {
    
    func revealController(_ revealController: PBRevealViewController!, willHideLeftViewController controller: UIViewController!) {
        removeOverlay()
        revealController.mainViewController?.view.isUserInteractionEnabled = true
    }
    
    func revealController(_ revealController: PBRevealViewController!, willShowLeftViewController controller: UIViewController!) {
        addOverlay()
        revealController.mainViewController?.view.isUserInteractionEnabled = false
    }
}

extension MainNavigationController: NavigateViaSidePanelDelegate {
    
    func sendDataFromController(sender: Any) {
        print("fromwhich vc")
    }
    
    func didSelect(sender: Any?) {
        revealViewController().revealLeftView()
    }
    
    func navigate(to viewControllerID: String?, in storyboard: UIStoryboard?, sender: Any?, shouldPush: Bool) {
        
        var viewController = UIViewController()
        if let storyboard = storyboard {
            revealViewController().revealLeftView()
            if let viewControllerIdentifier = viewControllerID {
                viewController = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
                if shouldPush {
                    pushViewController(viewController, animated: true)
               
                } else {
                    self.setViewControllers([viewController], animated: false)

                }
            }
        } else {
            revealViewController().revealLeftView()

        }
    }
}

