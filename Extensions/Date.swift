//
//  Date.swift
//  Habitual
//
//  Created by Rinni Swift on 11/17/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    var stringValue: String {
        return DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .none)
    }
    
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    var isYesterday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInYesterday(self)
    }
    
}
