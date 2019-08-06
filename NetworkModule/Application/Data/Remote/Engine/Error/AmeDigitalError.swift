//
//  AmeDigitalError.swift
//  NetworkModule
//
//  Created by Vitor Ferraz Varela on 06/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Foundation
struct AmeDigitalError: Codable {
    let error: String
    let errorDescription: String
    let fields: [String: String]?
    var statusCode: Int?

    enum CodingKeys: String, CodingKey {
        case error
        case errorDescription = "error_description"
        case fields
        case statusCode
    }
}
