//
//  ViewController.swift
//  QuickScannerDemo
//
//  Created by Lukasz Szarkowicz on 15.03.2018.
//  Copyright © 2018 Lukasz Szarkowicz. All rights reserved.
//

import UIKit
import QuickScanner

class ViewController: UIViewController {

    fileprivate var barcodeScanner: QuickScanner!

    @IBOutlet weak var cameraFrame: UIImageView!
    @IBOutlet weak var message: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Available Code Types for scanning. You can use f.ex. [.qr] just for scanning qr codes.
        let types: [CodeType] = [
            CodeType.aztec,
            CodeType.code128,
            CodeType.code39,
            CodeType.code39Mod43,
            CodeType.code93,
            CodeType.dataMatrix,
            CodeType.ean13,
            CodeType.ean8,
            CodeType.interleaved2of5,
            CodeType.itf14,
            CodeType.pdf417,
            CodeType.qr,
            CodeType.upce]

        // scanner initialization and set delegate
        barcodeScanner = QuickScanner(codeTypes: types)
        barcodeScanner.delegate = self

        configureMessageLabel()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func configureMessageLabel() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(messageLabelTapped))
        message.text = "Scan your Code"
        message.addGestureRecognizer(gestureRecognizer)
        message.isUserInteractionEnabled = true
    }

    @objc private func messageLabelTapped() {

        if barcodeScanner.isCapturing == false {
            message.text = "Scan your Code"
            barcodeScanner.startCapturing()
        }
    }
}

extension ViewController: QuickScannerDelegate {
    func quickScanner(_ scanner: QuickScanner, didCaptureCode code: String, type: CodeType) {
        message.text = code
    }

    func quickScanner(_ scanner: QuickScanner, didReceiveError error: QuickScannerError) {
        print(error)
    }

    func quickScannerDidSetup(_ scanner: QuickScanner) {
        scanner.startCapturing()
        print("barcodeScannerDidSetup")
    }

    func quickScannerDidEndScanning(_ scanner: QuickScanner) {
        print("barcodeScannerDidEndScanning")
    }

    var videoPreview: UIView {
        return self.view
    }
}
