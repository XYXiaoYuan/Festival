//
//  Festival.swift
//  PhotoGallery
//
//  Created by MCPhotosiOS on 2019/10/17.
//  Copyright © 2019 Mi Cheng. All rights reserved.
//

import Foundation

/// 节日匹配结果
struct FestivalMatch {
    let isMatch: Bool // 是否匹配到节日
    let fesName: String? // 匹配到节日的名称
    let fesType: FestivalType // 匹配到节日之后,要做的事情
}

/// 节日类型
enum FestivalType {
    case none
    case lunar(type: FesEnum.Lunar)
    case solar(type: FesEnum.Solar)
//    case custom(type: FestivalListModel)
}

class Festival {
    /// 节日
    static func festivalIndex(_ month: Int, _ day: Int) -> Int {
        return month * 100 + day
    }
    
    /// 获取节日
    /// - Parameter date: 日期对象
    public static func festival(date: Date) -> [String] {
        guard let  components = FestivalComponents.createComponents(date: date ) else {
            return [String]()
        }

        var allFestival: [String] = [String]()
                
        // ①阴历节日
        let lunarMatch = components.isMatchLunar(FesEnum.Lunar.allLunarFes)
        if let fesName = lunarMatch.fesName {
            if case let .lunar(lFes) = lunarMatch.fesType {
                
            }
            allFestival.append(fesName)
        }

        // ②阳历节日
        let solarMatch = components.isMatchSolar(FesEnum.Solar.allSolorsFes)
        if let fesName = solarMatch.fesName {
            if case let .solar(sFes) = solarMatch.fesType {
                
            }
            allFestival.append(fesName)
        }

        // ③自定义节日
//        let cusMatch = components.isMatchCustomFestival(BSCenter.defautCenter.getAllCustomFestivalList())
//        if let fesName = cusMatch.fesName {
//            allFestival.append(fesName)
//        }

        return allFestival
    }
}
