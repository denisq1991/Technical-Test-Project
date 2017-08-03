//
//  ProjectManager.swift
//  teamwork-tech-test
//
//  Created by Denis Quaid on 03/08/2017.
//  Copyright © 2017 Denis Quaid. All rights reserved.
//

import Foundation

final class sharedObjects {
    private init() { }
    static let shared = sharedObjects()
    static var projectManager = ProjectManager()
}

final class ProjectManager {
    
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
    
    func loadProjectDetails(withId id: String,  completion: @escaping (ProjectDetail) -> ()) {
        
        let dataSource = ProjectDetailsDataSource()
        dataSource.fetchProjectDetails(withId: id) { (result) in
            switch result {
            case .success(let projectDetails):
                completion(projectDetails)
            case .failure(let error):
                print("Error fetching events:" + error.localizedDescription)
            }
            
        }
    }
    
    
}
