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
    enum Lunar: String {
        case newYearsDay    = "元旦"
        case newYearsEve    = "春节"
        case qingming       = "清明节"
        case dragonBoat     = "端午节"
        case labourDay      = "七夕节"
        case midAutumn      = "中秋节"
    }
    
    /// 阳历节日
    enum Solar: String {
        case womensDay      = "妇女节"
        case labourDay      = "劳动节"
        case monthersDay    = "母亲节"
        case childrensDay   = "儿童节"
        case fathersDay     = "父亲节"
        case nationalDay    = "国庆节"
    }
}

