//
//  teamwork_tech_testTests.swift
//  teamwork-tech-testTests
//
//  Created by Denis Quaid on 01/08/2017.
//  Copyright © 2017 Denis Quaid. All rights reserved.
//

import XCTest
@testable import teamwork_tech_test

class teamwork_tech_testTests: XCTestCase {
    
    let detailsDictionary: [String: Any] = [
        "replyByEmailEnabled": true,
        "starred": false,
        "show-announcement": false,
        "harvest-timers-enabled": false,
        "subStatus": "late",
        "status": "active",
        "defaultPrivacy": "open",
        "created-on": "2016-08-20T19:16:13Z",
        "filesAutoNewVersion": false,
        "tags": [],
        "overview-start-page": "default",
        "logo": "https://tw-webserver8.teamworkpm.net/sites/yat/images/companies/113332/projects/1488751730618%5Fthe%2Dwolverine%2Dadamantium%2Dclaws%2Ejpg",
        "startDate": "20160820",
        "id": "301444",
        "last-changed-on": "2017-08-04T09:52:43Z",
        "type": "normal",
        "endDate": "20161208",
        "tasks-start-page": "default",
        "name": "Test Project 1",
        "privacyEnabled": false,
        "description": "Test Description",
        "announcement": "",
        "start-page": "projectoverview",
        "notifyeveryone": false,
        "announcementHTML": ""
    ]
    
    let summaryDictionary: [String: Any] = [
        "replyByEmailEnabled": true,
        "starred": false,
        "show-announcement": false,
        "harvest-timers-enabled": false,
        "status": "active",
        "subStatus": "late",
        "defaultPrivacy": "open",
        "created-on": "2016-08-20T19:16:13Z",
        "filesAutoNewVersion": false,
        "overview-start-page": "default",
        "tags": [],
        "logo": "",
        "startDate": "20160820",
        "id": "301444",
        "last-changed-on": "2017-08-04T09:52:43Z",
        "endDate": "20161208",
        "tasks-start-page": "default",
        "name": "Test Project",
        "privacyEnabled": false,
        "description": "Short Description",
        "announcement": "",
        "isProjectAdmin": true,
        "start-page": "projectoverview",
        "notifyeveryone": false,
        "announcementHTML": ""
    ]
    
    func testProjectSummaryDictionary_WithValidData_shouldReturnValidProjectSummary() {
        guard let summary = try? ProjectSummary.decode(summaryDictionary) else {
            XCTFail()
            return
        }
        
        // I would make ProjectSummary equatable under normal circumstances
        let testData = ProjectSummary.init(id: "301444", name: "Test Project", description: "Short Description", status: "active")
        XCTAssertEqual(summary.id, testData.id)
        XCTAssertEqual(summary.name, testData.name)
        XCTAssertEqual(summary.description, testData.description)
        XCTAssertEqual(summary.status, testData.status)
    }
    
    func testProjectDetailsDictionary_WithValidData_shouldReturnValidProjectSummary() {
        guard let details = try? ProjectDetail.decode(detailsDictionary) else {
            XCTFail()
            return
        }
        
        let testData = ProjectDetail.init(id: "301444", name: "Test Project 1", description: "Test Description", status: "active", subStatus: "late", defaultPrivacy: "open", createdOn: "2016-08-20T19:16:13Z", startDate: "20160820", endDate: "20161208", logoURL: "https://tw-webserver8.teamworkpm.net/sites/yat/images/companies/113332/projects/1488751730618%5Fthe%2Dwolverine%2Dadamantium%2Dclaws%2Ejpg")
        
        XCTAssertEqual(details.id, testData.id)
        XCTAssertEqual(details.name, testData.name)
        XCTAssertEqual(details.description, testData.description)
        XCTAssertEqual(details.status, testData.status)
        XCTAssertEqual(details.subStatus, testData.subStatus)
        XCTAssertEqual(details.defaultPrivacy, testData.defaultPrivacy)
        XCTAssertEqual(details.createdOn, testData.createdOn)
        XCTAssertEqual(details.startDate, testData.startDate)
        XCTAssertEqual(details.endDate, testData.endDate)
        XCTAssertEqual(details.logoURL, testData.logoURL)
    }
    
    func testDateFormatter_WithISOString_shouldReturnFormattedString() {
        // Give an ISO date string
        let isoString = "2016-08-20T19:16:13Z"
        let formattedString = isoString.formattedDateString()
        let expectedString = "20-08-2016"
        
        XCTAssertEqual(formattedString, expectedString)
    }
    
}
