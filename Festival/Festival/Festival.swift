//
//  Festival.swift
//  PhotoGallery
//
//  Created by MCPhotosiOS on 2019/10/17.
//  Copyright © 2019 Mi Cheng. All rights reserved.
//

import Foundation

class Festival {
    /// 节日
    private static func festivalIndex(_ month: Int, _ day: Int) -> Int {
        return month * 100 + day
    }
    
    /// 获取节日
    /// - Parameter date: 日期对象
    public static func festival(date: Date) -> [String] {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday, .weekdayOrdinal, .day, .month, .year], from: date)
        let year: Int = components.year!
        let month: Int = components.month!
        let day: Int = components.day!

        
        var allFestival: [String] = [String]()
                
        // ①阴历节日
        let solor = Solar(solarYear: year, solarMonth: month, solarDay: day)
        let lunarDate = LunarSolarConverter.solarToLunar(solar: solor)
        let lunarFestivals = lunarFestival(year: lunarDate.lunarYear, month: lunarDate.lunarMonth, day: lunarDate.lunarDay)

        if lunarFestivals.count > 0 {
            allFestival.append(lunarFestivals)
        } else {
            // 除夕特殊处理
            let festival = dealLunarNewYearsEve(lunarDate: lunarDate, date: date)
            if festival.count > 0 {
                allFestival.append(festival)
            }
        }

        // ②阳历节日
        let soloarFestivals = soloarFestival(year: year, month: month, day: day)
        if soloarFestivals.count > 0 {
            allFestival.append(soloarFestivals)
        } else {
            // 处理父亲节和母亲节
            let festival = dealMothersDayAndFathersDay(month: month, components: components)
            if festival.count > 0 {
                allFestival.append(festival)
            }
        }
        
        // ③自定义节日
// TODO: 自定义节日
        
        return allFestival
    }
}

// MARK: - 节日
extension Festival {
    /// 阳历节日
    static func soloarFestival(year: Int, month: Int, day: Int) -> String {
        var festivalStr: String = ""
        switch festivalIndex(month, day) {
        case festivalIndex(1, 1): festivalStr = "元旦"
        case festivalIndex(3, 8): festivalStr = "妇女节"
        case festivalIndex(5, 1): festivalStr = "劳动节"
        case festivalIndex(6, 1): festivalStr = "儿童节"
        case festivalIndex(10, 1)...festivalIndex(10, 7): festivalStr = "国庆节"
        default: festivalStr = ""
        }
        
        if festivalStr.count > 0 {
            return festivalStr
        } else {
            // 清明节处理
            let solarterm = Solarterms.solartermName(index: Solarterms.solartermIndex(year: year, month: month, day: day))
            if solarterm == "清明" {
                festivalStr = "清明节"
            }
            return festivalStr
        }
    }

    /// 阴历节日(把阳历转换成阴历进行匹配)
    static func lunarFestival(year: Int, month: Int, day: Int) -> String {
        var festivalStr: String = ""
        switch festivalIndex(month, day) {
        case festivalIndex(1, 1)...festivalIndex(1, 6): festivalStr = "春节"
        case festivalIndex(5, 5): festivalStr = "端午节"
        case festivalIndex(7, 7): festivalStr = "七夕节"
        case festivalIndex(8, 15): festivalStr = "中秋节"
        default: festivalStr = ""
        }
        return festivalStr
    }
}

// MARK: - 特殊处理
extension Festival {
    /// 处理父亲节和母亲节
    static func dealMothersDayAndFathersDay(month: Int, components: DateComponents) -> String {
        var festival = ""
        if 5 == month {
            if (components.weekday == 1 && components.weekdayOrdinal == 2) {
                festival = "母亲节"
            }
        }
        if 6 == month {
            if (components.weekday == 1 && components.weekdayOrdinal == 3) {
                festival = "父亲节"
            }
        }
        
        return festival
    }
    
    /// 除夕名字统一为春节
    static func dealLunarNewYearsEve(lunarDate: Lunar, date: Date) -> String {
        var festival = ""
        if 12 == lunarDate.lunarMonth && (30 == lunarDate.lunarDay || 29 == lunarDate.lunarDay) {
            if 30 == lunarDate.lunarDay {
                festival = "春节"
            } else {
                let timeIntervalDay: TimeInterval = 60 * 60 * 24
                let nextDayDate = Date(timeInterval: timeIntervalDay, since: date)
                let lunarComponents = Calendar(identifier: .chinese).dateComponents([.day, .month, .year], from: nextDayDate)
                if 1 == lunarComponents.month && 1 == lunarComponents.day {
                    festival = "春节"
                }
            }
        }
        return festival
    }
}

