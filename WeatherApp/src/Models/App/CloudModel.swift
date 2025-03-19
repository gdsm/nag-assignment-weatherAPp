//
//  CloudModel.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation

struct CloudModel: Hashable {
    let all: Int
    
    init(model: CloudResponse) {
        self.all = model.all
    }
}
