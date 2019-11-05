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
}

// MARK: - 阴历节日
extension FesEnum.Lunar {
    var date: [Int] {
        switch self {
        case .chineseNewYear:
            return [Festival.festivalIndex(12, 30)]
        case .newYearsEve:
            var newYearsEve = [Int]()
            for i in 1...6 {
                let nation = Festival.festivalIndex(1, i)
                newYearsEve.append(nation)
            }
            return newYearsEve
        case .dragonBoat:
            return [Festival.festivalIndex(5, 5)]
        case .qixi:
            return [Festival.festivalIndex(7, 7)]
        case .midAutumn:
            return [Festival.festivalIndex(8, 15)]
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
    var date: [Int] {
        switch self {
        case .newYearsDay:
            return [Festival.festivalIndex(1, 1)]
        case .qingming:
            // TODO:特殊处理
            return [Festival.festivalIndex(4, 5)]
        case .womensDay:
            return [Festival.festivalIndex(3, 8)]
        case .labourDay:
            return [Festival.festivalIndex(5, 1)]
        case .childrensDay:
            return [Festival.festivalIndex(6, 1)]
        case .nationalDay:
            var nationals = [Int]()
            for i in 1...7 {
                let nation = Festival.festivalIndex(10,  i)
                nationals.append(nation)
            }
            return nationals
        case .monthersDay:
            return [Festival.festivalIndex(5, 12)]
        case .fathersDay:
            return [Festival.festivalIndex(6, 16)]
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

