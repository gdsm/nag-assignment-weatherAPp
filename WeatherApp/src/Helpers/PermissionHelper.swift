//
//  PermissionHelper.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import UIKit


struct PermissionHelper {
    
    @MainActor
    static func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }

        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
}
