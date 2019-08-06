//
//  DTO.swift
//  NetworkModule
//
//  Created by Vitor Ferraz Varela on 06/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Foundation
protocol DTO: Codable {
    init()
}
extension DTO {
    init() {
        self.init()
    }
}
