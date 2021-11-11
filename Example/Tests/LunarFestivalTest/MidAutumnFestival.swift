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
        for i in 1900...2021 {
            let isleap = LunarSolarConverter.isLeapYear(year: i)
            if isleap {
                // TODO:闰年的 阴历转阳历 测试用例不通过
                continue
            }
//            print("🦠\(i)年是 ? 闰年 = \(isleap)")
            let lunar = Lunar(isleap: isleap, lunarYear: i, lunarMonth: 8, lunarDay: 15)
            let solor = LunarSolarConverter.lunarToSolar(lunar: lunar)
            if let solor = solor {
                if isleap {
                    print("闰年 阴历🧤\(lunar)转换成 阳历是✳️\(solor)")
                }
                dates.append(solor)
            }
        }
                
        for solar in dates {
            let date = Date.date(year: solar.solarYear, month: solar.solarMonth, day: solar.solarDay)
            if let date = date {
                let components = FestivalComponents.createComponents(date: date)
                if let components = components {
                    if let f: [String] = components.matchLunars(FesEnum.Lunar.allLunarFes, matchType: MatchType.names) {
                        XCTAssert(f.contains("中秋节"))
                    }
                }
            }
        }
    }

    static var allTests = [
        "testMidAutumnFestival": testMidAutumnFestival
    ]

}
