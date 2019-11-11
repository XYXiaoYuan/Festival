//
//  Festival.swift
//  PhotoGallery
//
//  Created by MCPhotosiOS on 2019/10/17.
//  Copyright © 2019 Mi Cheng. All rights reserved.
//

import Foundation

enum FestivalType {
    case system
    case custom
}

class Festival {
    /// 节日
    static func festivalIndex(_ month: Int, _ day: Int) -> Int {
        return month * 100 + day
    }
    
    /// 获取节日
    /// - Parameter date: 日期对象
    public static func festival(date: Date) -> [String] {
        let components = Calendar.current.dateComponents([.weekday, .weekdayOrdinal, .day, .month, .year], from: date)
        guard let year = components.year,
            let month = components.month,
            let day = components.day,
            let weekdayOrdinal = components.weekdayOrdinal,
            let weekday = components.weekday else { return [String]() }
        let solarMonthDay = Festival.festivalIndex(month, day)

        var allFestival: [String] = [String]()
                
        // ①阴历节日
        let lunarFestivals = lunarFestival(year: year, month: month, day: day, date: date)
        if let festivals = lunarFestivals {
            allFestival.append(festivals)
        }

        // ②阳历节日
        let soloarFestivals = soloarFestival(year: year, month: month, day: day, weekdayOrdinal: weekdayOrdinal, weekday: weekday, solarMonthDay: solarMonthDay)
        if let festivals = soloarFestivals {
            allFestival.append(festivals)
        }
        
        // ③自定义节日
//        if let customFes = customFestival(solarMonthDay: solarMonthDay) {
//            allFestival.append(customFes)
//        }

        return allFestival
    }
}

// MARK: - 节日
extension Festival {
    /// 阳历节日
    static func soloarFestival(year: Int, month: Int, day: Int, weekdayOrdinal: Int, weekday: Int, solarMonthDay: Int) -> String? {
        var festivalStr: String?
        for sFes in FesEnum.Solar.allSolorsFes {
            if sFes == .monthersDay || sFes == .fathersDay { /// 母亲节, 父亲节
                if sFes.weekDate.month == month, sFes.weekDate.weekdayOrdinal == weekdayOrdinal, sFes.weekDate.weekday == weekday {
                    festivalStr = sFes.rawValue
                    break
                }
            } else if (sFes == .qingming) { /// 清明节
                let solarterm = Solarterms.solartermName(index: Solarterms.solartermIndex(year: year, month: month, day: day))
                if solarterm == "清明" {
                    festivalStr = sFes.rawValue
                    break
                }
            } else { /// 其它阳历节日
                for date in sFes.date {
                    if date == solarMonthDay {
                        festivalStr = sFes.rawValue
                        break
                    }
                }
            }
        }
        return festivalStr
    }

    /// 阴历节日(把阳历转换成阴历进行匹配)
    static func lunarFestival(year: Int, month: Int, day: Int, date: Date) -> String? {
        var festivalStr: String?
        let solor = Solar(solarYear: year, solarMonth: month, solarDay: day)
        let lunarDate = LunarSolarConverter.solarToLunar(solar: solor)
        let lunarMonthDay = Festival.festivalIndex(lunarDate.lunarMonth, lunarDate.lunarDay)
        for lFes in FesEnum.Lunar.allLunarFes {
            if lFes == .chineseNewYear { /// 除夕特殊处理,除夕名字统一为春节
                if 12 == lunarDate.lunarMonth && (30 == lunarDate.lunarDay || 29 == lunarDate.lunarDay) {
                    if 30 == lunarDate.lunarDay {
                        festivalStr = FesEnum.Lunar.newYearsEve.rawValue
                        break
                    } else {
                        let timeIntervalDay: TimeInterval = 60 * 60 * 24
                        let nextDayDate = Date(timeInterval: timeIntervalDay, since: date)
                        let lunarComponents = Calendar(identifier: .chinese).dateComponents([.day, .month, .year], from: nextDayDate)
                        if 1 == lunarComponents.month && 1 == lunarComponents.day {
                            festivalStr = FesEnum.Lunar.newYearsEve.rawValue
                            break
                        }
                    }
                }
            } else {
                for date in lFes.date {
                    if date == lunarMonthDay  {
                        festivalStr = lFes.rawValue
                        break
                    }
                }
            }
        }
        
        return festivalStr
    }
    
    /// 自定义节日
//    static func customFestival(solarMonthDay: Int) -> String? {
//        guard let festivalList = BSCenter.defautCenter.getAllCustomFestivalList() else { return nil }
//
//        var customFes: String?
//        for f in festivalList {
//            if let cusMonthDay = f.customFestivalDate() {
//                if cusMonthDay == solarMonthDay {
//                    if let name = f.name {
//                        customFes = name
//                        continue
//                    }
//                }
//            }
//        }
//        return customFes
//    }

}
