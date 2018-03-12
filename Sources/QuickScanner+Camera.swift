//
//  QuickScanner+Camera.swift
//  QuickScanner
//
//  Created by Lukasz Szarkowicz on 12.03.2018.
//  Copyright © 2018 Lukasz Szarkowicz. All rights reserved.
//

import Foundation
import AVFoundation

extension QuickScanner {

    class Camera {

        static func device(for position: CameraPosition) -> AVCaptureDevice? {
            switch position {
            case .front:
                return Camera.front
            case .back:
                return Camera.back
            default:
                return nil
            }
        }

        private static var front: AVCaptureDevice? {
            return AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera,
                                           for: AVMediaType.video,
                                           position: CameraPosition.front)
        }

        private static var back: AVCaptureDevice? {
            return AVCaptureDevice.default(for: .video)
        }
    }
}
