//
//  Activity.swift
//  ActivityList
//
//  Created by Yingbo Wang on 7/1/16.
//  Copyright © 2016 Yingbo Wang. All rights reserved.
//

import UIKit

class Activity: NSObject {
    
    var holder: String
    var descript: String
    var date: String
    
    init(holder who: String, description what: String, date when: String) {
        holder = who;
        descript = what;
        date = when;
    }
}
