//
//  LinearGradient+.swift
//  Mella-macOS
//
//  Created by 이전희 on 2023/09/17.
//

import SwiftUI

extension LinearGradient {
    static func mellaGradient(_ colors: [Color] = [Color(red: 255/255, green: 124/255, blue: 124/255),
                                            Color(red: 77/255, green: 45/255, blue: 183/255),
                                            Color(red: 157/255, green: 68/255, blue: 192/255),
                                            Color(red: 236/255, green: 83/255, blue: 176/255)],
                         startPoint: UnitPoint = .topLeading,
                         endPoint: UnitPoint = .bottomTrailing) -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: colors),
                                         startPoint: startPoint, endPoint: endPoint)
    }
}
