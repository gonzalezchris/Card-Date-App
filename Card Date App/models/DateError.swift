//
//  Error.swift
//  Card Date App
//
//  Created by Christoph on 3/25/18.
//  Copyright © 2018 Christoph. All rights reserved.
//

import Foundation

enum DateError: Error {
    case dateInPast
    case invalidDate
}
