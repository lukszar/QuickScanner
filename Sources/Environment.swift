//
//  Environment.swift
//  QuickScanner
//
//  Created by Lukasz Szarkowicz on 12.03.2018.
//  Copyright © 2018 Lukasz Szarkowicz. All rights reserved.
//

import Foundation

enum Environment {

    case simulator
    case device

    static var current: Environment {

        #if targetEnvironment(simulator)
            return .simulator
        #else
            return .device
        #endif
    }
}
