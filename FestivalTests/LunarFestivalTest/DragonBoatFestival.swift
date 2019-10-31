//
//  DragonBoatFestival.swift
//  FestivalTests
//
//  Created by MCPhotosiOS on 2019/10/17.
//  Copyright © 2019 MCPhotosiOS. All rights reserved.
//  端午节的测试用例
//  端午节-农历五月初五

import XCTest

@testable import Festival

class DragonBoatFestival: XCTestCase {

    // MARK: - 端午节
    func testDragonBoatFestival() {
        
        let dates = [
            Solar(solarYear: 2019, solarMonth: 6, solarDay: 7),
            Solar(solarYear: 2018, solarMonth: 6, solarDay: 18),
            Solar(solarYear: 2017, solarMonth: 5, solarDay: 30),
            Solar(solarYear: 2016, solarMonth: 6, solarDay: 9),
            Solar(solarYear: 2015, solarMonth: 6, solarDay: 20),
            Solar(solarYear: 2014, solarMonth: 6, solarDay: 2),
            Solar(solarYear: 2013, solarMonth: 6, solarDay: 12),
            Solar(solarYear: 2012, solarMonth: 6, solarDay: 23),
            Solar(solarYear: 2011, solarMonth: 6, solarDay: 6),
            Solar(solarYear: 2010, solarMonth: 6, solarDay: 16),
            Solar(solarYear: 2009, solarMonth: 6, solarDay: 27),
            Solar(solarYear: 2008, solarMonth: 6, solarDay: 8),
            Solar(solarYear: 2007, solarMonth: 6, solarDay: 19),
            Solar(solarYear: 2006, solarMonth: 5, solarDay: 31),
            Solar(solarYear: 2005, solarMonth: 6, solarDay: 11),
            Solar(solarYear: 2004, solarMonth: 6, solarDay: 22),
            Solar(solarYear: 2003, solarMonth: 6, solarDay: 4),
            Solar(solarYear: 2002, solarMonth: 6, solarDay: 15),
            Solar(solarYear: 2001, solarMonth: 6, solarDay: 25),
            Solar(solarYear: 2000, solarMonth: 6, solarDay: 6)
        ]
        for solar in dates {
            let date = Date.date(year: solar.solarYear, month: solar.solarMonth, day: solar.solarDay)
            if let date = date {
                let f = Festival.festival(date: date)
                XCTAssert(f.contains("端午节"))
            }
        }
    }

    static var allTests = [
        "testDragonBoatFestival": testDragonBoatFestival
    ]
}
