//
//  SpringFestival.swift
//  FestivalTests
//
//  Created by MCPhotosiOS on 2019/10/17.
//  Copyright © 2019 MCPhotosiOS. All rights reserved.
//  春节的测试用例

import XCTest
@testable import Festival

class SpringFestival: XCTestCase {

    // MARK: - 春节
    func testSpringFestival() {
        let dates = [
            Solar(solarYear: 2019, solarMonth: 2, solarDay: 5),
            Solar(solarYear: 2018, solarMonth: 2, solarDay: 16),
            Solar(solarYear: 2017, solarMonth: 1, solarDay: 28),
            Solar(solarYear: 2016, solarMonth: 2, solarDay: 8),
            Solar(solarYear: 2015, solarMonth: 2, solarDay: 19),
            Solar(solarYear: 2014, solarMonth: 1, solarDay: 31),
            Solar(solarYear: 2013, solarMonth: 2, solarDay: 10),
            Solar(solarYear: 2012, solarMonth: 1, solarDay: 23),
            Solar(solarYear: 2011, solarMonth: 2, solarDay: 3),
            Solar(solarYear: 2010, solarMonth: 2, solarDay: 14),
            Solar(solarYear: 2009, solarMonth: 1, solarDay: 26),
            Solar(solarYear: 2008, solarMonth: 2, solarDay: 7),
            Solar(solarYear: 2007, solarMonth: 2, solarDay: 18),
            Solar(solarYear: 2006, solarMonth: 1, solarDay: 29),
            Solar(solarYear: 2005, solarMonth: 2, solarDay: 9),
            Solar(solarYear: 2004, solarMonth: 1, solarDay: 22),
            Solar(solarYear: 2003, solarMonth: 2, solarDay: 1),
            Solar(solarYear: 2002, solarMonth: 2, solarDay: 12),
            Solar(solarYear: 2001, solarMonth: 1, solarDay: 24),
            Solar(solarYear: 2000, solarMonth: 2, solarDay: 5)
        ]
        
        for solar in dates {
            let date = Date.date(year: solar.solarYear, month: solar.solarMonth, day: solar.solarDay)
            if let date = date {
                let f = Festival.festival(date: date)
                XCTAssert(f.contains("春节"))
            }
        }
    }

    static var allTests = [
        "testSpringFestival": testSpringFestival
    ]

}
