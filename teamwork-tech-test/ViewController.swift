//
//  ViewController.swift
//  teamwork-tech-test
//
//  Created by Denis Quaid on 01/08/2017.
//  Copyright © 2017 Denis Quaid. All rights reserved.
//

import UIKit

final class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var projectsTableView: UITableView!
    var projectManager: ProjectManager?
    var projectSummaries: [ProjectSummary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
    }
    
    private func configureTableView() {
        self.projectsTableView.register(UINib(nibName: "ProjectSummaryViewCell", bundle: nil), forCellReuseIdentifier: "ProjectSummaryCell")
        self.projectsTableView.tableFooterView = UIView()
        self.projectManager = ProjectManager()
        self.projectManager?.loadProjectSummaries(completion: { (summaries) in
            self.projectSummaries = summaries
            self.projectsTableView.reloadData()
        })
    }

    //MARK: - Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projectSummaries.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.projectsTableView.dequeueReusableCell(withIdentifier: "ProjectSummaryCell", for: indexPath) as?  ProjectSummaryViewCell else {
            print("No ProjectSummaryCell could be found at the current index path")
        }
        
        let project = self.projectSummaries[indexPath.row]
        cell.nameLabel.text = project.name
        cell.statusLabel.text = project.status
        cell.descriptionLabel.text = project.description
        
        return cell
    }
    
    //MARK: - Delegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // get the cell
        let cell = self.projectsTableView.cellForRow(at: indexPath)
        let project = self.projectSummaries[indexPath.row]
        let projectId = project.id
        
        // pass the id to the next view controller
        let storyboard = UIStoryboard.init(name: "Main", bundle:nil)
        let controller = storyboard?.instantiateViewController(withIdentifier: "ProjectDetails") as! WNProductListViewController
    }
    
}

