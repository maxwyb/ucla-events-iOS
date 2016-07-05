//
//  AddActivityViewController.swift
//  ActivityList
//
//  Created by Yingbo Wang on 7/5/16.
//  Copyright © 2016 Yingbo Wang. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController {

    @IBOutlet weak var newHolder: UITextField!
    @IBOutlet weak var newDescription: UITextField!
    @IBOutlet weak var newDate: UITextField!
    
    @IBAction func saveActivity(sender: AnyObject) {
        
        saveSampleActivities(holder: newHolder.text!, description: newDescription.text!, date: newDate.text!)
        
        //self.dismissViewControllerAnimated(true, completion: nil)
        //self.presentViewController(ActivityTableViewController(), animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
