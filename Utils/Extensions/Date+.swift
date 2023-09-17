//
//  Date+.swift
//  Mella-macOS
//
//  Created by 이전희 on 2023/09/17.
//

import Foundation

extension Date {
    func dateToString(_ dateFormat: String = "yyyy.MM.dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}
