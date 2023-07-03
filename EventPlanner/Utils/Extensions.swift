//
//  Extensions.swift
//  EventPlanner
//
//  Created by Chicmic on 12/06/23.
//

import Foundation
import SwiftUI

extension Double {
    /// Rounds the double to decimal places value

    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Date {
    func diff(numDays: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: numDays, to: self)!
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}

extension View {
    func dismissKeyboardOnTap() -> some View {
        return self.onTapGesture {
            UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
        }
    }
}

