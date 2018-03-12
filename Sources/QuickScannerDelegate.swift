//
//  QuickScannerDelegate.swift
//  QuickScanner
//
//  Created by Lukasz Szarkowicz on 12.03.2018.
//  Copyright © 2018 Lukasz Szarkowicz. All rights reserved.
//

import UIKit


public protocol QuickScannerDelegate: class {

    var videoPreview: UIView { get }

    func quickScanner(_ scanner: QuickScanner, didCaptureCode code: String, type: CodeType)
    func quickScanner(_ scanner: QuickScanner, didReceiveError error: QuickScannerError)
    func quickScannerDidSetup(_ scanner: QuickScanner)
    func quickScannerDidEndScanning(_ scanner: QuickScanner)
}
