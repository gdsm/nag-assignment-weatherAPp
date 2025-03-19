//
//  ViewController.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import UIKit
import SwiftUI
import Combine

class AppViewcontroller: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        showAppView()
    }
 
    private func showAppView() {
        let appView = AppView()
        let hostingController = UIHostingController(rootView: appView)
        addChild(hostingController)
        
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        hostingController.didMove(toParent: self)
    }
}

