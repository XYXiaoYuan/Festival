//
//  FestivalComponents.swift
//  PhotoGallery
//
//  Created by Shangen Zhang on 2019/11/21.
//  Copyright © 2019 Mi Cheng. All rights reserved.
//

import Foundation


/// 自定义节假日
public protocol FestivalProvide {
    /// 节日Id
    var festivalId: String { get }
    /// 节假日名称
    var festivalName: String { get }
    /// 匹配的日期
    var festivalDate: Date { get }
    /// 是否为阴历
    var isLunar: Bool { get }
}

public extension FestivalProvide {
    var isLunar: Bool { return false }
}

extension FestivalProvide {
    /// 自定义节日的节日index,用于匹配
    func festivalDate() -> Int? {
        let components = Calendar.current.dateComponents([.month, .day], from: festivalDate)
        guard let month = components.month, let day = components.day else { return nil }
        return FestivalIndex.festivalIndex(month, day)
    }
}

// 需要匹配的类型
public enum MatchType {
    /// 是否存在
    case isMatch
    /// 所有的名称
    case names
    /// 原始数据
    case origin
}

/// 节假日匹配组件
public struct FestivalComponents {
    public let date: Date
    
    public let year: Int
    public let month: Int
    public let day: Int
    public let weekdayOrdinal: Int
    public let weekday: Int
    public let solarMonthDay: Int
    
    public static func createComponents(date: Date) -> FestivalComponents? {
        // 创建日期组件
        let components = Calendar.current.dateComponents([.weekday, .weekdayOrdinal, .day, .month, .year], from: date)
        
        guard let year = components.year,
              let month = components.month,
              let day = components.day,
              let weekdayOrdinal = components.weekdayOrdinal,
              let weekday = components.weekday else { return nil }
        let solarMonthDay = FestivalIndex.festivalIndex(month, day)
        
        return FestivalComponents(date: date, year: year, month: month, day: day, weekdayOrdinal: weekdayOrdinal, weekday: weekday, solarMonthDay: solarMonthDay)
    }
    
    var hashValue: Int {
        return year * 10000 + month * 100 + day
    }
}
extension FestivalComponents {
    class SafeExcute {
        private static let queueKey = DispatchSpecificKey<Int>()
        private lazy var safeQueue = DispatchQueue.init(label: "\(self)_queue")
        private lazy var queueContext: Int = unsafeBitCast(self, to: Int.self)
        
        public init() {
            safeQueue.setSpecific(key: Self.queueKey, value: queueContext)
        }
        
        func excute<T>(_ block: () throws -> T) rethrows -> T {
            /// 相同队列 直接执行
            if queueContext == DispatchQueue.getSpecific(key: Self.queueKey){ return try block() }
            /// 其他的队列 串行执行
            return try safeQueue.sync(execute: block)
        }
    }
    
    class Cache {
        let safe = SafeExcute()
        
        var lunarsCache = [Int: [FesEnum.Lunar]]()
        
        var solarsCache = [Int: [FesEnum.Solar]]()
        
        func lunars(for key: Int) -> [FesEnum.Lunar]? {
            return safe.excute {
                return lunarsCache[key]
            }
        }
        func setLunars(_ lunars: [FesEnum.Lunar], for key: Int) {
            return safe.excute {
                return lunarsCache[key] = lunars
            }
        }
        func solars(for key: Int) -> [FesEnum.Solar]? {
            return safe.excute {
                return solarsCache[key]
            }
        }
        func setSolars(_ solars: [FesEnum.Solar], for key: Int) {
            return safe.excute {
                return solarsCache[key] = solars
            }
        }
    }
    
    static let cache = Cache()
    
    public func matchAllLunarsAndSolars() -> (lunars: [FesEnum.Lunar]?,  solars: [FesEnum.Solar]?) {
        let key = hashValue
        
        func matchAllLunars() -> [FesEnum.Lunar]? {
            if let result = Self.cache.lunars(for: key) {
                return result
            }
            let lunars = matchLunars(FesEnum.Lunar.allLunarFes, matchType: .origin) ?? [FesEnum.Lunar]()
            Self.cache.setLunars(lunars, for: key)
            return lunars
        }
        
        func matchAllSolars() -> [FesEnum.Solar]? {
            if let result = Self.cache.solars(for: key) {
                return result
            }
            let solars = matchSolars(FesEnum.Solar.allSolorsFes, matchType: .origin) ?? [FesEnum.Solar]()
            Self.cache.setSolars(solars, for: key)
            return solars
        }
        
        return (lunars: matchAllLunars(),  solars: matchAllSolars())
    }
}

// MARK: - 节日匹配
public extension FestivalComponents {
    
