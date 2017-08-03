//
//  Project.swift
//  teamwork-tech-test
//
//  Created by Denis Quaid on 02/08/2017.
//  Copyright © 2017 Denis Quaid. All rights reserved.
//

import Foundation

protocol Project {
    var id: String { get }
    var name: String { get }
    var description: String { get }
    var status: String { get }
}

struct ProjectSummary: Project {
    var id: String
    var name: String
    var description: String
    var status: String
}

struct ProjectDetail: Project {
    var id: String
    var name: String
    var description: String
    var status: String
    var subStatus: String
    var defaultPrivacy: String
    var createdOn: String
    var startDate: String
    var endDate: String
    var logoURL: String
}
