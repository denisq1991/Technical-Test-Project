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

// To be displayed in a table on the homescreen
struct ProjectSummary: Project {
    var id: String
    var name: String
    var description: String
    var status: String // make an enum when I know the differences
}

// To be presented by ID on the 2nd VC
struct ProjectDetail: Project {
    var id: String
    var name: String
    var description: String
    var status: String // make an enum when I know the differences
    var subStatus: String // make an enum when I know the differences
    var defaultPrivacy: String // make an enum when I know the differences
    var createdOn: Date
    var startDate: Date
    var logoURL: String
}
