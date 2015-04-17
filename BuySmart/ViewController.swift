//
//  ViewController.swift
//  BuySmart
//
//  Created by Ulf Aslak Jensen on 15/04/15.
//  Copyright (c) 2015 Ulf Aslak Jensen. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        // Input parameters
        var offerWishList: [String] = ["Kød"]
        var latitude = 55.785574
        var longitude = 12.52138100000002
        var radius = 1150
        var masterview: [NSDictionary] = []
        
        
        ETA_API.getOffersFromWishList(offerWishList, latitude: latitude, longitude: longitude, radius: radius) { (master) -> Void in
            var masterArray: JSON = []
            masterArray = JSON(master)
            println(masterArray)
            super.viewDidLoad()

        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

