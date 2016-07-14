//
//  ActivityTableViewController.swift
//  ActivityList
//
//  Created by Yingbo Wang on 7/1/16.
//  Copyright © 2016 Yingbo Wang. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

// Global variables and functions 
var activities = [NSManagedObject]();

func saveActivities(title: String, url: String, details: String, location: String, date: String, host: String, tag1: String, tag2: String, tag3: String) {
    // save an activity to Core Data
    // 1
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    
    // 2
    let entity = NSEntityDescription.entityForName("Activity", inManagedObjectContext: managedContext)
    let activity = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
    
    // 3
    activity.setValue(title, forKey: "title")
    activity.setValue(url, forKey: "url")
    activity.setValue(details, forKey: "details")
    activity.setValue(location, forKey: "location")
    activity.setValue(date, forKey: "date")
    activity.setValue(host, forKey: "host")
    activity.setValue(tag1, forKey: "tag1")
    activity.setValue(tag2, forKey: "tag2")
    activity.setValue(tag3, forKey: "tag3")
    
    // 4
    do {
        try managedContext.save()
        activities.append(activity)
    } catch let error as NSError {
        print("Could not save activity. \(error), \(error.userInfo)")
    }
}


class ActivityTableViewController: UITableViewController {
    
    /*
    func loadSampleActivities() {
        
        if activities.count == 0 {
            saveActivities("Jackie Yang", description: "iOS Programming Club: Weekly Meeting #1", date: "July 4th, 2016; Boelter 3400")
            
            saveActivities("Jackie Chan", description: "A quick brown fox jumps over the lazy dog.", date: "February 30th, 2017; Rieber Summit")
            
            print("Save sample activities successful. ")
        }
        /*
        let activity1 = Activity(holder: "Jackie Yang", description: "iOS Programming Club: Weekly Meeting #1", date: "July 4th, 2016; Boelter 3400")
        let activity2 = Activity(holder: "Jackie Chan", description: "A quick brown fox jumps over the lazy dog.", date: "February 30th, 2017; Rieber Summit")
        
        activities += [activity1, activity2]
         */
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        // Fetch events data from server and store to Core Data
        let urlString = "https://ucla-events.herokuapp.com/api/events"
        
        if let url = NSURL(string: urlString) {
            if let data = try? NSData(contentsOfURL: url, options: []) {
                let json = JSON(data: data)
                
                for event in json.arrayValue {
                    let id = event["_id"].stringValue
                    let url = event["url"].stringValue
                    let details = event["details"].stringValue
                    let location = event["location"].stringValue
                    let date = event["date"].stringValue
                    let host = event["host"].stringValue
                    let title = event["title"].stringValue
                    
                    print(id, url, location, date, host, title)
                    
                    let tag1 = event["tags"][0].stringValue
                    let tag2 = event["tags"][1].stringValue
                    let tag3 = event["tags"][2].stringValue
                    print(tag1, tag2, tag3);
                    
                    /*
                    var tag1, tag2, tag3: String
                    for tags in json["tags"].arrayValue {
                        tag1 = tags[0].stringValue
                        tag2 = tags[1].stringValue
                        tag3 = tags[2].stringValue
                        
                        print(tag1, tag2, tag3)
                    }
                    */

                }
            }
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // store sample activities to Core Data if the list is empty
        //loadSampleActivities();
        
        // Fetch activities from Core Data
        // 1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // 2
        let fetchRequest = NSFetchRequest(entityName: "Activity")
        
        // 3
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            activities = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch activities. \(error), \(error.userInfo)")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return activities.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //print("tableView(cellForRowAtIndexPath) called; indexPath.row = ", indexPath.row);
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        // Configure the cell
        let cellIdentifier = "ActivityTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ActivityTableViewCell

        let activity = activities[indexPath.row]
        
        cell.holderLabel.text = activity.valueForKey("host") as? String
        cell.descriptionLabel.text = activity.valueForKey("title") as? String
        cell.dateLabel.text = activity.valueForKey("date") as? String
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None // no cells can be highlighted by tap
        
        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the row from the data source
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.managedObjectContext.deleteObject(activities[indexPath.row])
            
            do {
                try appDelegate.managedObjectContext.save()
                activities.removeAtIndex(indexPath.row)
                
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            } catch let error as NSError {
                print("Could not delete the activity. \(error), \(error.userInfo)")
            }
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
