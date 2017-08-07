//
//  ContentViewController.swift
//  SplashLogin
//
//  Created by Lynn on 8/6/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOff", style: .plain, target: self, action: #selector (logOff))
        /*let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)*/
        
    }
    
    func logOff(){
        navigationController?.popViewController(animated: false)
    }
    
    /*func appMovedToBackground() {
        print("App moved to background!")
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
