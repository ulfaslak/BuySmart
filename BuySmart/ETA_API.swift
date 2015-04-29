//
//  ETA_API.swift
//  BuySmart
//
//  Created by Henrik Holm on 17/04/15.
//  Copyright (c) 2015 Ulf Aslak Jensen. All rights reserved.
//

import CoreLocation
import Foundation
import UIKit

// Extension/functions to calculate days left of offers

extension NSDate {
    
    convenience init(dateString: String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateStringFormatter.timeZone = NSTimeZone(name: "GMT")
        let date = dateStringFormatter.dateFromString(dateString)
        
        self.init(timeInterval:0, sinceDate:date!)
    }
    
    func getDatePart() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        formatter.timeZone = NSTimeZone(name: "GMT")
        
        return formatter.stringFromDate(self)
    }
    
    func daysFrom(date:NSDate) -> Int {
        return NSCalendar.currentCalendar().components(.CalendarUnitDay, fromDate: date, toDate: self, options: nil).day
    }
    func xDays(days: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitDay, value: days, toDate: self, options: nil)!
    }
    func xWeeks(days: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitWeekOfYear, value: days, toDate: self, options: nil)!
    }
}

extension String {
    var asDate: NSDate {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.dateFromString(self)!
    }
}


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
        var stores_limit: Int = 20
        
        var nearby_params: [NSObject: AnyObject] = ["r_lat": latitude, "r_lng": longitude, "r_radius": radius, "limit": stores_limit, "order_by": "distance"]
        
        var store_id_list: [String] = []
        
        
        let serviceGroup = dispatch_group_create()
        var lengthOfOfferArray: Int = 0
        
        //dispatch_group_enter(serviceGroup)
        var queryString:String = ""
        for owl in offerWishList {
            queryString = queryString + " " + owl
        }
        
        
        
        // Get all store_ids for store which are nearby (Radius determines how nearby)
        singleton_eta.api("/v2/stores", type: ETARequestTypeGET, parameters: nearby_params, useCache: true, completion: { (response, error, fromCache) -> Void in
            
            if error == nil {
                let json = JSON(response)
                storeArray = json.arrayValue
                //println(storeArray)
                
                for store in storeArray {
                    
                    var storeDict = [String: AnyObject]()
                    var metaData = [String: AnyObject]()
                    var offers: [NSDictionary] = []
                    
                    var nameStore = store["branding"]["name"].stringValue
                    var store_id = store["id"].stringValue
                    var street = store["street"].stringValue
                    var city = store["city"].stringValue
                    var zip_code = store["zip_code"].stringValue
                    var dealer_id_store = store["dealer_id"].stringValue
                    var logo = store["branding"]["logo"].stringValue
                    var store_latitude = store["latitude"].stringValue
                    var store_longitude = store["longitude"].stringValue
                   
                    let store_loc = CLLocation(latitude: store["latitude"].doubleValue, longitude: store["longitude"].doubleValue)
    
                    let my_loc = CLLocation(latitude: latitude, longitude: longitude)

                    let distance = my_loc.distanceFromLocation(store_loc)
					
                    metaData = ["nameStore": nameStore, "store_id": store_id, "street": street, "city": city, "zip_code": zip_code, "dealer_id_store": dealer_id_store, "logo": logo, "store_latitude ": store_latitude, "store_longitude": store_longitude, "distance": distance]
                    
                    //store_id_list.append(store_id)
                    
                    //println("Butiks ID: \(store_id)")
                    
                    var offset = 0
                    var limit = 100
                    
                    // Loop through the offers for the specific store id - only possible to request 100 offers each time
                    // A while loop would be more suitable, but I dont know when to stop, as the length of the offerArray can not be counted as it is cant be accessed outside of the closure.
                    //for x in 1...1 {
                        var store_params: [NSObject: AnyObject] = ["r_lat": latitude, "r_lng": longitude, "r_radius": radius, "store_ids": store_id, "limit": String(limit), "offset": String(offset), "query": queryString]
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
                        singleton_eta.api("/v2/offers/search", type: ETARequestTypeGET, parameters: store_params, useCache: true, completion: { (response, error, fromCache) -> Void in
                            
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
                                var pre_price = of["pricing"]["pre_price"].stringValue
                                var image = of["images"]["view"].stringValue
                                var run_from = of["run_from"].stringValue
                                var run_till = of["run_till"].stringValue
                                //println(run_from)
                                //println(heading)
                                
                                let run_till_formated = NSDate(dateString: run_till).getDatePart()
                                let run_from_formated = NSDate(dateString: run_from).getDatePart()
                                
                                let days_till_offer_end = run_till_formated.asDate.daysFrom(NSDate())
                              	let days_till_offer_start = run_from_formated.asDate.daysFrom(NSDate())

                                
                                // Loop through our offerWishList
                                for owl in offerWishList {
                                
                                    let headingContainsWish = (heading.lowercaseString as NSString).containsString(owl.lowercaseString)
                                    
                                    // Check if offer match with our wish list
                                    if(headingContainsWish) {
                                    
                                    // Save neccesary meta data about each offer to a tuple array
                                    var offer = Dictionary<String, AnyObject>()
                                        offer = ["name_offer": nameOffer, "dealer_id_offer": dealer_id_offer, "heading": heading, "description": description, "price": price, "pre_price": pre_price, "image": image, "offerWishItem": owl, "store_id": store_id, "days_till_offer_end": days_till_offer_end, "days_till_offer_start": days_till_offer_start]
                                    
                                    offers.append(offer)
                                    //println(offer)
                                    }

                                    
                                    // Old one - to much computation

                                /*
                                    //var mystr = "økologisk mammen ost 250 g, 17kr/kg" as NSString!
                                    //var userstr = "ost økologisk mammen"
                                    
                                    var splitOfferWishList = split(owl) {$0 == " "}
                                    
                                    var det = true
                                    for word in splitOfferWishList {
                                        if (heading as NSString).containsString(word) != true {
                                            det = false
                                            break
                                        }
                                    }
                                    
                                    if det == true {
                                        var offer = Dictionary<String, String>()
                                        offer = ["name_offer": nameOffer, "dealer_id_offer": dealer_id_offer, "heading": heading, "description": description, "price": price, "image": image, "offerWishItem": owl, "store_id": store_id]
                                        
                                        offers.append(offer)
                                    }
                                  */
                                
                                
                                
                                }
                            }
                            
                            
                            dispatch_group_leave(serviceGroup)
                            
                        })
                        
                        
                        //println(storeDict)
                        //offset = offset + limit + 1
                        
                    //}
                    
                    dispatch_group_notify(serviceGroup, dispatch_get_main_queue()) {
                        
                        if offers.count > 0 {
                            storeDict.updateValue(metaData, forKey: "meta_data")
                            storeDict.updateValue(offers, forKey: "offers")
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
