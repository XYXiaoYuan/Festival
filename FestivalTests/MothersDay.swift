//
//  MothersDay.swift
//  FestivalTests
//
//  Created by MCPhotosiOS on 2019/10/17.
//  Copyright © 2019 MCPhotosiOS. All rights reserved.
//  母亲节的测试用例
//  母亲节-5月的第二个星期日（美国）

import XCTest
@testable import Festival

class MothersDay: XCTestCase {

    // MARK: - 母亲节
    func testMothersDay() {
        
        let dates = [
            Solar(solarYear: 2020, solarMonth: 5, solarDay: 10),
            Solar(solarYear: 2019, solarMonth: 5, solarDay: 12),
            Solar(solarYear: 2018, solarMonth: 5, solarDay: 13),
            Solar(solarYear: 2017, solarMonth: 5, solarDay: 14),
            Solar(solarYear: 2016, solarMonth: 5, solarDay: 8),
            Solar(solarYear: 2015, solarMonth: 5, solarDay: 10),
            Solar(solarYear: 2014, solarMonth: 5, solarDay: 11),
            Solar(solarYear: 2013, solarMonth: 5, solarDay: 12),
            Solar(solarYear: 2012, solarMonth: 5, solarDay: 13),
            Solar(solarYear: 2011, solarMonth: 5, solarDay: 8),
            Solar(solarYear: 2010, solarMonth: 5, solarDay: 9),
            Solar(solarYear: 2009, solarMonth: 5, solarDay: 10),
            Solar(solarYear: 2008, solarMonth: 5, solarDay: 11),
            Solar(solarYear: 2007, solarMonth: 5, solarDay: 13),
            Solar(solarYear: 2006, solarMonth: 5, solarDay: 14),
            Solar(solarYear: 2005, solarMonth: 5, solarDay: 8),
            Solar(solarYear: 2004, solarMonth: 5, solarDay: 9),
            Solar(solarYear: 2003, solarMonth: 5, solarDay: 11),
            Solar(solarYear: 2002, solarMonth: 5, solarDay: 12),
            Solar(solarYear: 2001, solarMonth: 5, solarDay: 13),
            Solar(solarYear: 2000, solarMonth: 5, solarDay: 14)
        ]
        for solar in dates {
            let date = Date.date(year: solar.solarYear, month: solar.solarMonth, day: solar.solarDay)
            if let date = date {
                let f = Festival.festival(date: date)
                XCTAssert(f.contains("母亲节"))
            }
        }
    }

    static var allTests = [
        "testMothersDay": testMothersDay
    ]

}
