//
//  UIPassingData.swift
//  BT_CoreData
//
//  Created by Hiroshi.Kazuo on 3/25/17.
//  Copyright © 2017 Hiroshi.Kazuo. All rights reserved.
//
//	Supports:
//		extension UIViewController
//		{
//			func sendData(to: UIViewController, data: Any?, identity: Int = 0, delay: Double = 0.25)
//		    func pushData(storyboard: String, controller: String, data: Any?, identity: Int = 0, delay: Double = 0.25)
//		    func popData(data: Any?, identity: Int = 0, delay: Double = 0.25)
//		    func presentData(storyboard: String, controller: String, data: Any?, identity: Int = 0, delay: Double = 0.25)
//		}
//		OR: UIPassingData
//		{
//			    static func pushData(from: UIViewController, storyboard: String, controller: String, data: Any?, identity: Int = 0, delay: Double = 0.25)
//		 	    static func popData(from: UIViewController, data: Any?, identity: Int = 0, delay: Double = 0.25)
//			    static func presentData(from: UIViewController, storyboard: String, controller: String, data: Any?, identity: Int = 0, delay: Double = 0.25)
//		}
//		
//	Requires:
//		-	Your-Controller is a child of UIViewController.
//		
//	Notices:
//		-	pushData & popData: need UINavigationBar relationship between the From and the To.
//		-	presentData: will clean your UI relationship.
//		
//  Version 1.0
//  Change-log:
//      - 
//		

import Foundation
import UIKit

fileprivate struct VC_addedProps {
    static var _oldViewController = [UIViewController: UIViewController]()
}

extension UIViewController {
    internal func uiPassedData(data: Any?, identity: Int) {
        print("This func need override!")
    }
    
    private func receiveData(data: Any?, identity: Int) {
        self.uiPassedData(data: data, identity: identity)
    }
    
    func sendData(to: UIViewController, data: Any?, identity: Int = 0, delay: Double = 0.25){
        VC_addedProps._oldViewController.updateValue(self, forKey: to)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            to.receiveData(data: data, identity: identity)
        })
    }
    
    func pushData(storyboard: String, controller: String, data: Any?, identity: Int = 0, delay: Double = 0.25) {
        if let navigation = self.navigationController {
            let s = UIStoryboard(name: storyboard, bundle: nil)
            let c = s.instantiateViewController(withIdentifier: controller) 
            navigation.pushViewController(c, animated: true)
            self.sendData(to: c, data: data, identity: identity, delay: delay)
        } else {
            print("Can not push from \(self).")
        }
    }
    
    func popData(data: Any?, identity: Int = 0, delay: Double = 0.25) {
        if let navigation = self.navigationController {
            if let old = VC_addedProps._oldViewController[self] {
                navigation.popViewController(animated: true)
                self.sendData(to: old, data: data, identity: identity, delay: delay)
                return
            }
        }
        print("Can not pop from \(self).")
    }
    
    func presentData(storyboard: String, controller: String, data: Any?, identity: Int = 0, delay: Double = 0.25) {
        let s = UIStoryboard(name: storyboard, bundle: nil)
        let c = s.instantiateViewController(withIdentifier: controller) 
        self.present(c, animated: true, completion: {
            self.sendData(to: c, data: data, identity: identity, delay: delay)
        })
    }
}

final class UIPassingData {
    static func pushData(from: UIViewController, storyboard: String, controller: String, data: Any?, identity: Int = 0, delay: Double = 0.25) {
        from.pushData(storyboard: storyboard, controller: controller, data: data, identity: identity, delay: delay)
    }
    
    static func popData(from: UIViewController, data: Any?, identity: Int = 0, delay: Double = 0.25) {
        from.popData(data: data, identity: identity, delay: delay)
    }
    
    static func presentData(from: UIViewController, storyboard: String, controller: String, data: Any?, identity: Int = 0, delay: Double = 0.25) {
        from.presentData(storyboard: storyboard, controller: controller, data: data, identity: identity, delay: delay)
    }
}
