//
//  CardTableViewCell.swift
//  KnoWell
//
//  Created by zhaopeng on 2/7/16.
//  Copyright © 2016 MickelStudios. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var secondDescField: UILabel!
    @IBOutlet weak var firstDescField: UILabel!
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var nameField: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
