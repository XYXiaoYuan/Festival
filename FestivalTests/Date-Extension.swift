//
//  Date-Extension.swift
//  Festival
//
//  Created by MCPhotosiOS on 2019/10/17.
//  Copyright © 2019 MCPhotosiOS. All rights reserved.
//

import Foundation

extension Date {
    public static func date(string: String?) -> Date {
        let formatter = DateFormatter.init()
        formatter.timeZone = NSTimeZone.system
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: string!)!
    }
    
    public static func date(month: Int, day: Int) -> Date {
        let formatter = DateFormatter.init()
        formatter.timeZone = NSTimeZone.system
        formatter.dateFormat = "MM-dd"
        let string = String.init(format: "%02d-%02d", month, day)
        return formatter.date(from: string)!
    }

    public static func date(year: Int, month: Int, day: Int) -> Date? {
        let formatter = DateFormatter.init()
        formatter.timeZone = NSTimeZone.system
        formatter.dateFormat = "yyyy-MM-dd"
        let string = String.init(format: "%02d-%02d-%02d", year, month, day)
        
        if let date = formatter.date(from: string) {
            return date
        } else {
            return nil
        }
    }
}
