//
//  FesEnum.swift
//  PhotoGallery
//
//  Created by MCPhotosiOS on 2019/10/31.
//  Copyright © 2019 Mi Cheng. All rights reserved.
//

import Foundation

/// 节日枚举
enum FesEnum {
    
    /// 阴历节日
    enum Lunar: String, CaseIterable {
        case chineseNewYear = "除夕" // 除夕名字统一为春节
        case newYearsEve    = "春节"
        case dragonBoat     = "端午节"
        case qixi           = "七夕节"
        case midAutumn      = "中秋节"
        
        static var allLunarFes: [Lunar] {
            return [
            .chineseNewYear,
            .newYearsEve,
            .dragonBoat,
            .qixi,
            .midAutumn
            ]
        }
    }
    
    /// 阳历节日
    enum Solar: String, CaseIterable {
        case newYearsDay    = "元旦"
        case qingming       = "清明节"
        case womensDay      = "妇女节"
        case labourDay      = "劳动节"
        case monthersDay    = "母亲节"
        case childrensDay   = "儿童节"
        case fathersDay     = "父亲节"
        case nationalDay    = "国庆节"
        
        static var allSolorsFes: [Solar] {
            return [
            .newYearsDay,
            .qingming,
            .womensDay,
            .labourDay,
            .monthersDay,
            .childrensDay,
            .fathersDay,
            .nationalDay
            ]
        }
    }
    
    private static func festivalDate(month: Int, day: Int) -> String {
        return String(format: "%02d-%02d", month, day)
    }
}

// MARK: - 阴历节日
extension FesEnum.Lunar {
    var date: [String] {
        switch self {
        case .chineseNewYear:
            return [FesEnum.festivalDate(month: 12, day: 30)]
        case .newYearsEve:
            var newYearsEve = [String]()
            for i in 1...6 {
                let nation = FesEnum.festivalDate(month: 1, day: i)
                newYearsEve.append(nation)
            }
            return newYearsEve
        case .dragonBoat:
            return [FesEnum.festivalDate(month: 5, day: 5)]
        case .qixi:
            return [FesEnum.festivalDate(month: 7, day: 7)]
        case .midAutumn:
            return [FesEnum.festivalDate(month: 8, day: 15)]
        }
    }
    
    /// 用于节日相册排序
    var index: Int {
        switch self {
        case .chineseNewYear: return 2
        case .newYearsEve: return 2
        case .dragonBoat: return 8
        case .qixi: return 10
        case .midAutumn: return 11
        }
    }
}

// MARK: - 阳历节日
extension FesEnum.Solar {
    /// 其它节日的日期数组
    var date: [String] {
        switch self {
        case .newYearsDay:
            return [FesEnum.festivalDate(month: 1, day: 1)]
        case .qingming:
            // TODO:特殊处理
            return [FesEnum.festivalDate(month: 4, day: 5)]
        case .womensDay:
            return [FesEnum.festivalDate(month: 3, day: 8)]
        case .labourDay:
            return [FesEnum.festivalDate(month: 5, day: 1)]
        case .childrensDay:
            return [FesEnum.festivalDate(month: 6, day: 1)]
        case .nationalDay:
            var nationals = [String]()
            for i in 1...7 {
                let nation = FesEnum.festivalDate(month: 10, day: i)
                nationals.append(nation)
            }
            return nationals
        case .monthersDay:
            return [FesEnum.festivalDate(month: 5, day: 12)]
        case .fathersDay:
            return [FesEnum.festivalDate(month: 6, day: 16)]
        }
    }
    
    /// 母亲节,父亲节独有的weekDate元组
    var weekDate: (month: Int, weekdayOrdinal: Int, weekday: Int) {
        switch self {
        case .monthersDay:
            return (month: 5, weekdayOrdinal: 2, weekday: 1)
        case .fathersDay:
            return (month: 6, weekdayOrdinal: 3, weekday: 1)
        default:
            return (month: 0, weekdayOrdinal: 0, weekday: 0)
        }
    }
    
    /// 用于节日相册排序
    var index: Int {
        switch self {
        case .newYearsDay: return 1
        case .qingming: return 3
        case .womensDay: return 4
        case .labourDay: return 5
        case .monthersDay: return 6
        case .childrensDay: return 7
        case .fathersDay: return 9
        case .nationalDay: return 12
        }
    }
}
