//
//  TableViewCell.swift
//  Desplegable TableView
//
//  Created by Pablo Guardiola on 04/08/16.
//  Copyright © 2016 Pablo Guardiola. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var opened: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func openCloseButton(sender: UIButton) {
        if !opened {
            opened = true
            frame.size = CGSize(width: frame.size.width, height: frame.size.height * 1.9)
            
            sender.setTitle("Close", forState: .Normal)
        }
        else {
            opened = false
            frame.size = CGSize(width: frame.size.width, height: frame.size.height / 1.9)
            
            sender.setTitle("Open", forState: .Normal)
        }
    }
}
