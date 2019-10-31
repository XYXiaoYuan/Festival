//
//  LunarFestival.swift
//  FestivalTests
//
//  Created by MCPhotosiOS on 2019/10/17.
//  Copyright © 2019 MCPhotosiOS. All rights reserved.
//  阴历节日测试用例

import XCTest
@testable import Festival

class LunarFestival: XCTestCase {

    // MARK: - 测试阴历节日
    func testLunarFestival() {
        // 除夕
        LunarNewYearsEve().testLunarNewYearsEve()
        
        // 春节
        SpringFestival().testSpringFestival()
                
        // 清明节
        QingmingFestival().testQingmingFestival()
        
        // 端午节
        DragonBoatFestival().testDragonBoatFestival()
        
        // 中秋节
        MidAutumnFestival().testMidAutumnFestival()
        
        // 固定日期的农历节日测试
        testAfterConvertLunarFestival()
    }

    static var allTests = [
        "testLunarFestival": testLunarFestival
    ]
    
    func testAfterConvertLunarFestival() {
        // 端午节
        for i in 1900...2019 {
            let f = Festival.lunarFestival(year: i, month: 5, day: 5)
            XCTAssert(f.contains("端午节"))
        }
        
        // 七夕节
        for i in 1900...2019 {
            let f = Festival.lunarFestival(year: i, month: 7, day: 7)
            XCTAssert(f.contains("七夕节"))
        }
        
        // 中秋节
        for i in 1900...2019 {
            let f = Festival.lunarFestival(year: i, month: 8, day: 15)
            XCTAssert(f.contains("中秋节"))
        }
    }

}
