//
//  ViewController.swift
//  teamwork-tech-test
//
//  Created by Denis Quaid on 01/08/2017.
//  Copyright © 2017 Denis Quaid. All rights reserved.
//

import UIKit

final class ProjectSummaryViewController: UIViewController {
    
    @IBOutlet weak var projectsTableView: UITableView!
    fileprivate var projectSummaries: [ProjectSummary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Projects"
        self.configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let lastSelectedRow = self.projectsTableView.indexPathForSelectedRow {
            self.projectsTableView.deselectRow(at: lastSelectedRow, animated: true)
        }
    }
    
    private func configureTableView() {
        self.projectsTableView.register(UINib(nibName: "ProjectSummaryViewCell", bundle: nil), forCellReuseIdentifier: "ProjectSummaryCell")
        self.projectsTableView.tableFooterView = UIView()
        sharedObjects.projectManager.loadProjectSummaries(completion: { (summaries) in
            self.projectSummaries = summaries
            self.projectsTableView.reloadData()
        })
    }
}

//MARK: - Data Source
extension ProjectSummaryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projectSummaries.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.projectsTableView.dequeueReusableCell(withIdentifier: "ProjectSummaryCell", for: indexPath) as?  ProjectSummaryViewCell else {
            print("No ProjectSummaryCell could be found at the current index path")
            return UITableViewCell()
        }
        
        let project = self.projectSummaries[indexPath.row]
        cell.projectId = project.id
        cell.nameLabel.text = project.name
        cell.statusLabel.text = project.status.uppercased()
        cell.descriptionLabel.text = project.description
        
        return cell
    }
}

//MARK: - Delegate
extension ProjectSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = self.projectsTableView.cellForRow(at: indexPath) as? ProjectSummaryViewCell else {
            print("Couldn't find ProjectSummaryViewCell at indexPath: " + String(describing: indexPath))
            return
        }
        
        let storyboard = UIStoryboard.init(name: "ProjectDetails", bundle:nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ProjectDetails") as? ProjectDetailsViewController else {
            print("Couldn't find ProjectDetails view controller")
            return
        }
        controller.projectId = cell.projectId
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

