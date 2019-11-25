//
//  FestivalComponents.swift
//  PhotoGallery
//
//  Created by Shangen Zhang on 2019/11/21.
//  Copyright © 2019 Mi Cheng. All rights reserved.
//

import Foundation


struct FestivalComponents {
    let date: Date
    
    let year: Int
    let month: Int
    let day: Int
    let weekdayOrdinal: Int
    let weekday: Int
    let solarMonthDay: Int
    
    static func createComponents(date: Date) -> FestivalComponents? {
        // 创建日期组件
        let components = Calendar.current.dateComponents([.weekday, .weekdayOrdinal, .day, .month, .year], from: date)
         guard let year = components.year,
             let month = components.month,
             let day = components.day,
             let weekdayOrdinal = components.weekdayOrdinal,
             let weekday = components.weekday else { return nil }
         let solarMonthDay = Festival.festivalIndex(month, day)
        
        return FestivalComponents(date: date, year: year, month: month, day: day, weekdayOrdinal: weekdayOrdinal, weekday: weekday, solarMonthDay: solarMonthDay)
    }
}

// MARK: - 节日匹配
extension FestivalComponents {
    
    func isMatchLunar(_ lunar: [FesEnum.Lunar]?) -> FestivalMatch {
        guard let lunar = lunar else {
            return FestivalMatch(isMatch: false, fesName: nil, fesType: FestivalType.none)
        }
        
        /// 阴历节日
        let solor = Solar(solarYear: year, solarMonth: month, solarDay: day)
        let lunarDate = LunarSolarConverter.solarToLunar(solar: solor)
        let lunarMonthDay = Festival.festivalIndex(lunarDate.lunarMonth, lunarDate.lunarDay)
        for lFes in lunar {
            if lFes == .chineseNewYear { /// 除夕特殊处理
                if 12 == lunarDate.lunarMonth && (30 == lunarDate.lunarDay || 29 == lunarDate.lunarDay) {
                    if 30 == lunarDate.lunarDay {
                        // 除夕处理,大年30
                        return FestivalMatch(isMatch: true, fesName: "春节", fesType: FestivalType.lunar(type: lFes))
                    } else { // 在中国阴历1月1日的基础上,减1天,除开大年30,就是大年29日了
                        // 一天的 interval
                        let timeIntervalDay: TimeInterval = 60 * 60 * 24
                        let nextDayDate = Date(timeInterval: timeIntervalDay, since: date)
                        let lunarComponents = Calendar(identifier: .chinese).dateComponents([.day, .month, .year], from: nextDayDate)
                        if 1 == lunarComponents.month && 1 == lunarComponents.day {
                            // 除夕处理,大年29
                            return FestivalMatch(isMatch: true, fesName: "春节", fesType: FestivalType.lunar(type: lFes))
                        }
                    }
                }
            } else {
                for date in lFes.date {
                    if date == lunarMonthDay {
                        return FestivalMatch(isMatch: true, fesName: lFes.rawValue, fesType: FestivalType.lunar(type: lFes))
                    }
                }
            }
        }
        
        return FestivalMatch(isMatch: false, fesName: nil, fesType: FestivalType.none)
    }

    func isMatchSolar(_ solar: [FesEnum.Solar]?) -> FestivalMatch {
        guard let solar = solar else {
            return FestivalMatch(isMatch: false, fesName: nil, fesType: FestivalType.none)
        }
        
        /// 阳历节日
        for sFes in solar {
            if sFes == .monthersDay || sFes == .fathersDay { /// 母亲节, 父亲节
                if sFes.weekDate.month == month, sFes.weekDate.weekdayOrdinal == weekdayOrdinal, sFes.weekDate.weekday == weekday {
                    return FestivalMatch(isMatch: true, fesName: sFes.rawValue, fesType: FestivalType.solar(type: sFes))
                }
            } else if (sFes == .qingming) { /// 清明节
                let solarterm = Solarterms.solartermName(index: Solarterms.solartermIndex(year: year, month: month, day: day))
                if solarterm == "清明" {
                    return FestivalMatch(isMatch: true, fesName: sFes.rawValue, fesType: FestivalType.solar(type: sFes))
                }
            } else { /// 其它阳历节日
                for date in sFes.date where date == solarMonthDay {
                    return FestivalMatch(isMatch: true, fesName: sFes.rawValue, fesType: FestivalType.solar(type: sFes))
                }
            }
        }
        
        return FestivalMatch(isMatch: false, fesName: nil, fesType: FestivalType.none)
    }
    

//    func isMatchCustomFestival(_ customFestival: [FestivalListModel]?) -> FestivalMatch {
//        /// 自定义节日
//        guard let customFes = customFestival else { return FestivalMatch(isMatch: false, fesName: nil) }
//        for cFes in customFes {
//            if let customFestivalDate = cFes.customFestivalDate() {
//                if customFestivalDate == solarMonthDay {
//                    return FestivalMatch(isMatch: true, fesName: sFes.name)
//                }
//            }
//        }
//        return FestivalMatch(isMatch: false, fesName: nil)
//    }
    

}

