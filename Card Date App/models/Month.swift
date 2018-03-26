//
//  Month.swift
//  Card Date App
//
//  Created by Christoph on 3/25/18.
//  Copyright © 2018 Christoph. All rights reserved.
//

import Foundation

enum Month: UInt {
    case jan = 1, feb, mar, apr, may, jun, jul, aug, sep, ov, nov, dec
    
    func monthName() -> String {
        switch self {
        case .jan: return "JAN"
        case .feb: return "FEB"
        case .mar: return "MAR"
        case .apr: return "APR"
        case .may: return "MAY"
        case .jun: return "JUN"
        case .jul: return "JUL"
        case .aug: return "AUG"
        case .sep: return "SEP"
        case .ov: return "OV"
        case .nov: return "NOV"
        case .dec: return "DEC"
        default: return String(self.rawValue)
        }
    }
    
    static func getAllMonths() -> [String] {
        return [
            Month.jan.monthName(),
            Month.feb.monthName(),
            Month.mar.monthName(),
            Month.apr.monthName(),
            Month.may.monthName(),
            Month.jun.monthName(),
            Month.jul.monthName(),
            Month.aug.monthName(),
            Month.sep.monthName(),
            Month.ov.monthName(),
            Month.nov.monthName(),
            Month.dec.monthName(),
        ]
    }
}

