//
//  Service.swift
//  NetworkModule
//
//  Created by Vitor Ferraz Varela on 06/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya

protocol Service: TargetType, AccessTokenAuthorizable {
    var authPlugin: AccessTokenPlugin { get }
}

extension Service {
    /// This property is overriding the original validation status codes implementation by Moya
    var validationType: ValidationType {
        return ValidationType.successCodes
    }
}

extension Service {
    /// Used to provide authorization token to all API's requests
    var authPlugin: AccessTokenPlugin {
        let authPlugin = AccessTokenPlugin { () -> String in
            let token = ""
            return token
        }
        return authPlugin
    }

    var decoder: JSONDecoder {
        return JSONDecoder()
    }
}

extension TargetType {
    var decoder: JSONDecoder {
        return JSONDecoder()
    }

}
