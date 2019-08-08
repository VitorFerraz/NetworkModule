//
//  TokenService.swift
//  NetworkModule
//
//  Created by Vitor Ferraz Varela on 08/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya
enum TokenService {
    case refreshToken
}

extension TokenService: Service {
    //Change to your refresh andpoint
    var baseURL: URL {
        guard let url = URL(string: "https://carangas.herokuapp.com") else {
            fatalError("Error to convert string url to URL")
        }
        return url
    }

    var path: String {
        return "/cdnakjshdjkashdkjaars"
    }

    var method: Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String : String]? {
        return [:]
    }

    var authorizationType: AuthorizationType {
        return .basic
    }
}
