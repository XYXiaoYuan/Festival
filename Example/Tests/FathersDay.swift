//
//  FathersDay.swift
//  FestivalTests
//
//  Created by MCPhotosiOS on 2019/10/17.
//  Copyright © 2019 MCPhotosiOS. All rights reserved.
//  父亲节的测试用例
//  父亲节-6月的第3个星期日（美国）

import XCTest
@testable import Festival

class FathersDay: XCTestCase {

    // MARK: - 父亲节
    func testFathersDay() {
        
        let dates = [
            Solar(solarYear: 2021, solarMonth: 6, solarDay: 20),
            Solar(solarYear: 2020, solarMonth: 6, solarDay: 21),
            Solar(solarYear: 2019, solarMonth: 6, solarDay: 16),
            Solar(solarYear: 2018, solarMonth: 6, solarDay: 17),
            Solar(solarYear: 2017, solarMonth: 6, solarDay: 18),
            Solar(solarYear: 2016, solarMonth: 6, solarDay: 19),
            Solar(solarYear: 2015, solarMonth: 6, solarDay: 21),
            Solar(solarYear: 2014, solarMonth: 6, solarDay: 15),
            Solar(solarYear: 2013, solarMonth: 6, solarDay: 16),
            Solar(solarYear: 2012, solarMonth: 6, solarDay: 17),
            Solar(solarYear: 2011, solarMonth: 6, solarDay: 19),
            Solar(solarYear: 2010, solarMonth: 6, solarDay: 20),
            Solar(solarYear: 2009, solarMonth: 6, solarDay: 21),
            Solar(solarYear: 2008, solarMonth: 6, solarDay: 15),
            Solar(solarYear: 2007, solarMonth: 6, solarDay: 17),
            Solar(solarYear: 2006, solarMonth: 6, solarDay: 18),
            Solar(solarYear: 2005, solarMonth: 6, solarDay: 19),
            Solar(solarYear: 2004, solarMonth: 6, solarDay: 20),
            Solar(solarYear: 2003, solarMonth: 6, solarDay: 15),
            Solar(solarYear: 2002, solarMonth: 6, solarDay: 16),
            Solar(solarYear: 2001, solarMonth: 6, solarDay: 17),
            Solar(solarYear: 2000, solarMonth: 6, solarDay: 18)
        ]
        for solar in dates {
            let date = Date.date(year: solar.solarYear, month: solar.solarMonth, day: solar.solarDay)
            if let date = date {
                let components = FestivalComponents.createComponents(date: date)
                if let components = components {
                    if let f: [String] = components.matchSolars(FesEnum.Solar.allSolorsFes, matchType: .names) {
                        XCTAssert(f.contains("父亲节"))
                    }
                }
            }
        }
    }

    static var allTests = [
        "testFathersDay": testFathersDay
    ]

}
