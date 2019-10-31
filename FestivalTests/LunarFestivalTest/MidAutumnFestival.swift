//
//  MidAutumnFestival.swift
//  FestivalTests
//
//  Created by MCPhotosiOS on 2019/10/17.
//  Copyright © 2019 MCPhotosiOS. All rights reserved.
//  中秋节的测试用例
//  中秋节-农历八月十五日

import XCTest
@testable import Festival

class MidAutumnFestival: XCTestCase {

    // MARK: - 中秋节
    func testMidAutumnFestival() {
        
        var dates: [Solar] = [Solar]()
        for i in 2000...2019 {
            let isleap = LunarSolarConverter.isLeapYear(year: i)
            if isleap {
                continue
            }
            print("🦠\(i)年是 ? 闰年 = \(isleap)")
            let lunar = Lunar(isleap: isleap, lunarYear: i, lunarMonth: 8, lunarDay: 15)
            let solor = LunarSolarConverter.lunarToSolar(lunar: lunar)
            print("阴历🧤\(lunar)转换成 阳历是✳️\(solor)")
            dates.append(solor)
        }
        
//        let dates = [
//            Solar(solarYear: 2020, solarMonth: 10, solarDay: 1),
//            Solar(solarYear: 2019, solarMonth: 9, solarDay: 13),
//            Solar(solarYear: 2018, solarMonth: 9, solarDay: 24),
//            Solar(solarYear: 2017, solarMonth: 10, solarDay: 4),
//            Solar(solarYear: 2016, solarMonth: 9, solarDay: 15),
//            Solar(solarYear: 2015, solarMonth: 9, solarDay: 27),
//            Solar(solarYear: 2014, solarMonth: 9, solarDay: 8),
//            Solar(solarYear: 2013, solarMonth: 9, solarDay: 19),
//            Solar(solarYear: 2012, solarMonth: 9, solarDay: 30),
//            Solar(solarYear: 2011, solarMonth: 9, solarDay: 12),
//            Solar(solarYear: 2010, solarMonth: 9, solarDay: 22),
//            Solar(solarYear: 2009, solarMonth: 10, solarDay: 3),
//            Solar(solarYear: 2008, solarMonth: 9, solarDay: 14),
//            Solar(solarYear: 2007, solarMonth: 9, solarDay: 25),
//            Solar(solarYear: 2006, solarMonth: 10, solarDay: 6),
//            Solar(solarYear: 2005, solarMonth: 9, solarDay: 18),
//            Solar(solarYear: 2004, solarMonth: 9, solarDay: 28),
//            Solar(solarYear: 2003, solarMonth: 9, solarDay: 11),
//            Solar(solarYear: 2002, solarMonth: 9, solarDay: 21),
//            Solar(solarYear: 2001, solarMonth: 10, solarDay: 1),
//            Solar(solarYear: 2000, solarMonth: 9, solarDay: 12)
//        ]
        
        for solar in dates {
            let date = Date.date(year: solar.solarYear, month: solar.solarMonth, day: solar.solarDay)
            if let date = date {
                let f = Festival.festival(date: date)
                XCTAssert(f.contains("中秋节"))
            }
        }
    }

    static var allTests = [
        "testMidAutumnFestival": testMidAutumnFestival
    ]

}
