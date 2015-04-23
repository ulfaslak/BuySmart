//
//  StoreOffersTableViewController.swift
//  test_Tables2
//
//  Created by Ulf Aslak Jensen on 06/04/15.
//  Copyright (c) 2015 Ulf Aslak Jensen. All rights reserved.
//

import UIKit
import Darwin

var dataSource: JSON = []
var sortedStores = [Int]()
var theMaster = [NSDictionary]()

class StoreOffersTableViewController: UITableViewController {
    
    @IBOutlet var radiusSliderValue: UILabel!
    
    @IBOutlet var radiusSliderOutlet: UISlider!
    @IBAction func radiusSlider(sender: AnyObject) {
        radiusSliderValue.text = "\(Int(radiusSliderOutlet.value)) m"
    }
    
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
    
    
    var refresher: UIRefreshControl!
    
    func refresh() {
        var masterview: [NSDictionary] = []
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let locationManager = appDelegate.locationManager
        
        var radius = Int(radiusSliderOutlet.value)
        print(radius)
        var currentLat = 55.706683 //locationManager.location.coordinate.latitude
        var currentLng = 12.542986 //locationManager.location.coordinate.longitude
        
        println(currentLat)
        println(currentLng)
        
        ETA_API.getOffersFromWishList(shoppingList, latitude: currentLat, longitude: currentLng, radius: radius) { (master) -> Void in
            theMaster = master
            dataSource = JSON(master)
            
            // Sort stores
            sortedStores = [Int]()
            var numberOfOffersInStores = [(Int, Int)]()
            var i = 0
            for store in dataSource {
                numberOfOffersInStores.append((i,dataSource[i]["offers"].count))
                i++
            }
            numberOfOffersInStores.sort{ $0.1 != $1.1 ? $0.1 > $1.1 : $0.0 < $1.0 }
            
            for tuple in numberOfOffersInStores{
                sortedStores.append(tuple.0)
            }
            
            self.refresher.endRefreshing()
            self.tableView.reloadData()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("StoreOffersTableViewController viewDidLoad() ran")
        
        if sortedStores.count == 0 {
            println("Loading dataSource and sortedStores")
            if NSUserDefaults.standardUserDefaults().objectForKey("dataSource") != nil {
            
                theMaster = NSUserDefaults.standardUserDefaults().objectForKey("dataSource") as! [NSDictionary]
                dataSource = JSON(theMaster)
                sortedStores = NSUserDefaults.standardUserDefaults().objectForKey("sortedStores") as! [Int]
                println(dataSource.count)
                
                self.tableView.reloadData()
            }
        }
        
        // Set slider value
        radiusSliderValue.text = "\(Int(radiusSliderOutlet.value)) m"
        
        // Pull to refresh
        self.refresher = UIRefreshControl()
        self.refresher.attributedTitle = NSAttributedString(string: "")
        self.refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresher)
        
        // Setting up background image
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        
        // Remove lines from table cells
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    // MARK: - Table view data source
    
    
    // ## Initialize ##
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //println("numberOfSectionsInTableView, return: \(dataSource.count)")
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnObject = dataSource[sortedStores[section]]["offers"].count
        //println("numberOfRowsInSection \(section), return: \(returnObject)")
        return returnObject
    }
    
    // ## Cells ##
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("shoppingCell", forIndexPath: indexPath) as! ShoppingTableViewCell
        
        let numberOfCellsInSection = dataSource[sortedStores[indexPath.section]]["offers"].count
        /*
        print(indexPath.row)
        print(" ")
        println(numberOfCellsInSection)
        */
        if true { //indexPath.row % 2 == 1{
            cell.backgroundColor = UIColor.clearColor()
        }
        
        var imageView = UIImageView(frame: CGRectMake(0, 0, cell.frame.width, cell.frame.height))
        let image = UIImage(named: "storeBackgroundsGreenMid")
        imageView.image = image
        cell.addSubview(imageView)
        cell.sendSubviewToBack(imageView)
        
        // Clear up startup background
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        
        // Add heading label
        cell.headingLabel.text = dataSource[sortedStores[indexPath.section]]["offers"][indexPath.row]["heading"].string
        cell.headingLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        
        // Add description label
        cell.descriptionLabel.text = dataSource[sortedStores[indexPath.section]]["offers"][indexPath.row]["description"].string
        cell.descriptionLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        cell.descriptionLabel.textColor = UIColor.grayColor()
        
        // Add price label
        let priceString = String(Int(ceil(dataSource[sortedStores[indexPath.section]]["offers"][indexPath.row]["price"].floatValue)))
        
        cell.priceLabel.text = priceString + ",-"
        cell.priceLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        cell.priceLabel.textColor = UIColor.blackColor()
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    // ## Header ##
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("shoppingHeader") as! ShoppingTableViewHeaderCell
        
        // Clear up startup background
        headerCell.textLabel?.backgroundColor = UIColor.clearColor()
        
        // Add covering background color
        headerCell.backgroundColor = UIColorFromHex(0x22b8a3, alpha: 1) //UIColor(white: 0.85, alpha: 1)
        
        // Add store image
        // print(dataSource[sortedStores[section]]["meta_data"]["logo"])
        let url = NSURL(string: dataSource[sortedStores[section]]["meta_data"]["logo"].string!)
        let data = NSData(contentsOfURL: url!)
        if data != nil {
            let image = UIImage(data: data!)
            headerCell.imageView?.image = imageResize(image: image!, cellWidth: 45, cellHeight: 45)
        }
        
        // Add store name label
        headerCell.textLabel?.text = dataSource[sortedStores[section]]["meta_data"]["nameStore"].string
        headerCell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        headerCell.textLabel?.textColor = UIColor.whiteColor()
        
        // Add right hand side details
        let address = dataSource[sortedStores[section]]["meta_data"]["street"].string
        let postalCode = dataSource[sortedStores[section]]["meta_data"]["zip_code"].string
        let numberOfOffers = dataSource[sortedStores[section]]["offers"].count
        
        headerCell.rightLabel0.text = address
        headerCell.rightLabel1.text = postalCode
        headerCell.rightLabel2.text = "\(numberOfOffers) offers available"
        
        headerCell.rightLabel0.textColor = UIColor.whiteColor()
        headerCell.rightLabel1.textColor = UIColor.whiteColor()
        headerCell.rightLabel2.textColor = UIColor.whiteColor()
        
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
    /*
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
    }
    */
    
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
