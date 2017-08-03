//
//  ProjectDataSource.swift
//  teamwork-tech-test
//
//  Created by Denis Quaid on 02/08/2017.
//  Copyright © 2017 Denis Quaid. All rights reserved.
//

import Foundation
import Alamofire


enum FetchSummaryResult {
    case success([ProjectSummary])
    case failure(Error)
}

typealias FetchSummaryCompletionBlock = (_ result: FetchSummaryResult) -> ()

class ProjectSummaryDataSource {
    
    func fetchProjects(complete: @escaping FetchSummaryCompletionBlock) ->  () {
        guard let host = Bundle.main.object(forInfoDictionaryKey: "host") as? String,
            let token = Bundle.main.object(forInfoDictionaryKey: "token") as? String else {
                print("Missing key in plist")
                return
        }
        let url = "\(host)/projects.json"
        
        Alamofire.request(url)
            .authenticate(user: token, password: "x")
            .responseJSON { response in
                switch response.result {
                case .success:
                    guard let responseObject = response.result.value as? [String: Any] else {
                        print("Unexpected object type return from API")
                        return
                    }
                    
                    guard let projectsDictionary = responseObject["projects"] as? [[String : Any]]else {
                        print("Couldn't parse project summaries, expected an Array")
                        return
                    }
                    
                    let projects = projectsDictionary.flatMap { projectDictionary -> ProjectSummary? in
                        return try? ProjectSummary.decode(projectDictionary)
                    }
                    
                    complete(.success(projects))
                    
                case .failure(let error):
                    complete(.failure(error))
                    return
                }
                
        }
    }
    
}

