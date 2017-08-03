//
//  ProjectDetailsDataSource.swift
//  teamwork-tech-test
//
//  Created by Denis Quaid on 03/08/2017.
//  Copyright © 2017 Denis Quaid. All rights reserved.
//

import Foundation
import Alamofire

enum FetchDetailsResult {
    case success(ProjectDetail)
    case failure(Error)
}

typealias FetchDetailsCompletionBlock = (_ result: FetchDetailsResult) -> ()

class ProjectDetailsDataSource {
    
    func fetchProjectDetails(withId id: String, complete: @escaping FetchDetailsCompletionBlock) ->  () {
        guard let host = Bundle.main.object(forInfoDictionaryKey: "host") as? String else {
            print("Missing key in plist")
            return
        }
        let requestUrl = "\(host)projects/\(id).json"
        
        // go to the projects url
        Alamofire.request(requestUrl)
            .authenticate(user: "twp_TEbBXGCnvl2HfvXWfkLUlzx92e3T", password: "x")
            .responseJSON { response in
                switch response.result {
                case .success:
                    guard let responseObject = response.result.value as? [String: Any] else {
                        print("Unexpected object type returned from API")
                        return
                    }
                    
                    // A dictionary containing the project
                    guard let projectDictionary = responseObject["project"] as? [String : Any] else {
                        print("Couldn't parse project, expected a dictionary")
                        return
                    }
                    
                    guard let project = try? ProjectDetail.decode(projectDictionary) else {
                        print("Unable to decode project details")
                        return
                    }
                    
                    complete(.success(project))
                    
                case .failure(let error):
                    complete(.failure(error))
                    return
                }
                
        }
    }
    
}

