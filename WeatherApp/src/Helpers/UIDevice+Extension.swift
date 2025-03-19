//
//  UIDevice+Extension.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import UIKit

extension UIDevice {
    static var isSimulator: Bool = {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }()
}
