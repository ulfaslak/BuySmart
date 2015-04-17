//
//  ETA_API.swift
//  BuySmart
//
//  Created by Henrik Holm on 17/04/15.
//  Copyright (c) 2015 Ulf Aslak Jensen. All rights reserved.
//

import Foundation
import UIKit

class ETA_API {
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    class func getOffersFromWishList(offerWishList: [String], latitude: Double, longitude: Double, radius: Int, completionHandler: ([NSDictionary] -> Void)) {
        
        // Init singleton eta
        let singleton_eta = ETA.SDK()
        
        // Recieved JSON payload from API endpoints
        var storeArray: [JSON] = []
        var offerArray: [JSON] = []
        
        //
        var master: [NSDictionary] = []
        
        var nearby_params: [NSObject: AnyObject] = ["r_lat": latitude, "r_lng": longitude, "r_radius": radius]
        
        var store_id_list: [String] = []
        var storeDict = [String: AnyObject]()
        
        
        let serviceGroup = dispatch_group_create()
        var lengthOfOfferArray: Int = 0
        
        //dispatch_group_enter(serviceGroup)
        
        
        // Get all store_ids for store which are nearby (Radius determines how nearby)
        singleton_eta.api("/v2/stores", type: ETARequestTypeGET, parameters: nearby_params, useCache: true, completion: { (response, error, fromCache) -> Void in
            
            if error == nil {
                let json = JSON(response)
                storeArray = json.arrayValue
                //println(storeArray)
                
                for store in storeArray {
                    
                    var metaData = [String: String]()
                    var offers: [NSDictionary] = []
                    
                    var nameStore = store["branding"]["name"].stringValue
                    var store_id = store["id"].stringValue
                    var street = store["street"].stringValue
                    var city = store["city"].stringValue
                    var zip_code = store["zip_code"].stringValue
                    var dealer_id_store = store["dealer_id"].stringValue
                    var logo = store["branding"]["logo"].stringValue
                    
                    metaData = ["nameStore": nameStore, "store_id": store_id, "street": street, "city": city, "zip_code": zip_code, "dealer_id_store": dealer_id_store, "logo": logo]
                    
                    //store_id_list.append(store_id)
                    
                    //println("Butiks ID: \(store_id)")
                    
                    var offset = 0
                    var limit = 100
                    
                    // Loop through the offers for the specific store id - only possible to request 100 offers each time
                    // A while loop would be more suitable, but I dont know when to stop, as the length of the offerArray can not be counted as it is cant be accessed outside of the closure.
                    for x in 1...3 {
                        var store_params: [NSObject: AnyObject] = ["r_lat": latitude, "r_lng": longitude, "r_radius": radius, "store_ids": store_id, "limit": String(limit), "offset": String(offset)]
                        //println(store_params)
                        
                        /*
                        var variable = store_id
                        let typeLongName = _stdlib_getDemangledTypeName(variable)
                        let tokens = split(typeLongName, { $0 == "." })
                        if let typeName = tokens.last {
                        //println("Variable \(variable) is of Type \(typeName).")
                        
                        }
                        */
                        
                        dispatch_group_enter(serviceGroup)
                        // Get offers for a specific store_id
                        singleton_eta.api("/v2/offers", type: ETARequestTypeGET, parameters: store_params, useCache: true, completion: { (response, error, fromCache) -> Void in
                            
                            //println(store_params)
                            
                            offerArray = JSON(response).arrayValue
                            //println( "TypeName0 = \(_stdlib_getTypeName(offerArray))")
                            //println(offerArray)
                            //Loop through the recieved offers
                            lengthOfOfferArray = offerArray.count
                            //println(lengthOfOfferArray)
                            
                            for of in offerArray {
                                
                                var nameOffer = of["branding"]["name"].stringValue
                                var dealer_id_offer = of["dealer_id"].stringValue
                                var heading = of["heading"].stringValue
                                var description = of["description"].stringValue
                                var price = of["pricing"]["price"].stringValue
                                var image = of["images"]["view"].stringValue
                                
                                //println(heading)
                                
                                // Loop through our offerWishList
                                for owl in offerWishList {
                                    
                                    //var mystr = "økologisk mammen ost 250 g, 17kr/kg" as NSString!
                                    //var userstr = "ost økologisk mammen"
                                    
                                    var splitOfferWishList = split(owl) {$0 == " "}
                                    
                                    var det = true
                                    for word in splitOfferWishList {
                                        if (heading as NSString).containsString(word) != true {
                                            det = false
                                        }
                                    }
                                    
                                    if det == true {
                                        var offer = Dictionary<String, String>()
                                        offer = ["name_offer": nameOffer, "dealer_id_offer": dealer_id_offer, "heading": heading, "description": description, "price": price, "image": image, "offerWishItem": owl, "store_id": store_id]
                                        
                                        offers.append(offer)
                                    }
                                    
                                    /*
                                    
                                    let headingContainsWish = (heading.lowercaseString as NSString).containsString(owl.lowercaseString)
                                    
                                    // Check if offer match with our wish list
                                    if(headingContainsWish) {
                                    
                                    // Save neccesary meta data about each offer to a tuple array
                                    var offer = Dictionary<String, String>()
                                    offer = ["name_offer": nameOffer, "dealer_id_offer": dealer_id_offer, "heading": heading, "description": description, "price": price, "image": image, "offerWishItem": owl, "store_id": store_id]
                                    
                                    offers.append(offer)
                                    //println(offer)
                                    
                                    }
                                    */
                                }
                            }
                            
                            
                            dispatch_group_leave(serviceGroup)
                            
                        })
                        
                        
                        //println(storeDict)
                        offset = offset + limit + 1
                        
                    }
                    
                    dispatch_group_notify(serviceGroup, dispatch_get_main_queue()) {
                        
                        if offers.count > 0 {
                            storeDict.updateValue(metaData, forKey: "meta_data")
                            storeDict.updateValue(offers, forKey: "offers")  // offers is empty due to its appending inside the closure
                            master.append(storeDict)
                            
                        }
                        
                    }
                    
                }
                
            }
                
            else {
                println(error)
            }
            
            
            //dispatch_group_leave(serviceGroup)
            
            
            //dispatch_group_leave(serviceGroup)
            
            dispatch_group_notify(serviceGroup, dispatch_get_main_queue()) {
                completionHandler(master)
                
                
            }
            
        })
        
    }
    
    
}
