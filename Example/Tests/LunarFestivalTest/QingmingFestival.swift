//
//  QingmingFestival.swift
//  FestivalTests
//
//  Created by MCPhotosiOS on 2019/10/17.
//  Copyright © 2019 MCPhotosiOS. All rights reserved.
//  清明节的测试用例
//  清明节气一般是在公历4月5号前后，即春分后第15日

import XCTest
@testable import Festival

class QingmingFestival: XCTestCase {

    // MARK: - 清明节
    func testQingmingFestival() {
        let dates = [
            Solar(solarYear: 2021, solarMonth: 4, solarDay: 4),
            Solar(solarYear: 2020, solarMonth: 4, solarDay: 4),
            Solar(solarYear: 2019, solarMonth: 4, solarDay: 5),
            Solar(solarYear: 2018, solarMonth: 4, solarDay: 5),
            Solar(solarYear: 2017, solarMonth: 4, solarDay: 4),
            Solar(solarYear: 2016, solarMonth: 4, solarDay: 4),
            Solar(solarYear: 2015, solarMonth: 4, solarDay: 5),
            Solar(solarYear: 2014, solarMonth: 4, solarDay: 5),
            Solar(solarYear: 2013, solarMonth: 4, solarDay: 4),
            Solar(solarYear: 2012, solarMonth: 4, solarDay: 4),
            Solar(solarYear: 2011, solarMonth: 4, solarDay: 5),
            Solar(solarYear: 2010, solarMonth: 4, solarDay: 5),
            Solar(solarYear: 2009, solarMonth: 4, solarDay: 4),
            Solar(solarYear: 2008, solarMonth: 4, solarDay: 4),
            Solar(solarYear: 2007, solarMonth: 4, solarDay: 5),
            Solar(solarYear: 2006, solarMonth: 4, solarDay: 5),
            Solar(solarYear: 2005, solarMonth: 4, solarDay: 5),
            Solar(solarYear: 2004, solarMonth: 4, solarDay: 4),
            Solar(solarYear: 2003, solarMonth: 4, solarDay: 5),
            Solar(solarYear: 2002, solarMonth: 4, solarDay: 5),
            Solar(solarYear: 2001, solarMonth: 4, solarDay: 5),
            Solar(solarYear: 2000, solarMonth: 4, solarDay: 4)
        ]
        for solar in dates {
            let date = Date.date(year: solar.solarYear, month: solar.solarMonth, day: solar.solarDay)
            if let date = date {
                let components = FestivalComponents.createComponents(date: date)
                if let components = components {
                    if let f: [String] = components.matchLunars(FesEnum.Lunar.allLunarFes, matchType: MatchType.names) {
                        XCTAssert(f.contains("清明节"))
                    }
                }
            }
        }
    }

    static var allTests = [
        "testQingmingFestival": testQingmingFestival
    ]

}
