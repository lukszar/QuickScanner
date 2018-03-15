//
//  QuickScanner.swift
//  QuickScanner
//
//  Created by Lukasz Szarkowicz on 09.03.2018.
//  Copyright © 2018 Lukasz Szarkowicz. All rights reserved.
//

import Foundation
import AVFoundation

open class QuickScanner: NSObject {

    open weak var delegate: QuickScannerDelegate? {
        didSet { self.prepareCamera() }
    }

    private var captureSession: AVCaptureSession
    private var captureDevice: AVCaptureDevice?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!

    private var videoPermission: VideoPermission
    private var codeTypes: [CodeType]

    open var isCapturing: Bool {
        return captureSession.isRunning
    }

    deinit {
        stopCapturing()
        videoPreviewLayer?.removeFromSuperlayer()
        delegate = nil
    }

    public init(codeTypes: [CodeType]) {
        // Initialize the captureSession object.
        captureSession = AVCaptureSession()
        videoPermission = VideoPermission()
        self.codeTypes = codeTypes
    }

    private func prepareCamera() {

        videoPermission.checkPersmission { [weak self] error in
            guard let `self` = self else { return }
            guard error == nil else {
                self.delegate?.quickScanner(self, didReceiveError: QuickScannerError.notAuthorizedToUseCamera)
                return
            }

            self.setupSessionInput(for: .back)
            self.setupSessionOutput()
            self.prepareVideoPreviewLayer()
            self.delegate?.quickScannerDidSetup(self)
        }
    }

    private func prepareVideoPreviewLayer() {
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill

        videoPreviewLayer.frame = delegate?.videoPreview.bounds ?? .zero
        delegate?.videoPreview.layer.insertSublayer(videoPreviewLayer, at: 0)
    }

    /**
     Setup instance of the AVCaptureDevice class to initialize a device object
     and provide the video as the media type parameter.
     */
    private func setupSessionInput(for position: CameraPosition) {
        if Environment.current == .simulator { return }

        guard let device = QuickScanner.Camera.device(for: position) else {
            delegate?.quickScanner(self, didReceiveError: QuickScannerError.cameraNotFound)
            return
        }

        // Get an instance of the AVCaptureDeviceInput class using the previous device object.
        do {
            let input = try AVCaptureDeviceInput(device: device)
            captureDevice = device
            captureSession.beginConfiguration()

            if let currentInput = captureSession.inputs.filter({$0 is AVCaptureDeviceInput}).first {
                captureSession.removeInput(currentInput)
            }

            // Set the input device on the capture session.
            if captureSession.canSetSessionPreset(.hd4K3840x2160) == true {
                captureSession.sessionPreset = .hd4K3840x2160
            } else {
                captureSession.sessionPreset = .high
            }
            captureSession.usesApplicationAudioSession = false
            captureSession.addInput(input)
            captureSession.commitConfiguration()

        } catch(let error) {

            delegate?.quickScanner(self, didReceiveError: QuickScannerError.system(error))
            Logger.warning(message: error.localizedDescription)
            return
        }
    }

    private func setupSessionOutput() {
        if Environment.current == .simulator { return }

        let captureOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureOutput)
        captureOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureOutput.metadataObjectTypes = codeTypes

        delegate?.videoPreview.setNeedsLayout()
    }

    open func startCapturing() {
        captureSession.startRunning()
    }

    open func stopCapturing() {

        captureSession.stopRunning()
        delegate?.quickScannerDidEndScanning(self)
    }
}

extension QuickScanner: AVCaptureMetadataOutputObjectsDelegate {

    open func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        guard let obj = metadataObjects.first else { return }
        guard let text = (obj as? AVMetadataMachineReadableCodeObject)?.stringValue else { return }

        delegate?.quickScanner(self, didCaptureCode: text, type: obj.type)
        stopCapturing()
    }
}
