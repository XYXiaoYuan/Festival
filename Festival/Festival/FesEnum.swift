//
//  FesEnum.swift
//  Festival
//
//  Created by MCPhotosiOS on 2019/10/31.
//  Copyright © 2019 MCPhotosiOS. All rights reserved.
//  节日枚举

import Foundation

/// 节日枚举
enum FesEnum {
    
    /// 阴历节日
    enum Lunar: String, CaseIterable {
//        case chineseNewYear = "除夕" // 除夕直接就是春节
        case newYearsEve    = "春节"
        case qingming       = "清明节"
        case dragonBoat     = "端午节"
        case qixi           = "七夕节"
        case midAutumn      = "中秋节"
        
        static var allLunarFes: [Lunar] {
            return [
            .newYearsEve,
            .qingming,
            .dragonBoat,
            .qixi,
            .midAutumn
            ]
        }
    }
    
    /// 阳历节日
    enum Solar: String, CaseIterable {
        case newYearsDay    = "元旦"
        case womensDay      = "妇女节"
        case labourDay      = "劳动节"
        case monthersDay    = "母亲节"
        case childrensDay   = "儿童节"
        case fathersDay     = "父亲节"
        case nationalDay    = "国庆节"
        
        static var allSolorsFes: [Solar] {
            return [
            .newYearsDay,
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

// MARK: - 给对应的节日扩展节日对应的日期
extension FesEnum.Lunar {
    var date: String {
        switch self {
        case .newYearsEve:
            return FesEnum.festivalDate(month: 1, day: 1)
        case .dragonBoat:
            return FesEnum.festivalDate(month: 5, day: 5)
        case .qixi:
            return FesEnum.festivalDate(month: 7, day: 7)
        case .midAutumn:
            return FesEnum.festivalDate(month: 8, day: 15)
        case .qingming:
            // TODO:特殊处理
            return ""
        }
    }
    
    var index: Int {
        switch self {
        case .newYearsEve: return 2
        case .qingming: return 3
        case .dragonBoat: return 8
        case .qixi: return 10
        case .midAutumn: return 11
        }
    }
}

extension FesEnum.Solar {
    var date: String {
        switch self {
        case .newYearsDay:
            return FesEnum.festivalDate(month: 1, day: 1)
        case .womensDay:
            return FesEnum.festivalDate(month: 3, day: 8)
        case .labourDay:
            return FesEnum.festivalDate(month: 5, day: 1)
        case .childrensDay:
            return FesEnum.festivalDate(month: 6, day: 1)
        case .nationalDay:
            return FesEnum.festivalDate(month: 10, day: 1)
        case .monthersDay, .fathersDay:
            // 父亲节和母亲节要特殊处理
            return "06-14"
        }
    }
    
    var index: Int {
        switch self {
        case .newYearsDay: return 1
        case .womensDay: return 4
        case .labourDay: return 5
        case .monthersDay: return 6
        case .childrensDay: return 7
        case .fathersDay: return 9
        case .nationalDay: return 12
        }
    }
}

extension CaseIterable where Self: RawRepresentable {

    static var allValues: [RawValue] {
        return allCases.map { $0.rawValue }
    }
}

