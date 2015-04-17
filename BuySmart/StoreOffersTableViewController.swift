//
//  StoreOffersTableViewController.swift
//  test_Tables2
//
//  Created by Ulf Aslak Jensen on 06/04/15.
//  Copyright (c) 2015 Ulf Aslak Jensen. All rights reserved.
//

import UIKit
import Darwin

class StoreOffersTableViewController: UITableViewController {
    
    var master: [[String:AnyObject]] =
    [
        [
            "meta_data":
                [
                    "city": "Kongens Lyngby",
                    "dealer_id_store": "d8adog",
                    "logo": "https://d3ikkoqs9ddhdl.cloudfront.net/img/logo/default/d8adog_3qvn3g8xp.png",
                    "nameStore": "døgnNetto",
                    "store_id": "d2283Zm",
                    "street": "Kollegiebakken 7",
                    "zip_code": "2800",
            ],
            "offers":
                [
                    [
                        "dealer_id_offer": "d8adog",
                        "description": "2 liter ex. emb. pr. liter 6,00",
                        "heading": "Faxe Kondi, Faxe Kondi free, Pepsi Max eller Nikoline",
                        "image": "https://d3ikkoqs9ddhdl.cloudfront.net/img/offer/crop/view/2f25oeq3.jpg?0",
                        "name_offer": "døgnNetto",
                        "offerWishItem": "Faxe Kondi",
                        "price": "12",
                        "store_id": "d2283Zm",
                    ]
            ]
        ],
        [
            "meta_data":
                [
                    "city": "Lyngby",
                    "dealer_id_store": "1e1eB",
                    "logo": "https://d3ikkoqs9ddhdl.cloudfront.net/img/logo/default/1e1eB_2fmm5lbyb.png",
                    "nameStore": "EUROSPAR",
                    "store_id": "0ee1b6m",
                    "street": "Lyngbygårdsvej 141",
                    "zip_code": "2800",
            ],
            "offers":
                [
                    [
                        "dealer_id_offer": "1e1eB",
                        "description": "Skovbær, Vanilje eller Jordbær & Rabarber",
                        "heading": "Cheasy Yoghurt",
                        "image": "https://d3ikkoqs9ddhdl.cloudfront.net/img/offer/crop/view/bf1bgaC3.jpg?0",
                        "name_offer": "EUROSPAR",
                        "offerWishItem": "yoghurt",
                        "price": "11",
                        "store_id": "0ee1b6m",
                    ],
                    [
                        "dealer_id_offer": "1e1eB",
                        "description": "24 dåser 33 cl Pr. ltr. 8,83 v/køb af 24 ds. + Pant Sælges kun i hele rammer. Max. 3x24 dåser pr. kunde Pr. dag",
                        "heading": "Dåse Pepsi, Faxe Kondi eller Pepsi Max",
                        "image": "https://d3ikkoqs9ddhdl.cloudfront.net/img/offer/crop/view/f2889pE3.jpg?0",
                        "name_offer": "EUROSPAR",
                        "offerWishItem": "Faxe Kondi",
                        "price": "69.95",
                        "store_id": "0ee1b6m",
                    ],
                    [
                        "dealer_id_offer": "1e1eB",
                        "description": "Blåbær & Banan, Jordbær, Pære & Banan, Vanilje, Fersken & Hindbær eller Havens Bær 1 ltr. Frit valg",
                        "heading": "Yoggi Yoghurt",
                        "image": "https://d3ikkoqs9ddhdl.cloudfront.net/img/offer/crop/view/7a1eKxE3.jpg?0",
                        "name_offer": "EUROSPAR",
                        "offerWishItem": "yoghurt",
                        "price": "11",
                        "store_id": "0ee1b6m",
                    ],
                    [
                        "dealer_id_offer": "1e1eB",
                        "description": "500 g Pr. kg 30,00",
                        "heading": "Antos ægte Græsk Yoghurt",
                        "image": "https://d3ikkoqs9ddhdl.cloudfront.net/img/offer/crop/view/e6b6AaC3.jpg?0",
                        "name_offer": "EUROSPAR",
                        "offerWishItem": "yoghurt",
                        "price": "15",
                        "store_id": "0ee1b6m",
                    ]
            ],
        ],
        [
            "meta_data":
                [
                    "city": "Kongens Lyngby",
                    "dealer_id_store": "0b1e8",
                    "logo": "https://d3ikkoqs9ddhdl.cloudfront.net/img/logo/default/0b1e8_7lbmygqwm.png",
                    "nameStore": "SuperBrugsen",
                    "store_id": "d5d7DBm",
                    "street": "Lyngbygårdsvej 153",
                    "zip_code": "2800",
            ],
            "offers":
                [
                    [
                        "dealer_id_offer": "0b1e8",
                        "description": "24 x 33 cl Literpris 8,83 + pant. Frit valg",
                        "heading": "Faxe Kondi, Pepsi Max, Pepsi eller Nikoline",
                        "image": "https://d3ikkoqs9ddhdl.cloudfront.net/img/offer/crop/view/529fPlC3.jpg?0",
                        "name_offer": "SuperBrugsen",
                        "offerWishItem": "Faxe Kondi",
                        "price": "69.95",
                        "store_id": "d5d7DBm",
                    ],
                    [
                        "dealer_id_offer": "0b1e8",
                        "description": "1000 g. Kg-pris 15,00. Frit valg",
                        "heading": "Cheasy skyryoghurt",
                        "image": "https://d3ikkoqs9ddhdl.cloudfront.net/img/offer/crop/view/385b8lC3.jpg?0",
                        "name_offer": "SuperBrugsen",
                        "offerWishItem": "yoghurt",
                        "price": "15",
                        "store_id": "d5d7DBm",
                    ],
                    [
                        "dealer_id_offer": "0b1e8",
                        "description": "Nyhed. 1000 g. Kg-pris 14,00. Frit valg",
                        "heading": "Valio yoghurt",
                        "image": "https://d3ikkoqs9ddhdl.cloudfront.net/img/offer/crop/view/cbddylC3.jpg?0",
                        "name_offer": "SuperBrugsen",
                        "offerWishItem": "yoghurt",
                        "price": "14",
                        "store_id": "d5d7DBm",
                    ]
            ],
        ]
    ]
    
    
    func imageResize (#image:UIImage, cellWidth: CGFloat, cellHeight: CGFloat)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        let imageWidth = image.size.width
        let imageHeight = image.size.height
        
        var sizeChange = CGSize(width: cellWidth, height: cellHeight)
        
        if imageWidth > cellWidth {
            let newHeight = imageHeight*cellWidth/imageWidth
            sizeChange = CGSize(width: cellWidth, height: newHeight)
        }
        
        if imageHeight > cellHeight {
            let newWidth = imageWidth*cellHeight/imageHeight
            sizeChange = CGSize(width: newWidth, height: cellHeight)
        }
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
    
    var sortedStores = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up background image
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        
        // Remove lines from table cells
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // Sort stores
        var numberOfOffersInStores = [(Int, Int)]()
        var i = 0
        for store in master {
            numberOfOffersInStores.append((i,(master[i]["offers"] as! NSArray).count))
            i++
        }
        numberOfOffersInStores.sort{ $0.1 != $1.1 ? $0.1 > $1.1 : $0.0 < $1.0 }
        
        for tuple in numberOfOffersInStores{
            sortedStores.append(tuple.0)
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // MARK: - Table view data source
    
    
    // ## Initialize ##
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return master.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (master[sortedStores[section]]["offers"] as! NSArray).count
    }
    
    // ## Cells ##
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("shoppingCell", forIndexPath: indexPath) as! ShoppingTableViewCell
        
        let numberOfCellsInSection = (master[sortedStores[indexPath.section]]["offers"] as! NSArray).count
        
        if indexPath.row % 2 == 1{
            cell.backgroundColor = UIColor.clearColor()
        }
        
        if indexPath.row < numberOfCellsInSection - 1 {
            var imageView = UIImageView(frame: CGRectMake(0, 0, cell.frame.width, cell.frame.height))
            let image = UIImage(named: "storeBackgroundsGreenMid")
            imageView.image = image
            cell.addSubview(imageView)
            cell.sendSubviewToBack(imageView)
        } else {
            var imageView = UIImageView(frame: CGRectMake(0, 0, cell.frame.width, cell.frame.height))
            let image = UIImage(named: "storeBackgroundsGreenBottom")
            imageView.image = image
            cell.addSubview(imageView)
            cell.sendSubviewToBack(imageView)
        }
        
        // Clear up startup background
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        
        // Add heading label
        cell.headingLabel.text = ((master[sortedStores[indexPath.section]]["offers"] as! NSArray)[indexPath.row] as! NSDictionary)["heading"] as? String
        cell.headingLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        
        // Add description label
        cell.descriptionLabel.text = ((master[sortedStores[indexPath.section]]["offers"] as! NSArray)[indexPath.row] as! NSDictionary)["description"] as? String
        cell.descriptionLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        cell.descriptionLabel.textColor = UIColor.grayColor()
        
        // Add price label
        let priceString = String(Int(ceil((((master[sortedStores[indexPath.section]]["offers"] as! NSArray)[indexPath.row] as! NSDictionary)["price"] as! NSString).floatValue)))
        
        cell.priceLabel.text = priceString + ",-"
        cell.priceLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        cell.priceLabel.textColor = UIColor.blackColor()
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    
    // ## Header ##
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("shoppingHeader") as! ShoppingTableViewHeaderCell
        
        // Clear up startup background
        headerCell.textLabel?.backgroundColor = UIColor.clearColor()
        
        // Add covering background color
        headerCell.backgroundColor = UIColorFromHex(0x22b8a3, alpha: 1) //UIColor(white: 0.85, alpha: 1)
        
        // Add store image
        let url = NSURL(string: (master[sortedStores[section]]["meta_data"] as! NSDictionary)["logo"] as! String)
        let data = NSData(contentsOfURL: url!)
        if data != nil {
            let image = UIImage(data: data!)
            headerCell.imageView?.image = imageResize(image: image!, cellWidth: 45, cellHeight: 45)
        }
        
        // Add store name label
        headerCell.textLabel?.text = (master[sortedStores[section]]["meta_data"] as! NSDictionary)["nameStore"] as? String
        headerCell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        
        // Add right hand side details
        let address = (master[sortedStores[section]]["meta_data"] as! NSDictionary)["street"] as! String
        let postalCode = (master[sortedStores[section]]["meta_data"] as! NSDictionary)["zip_code"] as! String
        let numberOfOffers = (master[sortedStores[section]]["offers"] as! NSArray).count
        
        headerCell.rightLabel0.text = address
        headerCell.rightLabel1.text = postalCode
        headerCell.rightLabel2.text = "\(numberOfOffers) offers available"
        
        return headerCell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    
    // ## Footer ##
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerCell = tableView.dequeueReusableCellWithIdentifier("shoppingFooter") as! UITableViewCell
        
        footerCell.backgroundColor = UIColor.clearColor()
        
        return footerCell
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    // Animation
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
