//
//  stuTableViewCell.swift
//  TextFieldAndTableView
//
//  Created by student on 2018/12/12.
//  Copyright © 2018年 2016110316. All rights reserved.
//

import UIKit

class stuTableViewCell: UITableViewCell {

    @IBOutlet weak var stuNum: UILabel!
    
    @IBOutlet weak var stuName: UILabel!
    
    @IBOutlet weak var stuAge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
