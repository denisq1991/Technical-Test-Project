//
//  ProjectDataSource.swift
//  teamwork-tech-test
//
//  Created by Denis Quaid on 02/08/2017.
//  Copyright © 2017 Denis Quaid. All rights reserved.
//

import Foundation
import Alamofire


enum FetchResult {
    case success([ProjectSummary])
    case failure(Error)
}

typealias FetchCompletionBlock = (_ result: FetchResult) -> ()

class ProjectSummaryDataSource {
    
    func fetchProjects(complete: @escaping FetchCompletionBlock) ->  () {
        
        // TODO: Do this properly from the plist
        let url = "https://yat.teamwork.com/projects.json"
        // token = twp_TEbBXGCnvl2HfvXWfkLUlzx92e3T
        
        // go to the projects url
        Alamofire.request(url)
            .authenticate(user: "twp_TEbBXGCnvl2HfvXWfkLUlzx92e3T", password: "x")
            .responseJSON { response in
            switch response.result {
            case .success:
                guard let responseObject = response.result.value as? [String: Any] else {
                    print("Unexpected object type return from API")
                    return
                }
                
                // A dictionary containing the projects
                guard let projectsDictionary = responseObject["projects"] as? [[String : Any]]else {
                    print("Couldn't parse project summaries, expected an Array")
                    return
                }
                
                // Decode the projects into this array as type [project]
                let projects = projectsDictionary.flatMap { projectDictionary -> ProjectSummary? in
                    return try? ProjectSummary.decode(projectDictionary)
                }
                
                // completion from somewhere that takes the array of projects and displays them
                complete(.success(projects))
                
            case .failure(let error):
                complete(.failure(error))
                return
            }
            
        }
    }
    
}

