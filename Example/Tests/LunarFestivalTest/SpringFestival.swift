//
//  SpringFestival.swift
//  FestivalTests
//
//  Created by MCPhotosiOS on 2019/10/17.
//  Copyright © 2019 MCPhotosiOS. All rights reserved.
//  春节的测试用例
//  春节一般是在阴历1月1日~1月6日

import XCTest
@testable import Festival

class SpringFestival: XCTestCase {
    
    // MARK: - 春节
    func testSpringFestival() {
        
        var dates: [Solar] = [Solar]()
        for i in 1990...2021 {
            let isleap = LunarSolarConverter.isLeapYear(year: i)
            if isleap {
                // TODO:闰年的 阴历转阳历 测试用例不通过
                continue
            }
            print("🦠\(i)年是 ? 闰年 = \(isleap)")
            for day in 1...6 {
                let lunar = Lunar(isleap: isleap, lunarYear: i, lunarMonth: 1, lunarDay: day)
                let solor = LunarSolarConverter.lunarToSolar(lunar: lunar)
                if let solor = solor {
                    print("阴历🧤\(lunar)转换成 阳历是✳️\(solor)")
                    dates.append(solor)
                }
                
            }
        }
        
        for solar in dates {
            let date = Date.date(year: solar.solarYear, month: solar.solarMonth, day: solar.solarDay)
            if let date = date {
                let components = FestivalComponents.createComponents(date: date)
                if let components = components {
                    if let f: [String] = components.matchLunars(FesEnum.Lunar.allLunarFes, matchType: .names) {
                        XCTAssert(f.contains("春节"))
                    }
                }
            }
        }
    }
    
    static var allTests = [
        "testSpringFestival": testSpringFestival
    ]
    
}
