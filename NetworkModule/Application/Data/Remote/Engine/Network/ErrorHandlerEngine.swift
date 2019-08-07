//
//  ErrorHandlerEngine.swift
//  NetworkModule
//
//  Created by Vitor Ferraz Varela on 06/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya
final class ErrorHandlerEngine<Target: Service> {
    private var provider: MoyaProvider<Target>
    let target: Target

    init(target: Target, provider: MoyaProvider<Target>) {
        self.provider = provider
        self.target = target
    }
}
extension ErrorHandlerEngine: NetworkRequestEngine {

    func request(completion: @escaping (Result<Data>) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case .failure(let error):
                let statusCode = result.value?.statusCode ?? (error as NSError).code
                switch statusCode {
                case 500:
                    return completion(.error(NetworkError.serverError))
                case -1001:
                    return completion(.error(NetworkError.noConnection))
                default:
                    if let data = result.value?.data, let ameDigitalError = try? self.target.decoder.decode(AmeDigitalError.self, from: data) {
                        return completion(.error(NetworkError.ameDigitalError(ameDigitalError: ameDigitalError)))
                    }
                    return completion(.error(NetworkError.unknown))
                }
            case .success(let value):
                //Use to handle when the status code 500 is needed to create a custom error
                if let ameDigitalError = try? self.target.decoder.decode(AmeDigitalError.self, from: value.data) {
                    return completion(.error(NetworkError.ameDigitalError(ameDigitalError: ameDigitalError)))
                }
                return completion(.success(value.data))
            }
        }
    }
}
