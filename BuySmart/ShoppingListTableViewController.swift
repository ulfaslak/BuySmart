//
//  ShoppingListTableViewController.swift
//  test_Tables2
//
//  Created by Ulf Aslak Jensen on 30/03/15.
//  Copyright (c) 2015 Ulf Aslak Jensen. All rights reserved.
//

import UIKit


// Global shopping list
var shoppingList = [String]()
var shoppingListHistory = [String]()


func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
    let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
    let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
    let blue = CGFloat(rgbValue & 0xFF)/256.0
    
    return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
}



class ShoppingListTableViewController: UITableViewController, UITextFieldDelegate {
    
    var textField: UITextField = UITextField(frame: CGRect(x: 18, y: 9, width: 500.00, height: 30.00))
    let button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    let transition = CATransition()
    
    func addItem() {
        if textField.text != "" {
            print(" with argument: \"\(textField.text)\"\n")
            shoppingList.append(textField.text)
            self.tableView.reloadData()
            textField.text = ""
        } else {
            println(" without argument\n")
        }
        textField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if shoppingList.count == 0 {
            print("Loading shoppingList and shoppingListHistory")
            if NSUserDefaults.standardUserDefaults().objectForKey("shoppingList") != nil {
                shoppingList = NSUserDefaults.standardUserDefaults().objectForKey("shoppingList") as! [String]
            }
            
            if NSUserDefaults.standardUserDefaults().objectForKey("shoppingListHistory") != nil {
                shoppingListHistory = NSUserDefaults.standardUserDefaults().objectForKey("shoppingListHistory") as! [String]
            }
        }
        
        // Setting up text field
        self.view.addSubview(textField)
        textField.borderStyle = UITextBorderStyle.None
        textField.frame = CGRect(x: view.bounds.width*0.225, y: 7.5, width: view.bounds.width*0.75, height: 30)
        textField.placeholder = "Add item..."
        textField.textColor = UIColor.whiteColor()
        textField.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        textField.text = ""
        
        // Setting up add button for text field
        button.frame = CGRect(x: view.bounds.width*0.035, y: 5, width: 30.00, height: 30.00)
        button.setTitle("  ", forState: UIControlState.Normal)
        button.titleLabel!.font = UIFont(name: "HelveticaNeue-Light", size: 25)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        textField.delegate = self
        
        // Setting up background image
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        
        // Remove lines from table cells
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        
        self.title = "Watchlist"
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "noteblock-02"))
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        
        /*
        var logButton : UIBarButtonItem = UIBarButtonItem(title: "RigthButtonTitle", style: UIBarButtonItemStyle.Plain, target: self, action: "")
        
        self.navigationItem.rightBarButtonItem = logButton
        */
        
        /*
        let navigationImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        let navigationImage = UIImage(named: "navigation_grocery_list_image")
        navigationImageView.image = navigationImage
        navigationImageView.contentMode = .ScaleAspectFit
        self.navigationController?.navigationBar.setBackgroundImage(navigationImage,
        forBarMetrics: .Default)
        */
        
    }
    
    func buttonAction(sender:UIButton!)
    {
        print("Add button pressed")
        addItem()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        print("Text field return pressed")
        addItem()
        return true
    }

    
    
    // MARK: - Table view data source
    
    
    // ## Initialize ##
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Control number of sections in table.
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Number of rows in sections.
        
        switch section {
        case 0:
            //println("initiating rows in section 0")
            return 1
        case 1:
            //println("initiating rows in section 1")
            return shoppingList.count
        case 2:
            //println("initiating rows in section 2")
            return shoppingListHistory.count
        default:
            return 0
        }
    }
    
    
    
    // ## Cells ##
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Content of each row in table.
        
        var cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath) as! UITableViewCell
        
        for view in cell.subviews{
            if _stdlib_getDemangledTypeName(view) == "UIImageView"{
                view.removeFromSuperview()
            }
        }
        
        // Clear up startup background
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        
        switch indexPath.section {
        case 0:
            var imageViewAddItem = UIImageView(frame: CGRectMake(0, 0, cell.frame.width, cell.frame.height))
            let imageAddItem = UIImage(named: "row_add_item")
            imageViewAddItem.image = imageAddItem
            cell.addSubview(imageViewAddItem)
            cell.sendSubviewToBack(imageViewAddItem)
        case 1:
            // Assigning text to rows
            let itemsString = "\(shoppingList[indexPath.row])"
            cell.textLabel?.attributedText = NSMutableAttributedString(string: "   " + itemsString, attributes: [NSStrikethroughStyleAttributeName : 0])
            cell.textLabel?.textColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 18)
            
            // Add background to cells
            var imageViewChecked = UIImageView(frame: CGRectMake(0, 0, cell.frame.width, cell.frame.height))
            let imageChecked = UIImage(named: "row_new_item")
            imageViewChecked.image = imageChecked
            cell.addSubview(imageViewChecked)
            cell.sendSubviewToBack(imageViewChecked)
        default:
            // Defining gray strikethrough text
            let itemsString = "\(shoppingListHistory[indexPath.row])"
            let strikeThroughString = NSMutableAttributedString(string: itemsString, attributes: [NSStrikethroughStyleAttributeName : 1])
            
            // Assigning text to rows
            cell.textLabel?.attributedText = strikeThroughString
            cell.textLabel?.textColor = UIColor.grayColor()
            cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
            cell.backgroundColor = UIColor.clearColor()
        }
        
        return cell
        
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 45
        case 1:
            return 45
        default:
            return 30
        }
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 0 {
            return false // Return NO if you do not want the specified item to be editable.
        } else {
            return true
        }
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("--------\nTAP: Row \(indexPath.row)")
        
        switch indexPath.section {
        case 0:
            println(" in section \(indexPath.section)")
        case 1:
            println(" in section \(indexPath.section)")
            shoppingListHistory.append(shoppingList[indexPath.row])
            shoppingList.removeAtIndex(indexPath.row)
        case 2:
            println(" in section \(indexPath.section)")
            shoppingList.append(shoppingListHistory[indexPath.row])
            shoppingListHistory.removeAtIndex(indexPath.row)
        default:
            println(" ...ran default")
        }
        
        print("\(shoppingList)\t")
        print("\(shoppingListHistory)\n")
        
        // Deselect row
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // Transition
        transition.type = kCATransitionFade
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.fillMode = kCAFillModeForwards
        transition.duration = 0.1
        transition.subtype = kCATransitionFromRight
        self.tableView.layer.addAnimation(transition, forKey: "UITableViewReloadDataAnimationKey")
        self.tableView.reloadData()
    }
    
    // Deleting
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            print("--------\nDELETING: Row \(indexPath.row) in section \(indexPath.section)\n")
            
            switch indexPath.section {
            case 0:
                print("")
            case 1:
                shoppingList.removeAtIndex(indexPath.row)
            case 2:
                shoppingListHistory.removeAtIndex(indexPath.row)
            default:
                print("")
            }
            
            print("\(shoppingList)\t")
            print("\(shoppingListHistory)\n")
            
            // Transition
            transition.type = kCATransitionFade
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.fillMode = kCAFillModeForwards
            transition.duration = 0.1
            transition.subtype = kCATransitionFromRight
            self.tableView.layer.addAnimation(transition, forKey: "UITableViewReloadDataAnimationKey")
            self.tableView.reloadData()
            
        }
    }
    
    
    
    // ## Footer ##
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerCell = tableView.dequeueReusableCellWithIdentifier("listFooter") as! UITableViewCell
        
        switch section {
        case 1:
            footerCell.backgroundColor = UIColor.clearColor()
        default:
            print("")
        }
        return footerCell
        
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 15
        }
    }
    
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
