//
//  Fonts+.swift
//  Mella-macOS
//
//  Created by 이전희 on 2023/09/17.
//

import SwiftUI

extension Font {
    enum FontWeight: String {
        case bold
        case regular
        
        var value: String {
            return self.rawValue.capitalized
        }
    }
    
    static func pretendard(size: CGFloat, weight: FontWeight = .regular) -> Font {
        Font.custom("Pretendard-\(weight.value)", size: size)
    }
}
