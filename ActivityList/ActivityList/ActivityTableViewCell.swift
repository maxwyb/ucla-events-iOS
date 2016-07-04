//
//  ActivityTableViewCell.swift
//  ActivityList
//
//  Created by Yingbo Wang on 7/1/16.
//  Copyright © 2016 Yingbo Wang. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var holderLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
