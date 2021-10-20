//
//  MessageTableViewCell.swift
//  ChatApp
//
//  Created by Barış Can Akkaya on 20.10.2021.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    
    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
