//
//  ProjectViewCell.swift
//  teamwork-tech-test
//
//  Created by Denis Quaid on 02/08/2017.
//  Copyright © 2017 Denis Quaid. All rights reserved.
//

import Foundation
import UIKit

class ProjectSummaryViewCell: UITableViewCell {
    var projectId: String = ""
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.nameLabel.text = ""
        self.statusLabel.text = ""
        self.descriptionLabel.text = ""
    }
}
