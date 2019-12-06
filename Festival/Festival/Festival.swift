//
//  FestivalIndex.swift
//  PhotoGallery
//
//  Created by MCPhotosiOS on 2019/10/17.
//  Copyright © 2019 Mi Cheng. All rights reserved.
//

import Foundation

class FestivalIndex {
    /// 节日
    static func festivalIndex(_ month: Int, _ day: Int) -> Int {
        return month * 100 + day
    }
}

