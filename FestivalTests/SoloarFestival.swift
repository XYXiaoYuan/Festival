//
//  SoloarFestival.swift
//  FestivalTests
//
//  Created by MCPhotosiOS on 2019/10/17.
//  Copyright © 2019 MCPhotosiOS. All rights reserved.
//  阳历节日测试用例

import XCTest
@testable import Festival

class SoloarFestival: XCTestCase {
    
    // MARK: - 测试阳历节日
    func testSoloarFestival() {
        for i in 1900...2019 {
            let date = Date.date(year: i, month: 1, day: 1)
            if let date = date {
                let f = Festival.festival(date: date)
                XCTAssert(f.contains("元旦"))
            }
        }
        
//        for i in 1900...2019 {
//            let date = Date.date(year: i, month: 2, day: 14)
//            if let date = date {
//                let f = Festival.festival(date: date)
//                XCTAssert(f.contains("情人节"))
//            }
//        }
        
        for i in 1900...2019 {
            let date = Date.date(year: i, month: 3, day: 8)
            if let date = date {
                let f = Festival.festival(date: date)
                XCTAssert(f.contains("妇女节"))
            }
        }
        
//        for i in 1900...2019 {
//            let date = Date.date(year: i, month: 4, day: 1)
//            if let date = date {
//                let f = Festival.festival(date: date)
//                XCTAssert(f.contains("愚人节"))
//            }
//        }
        
//        for i in 1900...2019 {
//            let date = Date.date(year: i, month: 5, day: 4)
//            if let date = date {
//                let f = Festival.festival(date: date)
//                XCTAssert(f.contains("青年节"))
//            }
//        }
        
        for i in 1900...2019 {
            let date = Date.date(year: i, month: 6, day: 1)
            if let date = date {
                let f = Festival.festival(date: date)
                XCTAssert(f.contains("儿童节"))
            }
        }
        
//        for i in 1900...2019 {
//            let date = Date.date(year: i, month: 8, day: 1)
//            if let date = date {
//                let f = Festival.festival(date: date)
//                XCTAssert(f.contains("建军节"))
//            }
//        }
        
//        for i in 1900...2019 {
//            let date = Date.date(year: i, month: 9, day: 10)
//            if let date = date {
//                let f = Festival.festival(date: date)
//                XCTAssert(f.contains("教师节"))
//            }
//        }
                
        for i in 1949...2050 {
            for day in 1...7 {
                let date = Date.date(year: i, month: 10, day: day)
                if let date = date {
                    let f = Festival.festival(date: date)
                    XCTAssert(f.contains("国庆节"))
                }
            }
        }
        
//        for i in 1900...2019 {
//            let date = Date.date(year: i, month: 12, day: 24)
//            if let date = date {
//                let f = Festival.festival(date: date)
//                XCTAssert(f.contains("平安夜"))
//            }
//        }
//
//        for i in 1900...2019 {
//            let date = Date.date(year: i, month: 12, day: 25)
//            if let date = date {
//                let f = Festival.festival(date: date)
//                XCTAssert(f.contains("圣诞节"))
//            }
//        }
    }
    
    func testMonthersDay() {
        MothersDay().testMothersDay()
    }
    
    func testFathersDay() {
        FathersDay().testFathersDay()
    }

    static var allTests = [
        "testSoloarFestival": testSoloarFestival
    ]

}
