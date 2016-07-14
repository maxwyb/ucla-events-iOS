//
//  AddActivityViewController.swift
//  ActivityList
//
//  Created by Yingbo Wang on 7/5/16.
//  Copyright © 2016 Yingbo Wang. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController, UITextFieldDelegate {

    // MARK: Properties
    @IBOutlet weak var newHolder: UITextField!
    @IBOutlet weak var newDescription: UITextField!
    @IBOutlet weak var newDate: UITextField!
    
    // MARK: Actions
    @IBAction func saveActivity(sender: AnyObject) {
        
        let emptyStringArray = [String]()
        
        saveActivities(newDescription.text!, url: "", details: "", location: "", date: newDate.text!, host: newHolder.text!, tags: emptyStringArray)
        
        //self.dismissViewControllerAnimated(true, completion: nil)
        //self.presentViewController(ActivityTableViewController(), animated: true, completion: nil)
        self.performSegueWithIdentifier("BackToActivityList", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newHolder.delegate = self
        newDescription.delegate = self
        newDate.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
