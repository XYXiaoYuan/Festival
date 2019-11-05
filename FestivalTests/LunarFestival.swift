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
    }

    static var allTests = [
        "testLunarFestival": testLunarFestival
    ]
    
}
