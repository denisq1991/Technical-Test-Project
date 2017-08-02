//
//  ProjectManager.swift
//  teamwork-tech-test
//
//  Created by Denis Quaid on 03/08/2017.
//  Copyright © 2017 Denis Quaid. All rights reserved.
//

import Foundation

final class ProjectManager {
    
    // load project summaries and set self.projects to them
    func loadProjectSummaries(completion: @escaping ([ProjectSummary]) -> ()) {
        
        let dataSource = ProjectSummaryDataSource()
        dataSource.fetchProjects { (result) in
            switch result {
            case .success(let projectSummariesArray):
                completion(projectSummariesArray)
            case .failure(let error):
                print("Error fetching events:" + error.localizedDescription)
            }
        }
        
    }
    
}
