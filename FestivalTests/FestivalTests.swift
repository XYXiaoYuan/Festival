//
//  FestivalTests.swift
//  FestivalTests
//
//  Created by MCPhotosiOS on 2019/10/17.
//  Copyright © 2019 MCPhotosiOS. All rights reserved.
//  节日总测试用例

import XCTest
@testable import Festival


class FestivalTests: XCTestCase {

    override func setUp() {

    }

    /// 运行所有的测试用例
    func testAll() {
        let soloar = SoloarFestival()
        soloar.testSoloarFestival()
        soloar.testMonthersDay()
        soloar.testFathersDay()
        
        LunarFestival().testLunarFestival()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            testAll()
        }
    }

    
    func testGroupBy() {
        var str = "SELECT * FROM (SELECT mid.idName, ph.* FROM PhotoIdentityMidTable mid left join PhotoTable ph on mid.photoId = ph.photoId  WHERE ph.status < 2 AND ph.spaceId = 0 ORDER BY ph.createdAt DESC Limit 4 Offset 0) t "
        str = str.group(by: ["idName", "photoId", "createdAt"])//, prefix:"ph.")
        
        print(str)
    }
}

extension String {
    /// 添加分组
    /// - Parameter column: 分组字段
    /// - Parameter prefix: 前缀
    func group(by column: String?, prefix: String? = nil) -> String {
        guard let column = column else { return self }
        
        var condition = ""
        if let prefix = prefix {
            condition = prefix + column
        } else {
            condition = column
        }
        
        if self.contains("GROUP BY") || self.contains("group by") {
            let sql = self + condition
            return sql
        } else {
            let sql = self + " GROUP BY \(condition)"
            return sql
        }
    }
    
    func group(by columns: [String]?, prefix: String? = nil) -> String {
        guard let columns = columns else { return self }
        
        let values = columns.map { (value) -> String in
            var condition = ""
            if let prefix = prefix {
                condition = prefix + value
            } else {
                condition = value
            }
            return condition
        }
        
        
        if self.contains("GROUP BY") || self.contains("group by") {
            let sql = self + values.joined(separator: ", ")
            return sql
        } else {
            let sql = self + " GROUP BY \(values.joined(separator: ", "))"
            return sql
        }
    }

}
