//
//  Project+Decodable.swift
//  teamwork-tech-test
//
//  Created by Denis Quaid on 02/08/2017.
//  Copyright © 2017 Denis Quaid. All rights reserved.
//

import Foundation
import Decodable

extension ProjectSummary: Decodable {
    static func decode(_ json: Any) throws -> ProjectSummary {
        return try self.init(id: json => "id",
                             name: json => "name",
                             description: json => "description",
                             status: json => "status")
        
    }
}

extension ProjectDetail: Decodable {
    static func decode(_ json: Any) throws -> ProjectDetail {
        return try self.init(id: json => "id",
                             name: json => "name",
                             description: json => "description",
                             status: json => "status",
                             subStatus:json => "subStatus",
                             defaultPrivacy: json => "defaultPrivacy",
                             createdOn: json => "created-on",
                             startDate: json => "startDate",
                             endDate: json => "endDate",
                             logoURL: json => "logo")
    }
}
