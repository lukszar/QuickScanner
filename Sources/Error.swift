//
//  Error.swift
//  QuickScanner
//
//  Created by Lukasz Szarkowicz on 12.03.2018.
//  Copyright © 2018 Lukasz Szarkowicz. All rights reserved.
//

import Foundation

public enum QuickScannerError: Swift.Error {
    case notAuthorizedToUseCamera
    case cameraInvalid
    case cameraNotFound
    case invalidCodeScanned
    case system(_: Swift.Error)
    case other
}