    /// 匹配阴历节日
    /// - Parameters:
    ///   - lunars: 阴历集合
    ///   - matchType: 匹配类型
    func matchLunars<T>(_ lunars: [FesEnum.Lunar]?, matchType: MatchType) -> T?  {
        guard let lunar = lunars else {
            return nil
        }
        var result: [FesEnum.Lunar]?
        if matchType != .isMatch {
            result = [FesEnum.Lunar]()
        }
        /// 阴历节日
        let solor = Solar(solarYear: year, solarMonth: month, solarDay: day)
        guard let lunarDate = LunarSolarConverter.solarToLunar(solar: solor) else { return nil }
        let lunarMonthDay = FestivalIndex.festivalIndex(lunarDate.lunarMonth, lunarDate.lunarDay)
        
        for lFes in lunar {
            if lFes == .chineseNewYear { /// 除夕特殊处理
                if 12 == lunarDate.lunarMonth && (30 == lunarDate.lunarDay || 29 == lunarDate.lunarDay) {
                    if 30 == lunarDate.lunarDay {
                        // 除夕处理,大年30
                        if result == nil {
                            return true as? T
                        } else {
                            result?.append(FesEnum.Lunar.newYearsEve)
                        }
                    } else { // 在中国阴历1月1日的基础上,减1天,除开大年30,就是大年29日了
                        // 一天的 interval
                        let timeIntervalDay: TimeInterval = 60 * 60 * 24
                        let nextDayDate = Date(timeInterval: timeIntervalDay, since: date)
                        let lunarComponents = Calendar(identifier: .chinese).dateComponents([.day, .month, .year], from: nextDayDate)
                        if 1 == lunarComponents.month && 1 == lunarComponents.day {
                            // 除夕处理,大年29
                            if result == nil {
                                return true as? T
                            } else {
                                result?.append(FesEnum.Lunar.newYearsEve)
                            }
                        }
                    }
                }
            } else {
                for date in lFes.date {
                    if date == lunarMonthDay {
                        if result == nil {
                            return true as? T
                        } else {
                            result?.append(lFes)
                        }
                    }
                }
            }
        }
        
        guard let results = result, !results.isEmpty  else { return nil }
        
        if matchType == .origin {
            return results as? T
        }
        var names = [String]()
        results.forEach {
            names.append($0.rawValue)
        }
        return names as? T
    }
    
    /// 匹配阳历节日
    /// - Parameters:
    ///   - solars: 阳历节日集合
    ///   - matchType: 匹配类型
    func matchSolars<T>(_ solars: [FesEnum.Solar]?, matchType: MatchType) -> T? {
        guard let solar = solars else {
            return nil
        }
        
        var result: [FesEnum.Solar]?
        if matchType != .isMatch {
            result = [FesEnum.Solar]()
        }
        /// 阳历节日
        for sFes in solar {
            if sFes == .monthersDay || sFes == .fathersDay { /// 母亲节, 父亲节
                if sFes.weekDate.month == month, sFes.weekDate.weekdayOrdinal == weekdayOrdinal, sFes.weekDate.weekday == weekday {
                    if result == nil {
                        return true as? T
                    } else {
                        result?.append(sFes)
                    }
                }
            } else if (sFes == .qingming) { /// 清明节
                let solarterm = Solarterms.solartermName(index: Solarterms.solartermIndex(year: year, month: month, day: day))
                if solarterm == "清明" {
                    if result == nil {
                        return true as? T
                    } else {
                        result?.append(sFes)
                    }
                }
            } else { /// 其它阳历节日
                for date in sFes.date where date == solarMonthDay {
                    if result == nil {
                        return true as? T
                    } else {
                        result?.append(sFes)
                    }
                }
            }
        }
        guard let results = result, !results.isEmpty  else { return nil }
        
        if matchType == .origin {
            return results as? T
        }
        var names = [String]()
        results.forEach {
            names.append($0.rawValue)
        }
        return names as? T
    }
    
    
    /// 自定义节日
    /// - Parameters:
    ///   - customFestival: 自定义节日provide
    ///   - matchType: 匹配类型
    func matchCustomFestival<T>(_ customFestival: [FestivalProvide]?, matchType: MatchType) -> T? {
        /// 自定义节日
        guard let customFes = customFestival else { return nil }
        var result: [FestivalProvide]?
        if matchType != .isMatch {
            result = [FestivalProvide]()
        }
        for cFes in customFes {
            guard let customFestivalDate = cFes.festivalDate(), customFestivalDate == solarMonthDay else { continue }
            if result == nil {
                return true as? T
            }
            result?.append(cFes)
        }
        guard let results = result, !results.isEmpty  else { return nil }
        
        if matchType == .origin {
            return results as? T
        }
        var names = [String]()
        results.forEach {
            names.append($0.festivalName)
        }
        return names as? T
    }
}
