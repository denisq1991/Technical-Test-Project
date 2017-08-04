//
//  ProjectDetailsViewController.swift
//  teamwork-tech-test
//
//  Created by Denis Quaid on 03/08/2017.
//  Copyright © 2017 Denis Quaid. All rights reserved.
//

import Foundation
import UIKit

enum imageDataError: Error {
    case InvalidData(String)
}

final class ProjectDetailsViewController: UIViewController {
    
    var projectId: String?
    private var spinner: LoadingSpinner?
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var subStatusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var privacyLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.statusLabel.text = ""
        self.subStatusLabel.text = ""
        self.descriptionLabel.text = ""
        self.privacyLabel.text = ""
        self.createdDateLabel.text = ""
        self.startDateLabel.text = ""
        self.endDateLabel.text = ""
        self.logoImageView.image = nil
        
        if self.projectId != nil {
            self.configureProjectDetails()
        }
        
        self.spinner = LoadingSpinner(text: "Loading")
        self.view.addSubview(self.spinner!)
        self.spinner?.backgroundColor = UIColor.lightGray
        self.spinner?.show()
    }
    
    private func configureProjectDetails() {
        sharedObjects.projectManager.loadProjectDetails(withId: self.projectId!) { (project) in
            self.projectId = project.id
            self.title = project.name
            self.statusLabel.text = "Status: " + project.status.uppercased()
            self.subStatusLabel.text = "Sub Status: " + project.subStatus
            self.descriptionLabel.text = project.description
            self.privacyLabel.text = "Privacy: " + project.defaultPrivacy
            
            let createdOnString = project.createdOn.formattedDateString() ?? "N/A"
            let projectStartString = project.startDate.formattedDateString() ?? "N/A"
            let projectEndString = project.endDate.formattedDateString() ?? "N/A"
            
            self.createdDateLabel.text = "Created: " + createdOnString
            self.startDateLabel.text = "Start Date: " + projectStartString
            self.endDateLabel.text = "End Date: " + projectEndString
            
            if let logoURL = URL(string: project.logoURL) {
                do {
                    guard let imageData = try? Data(contentsOf: logoURL) else {
                        throw imageDataError.InvalidData("Couldn't make UIImage from data provided")
                    }
                    self.logoImageView.image = UIImage(data: imageData)
                    self.spinner?.hide()
                } catch {
                    print(error)
                }
            } else {
                self.logoImageView.backgroundColor = UIColor.lightGray
                self.spinner?.hide()
            }
        }
    }
}
