//
//  ErrorHandlerEngine.swift
//  NetworkModule
//
//  Created by Vitor Ferraz Varela on 06/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya
final class ErrorHandlerEngine<Target: Service>: NetworkRequestEngine {

    private var provider: MoyaProvider<Target>
    private var engine: NetworkRequestEngine
    init(provider: MoyaProvider<Target>, engine: NetworkRequestEngine) {
        self.provider = provider
        self.engine = engine
    }

    func request<T>(target: TargetType, completion: @escaping (Result<T>) -> Void) where T : DTO {
        guard let target = target as? Target else {
            return completion(.error(NetworkError.unknown))
        }
        provider.request(target) { (result) in
            switch result {
            case .failure(let error):
                let statusCode = error.response?.statusCode ?? (error as NSError).code
                switch statusCode {
                case 500:
                    return completion(.error(NetworkError.serverError))
                case 404:
                    return completion(.error(NetworkError.custom("Rota não encontrada")))
                case -1001:
                    return completion(.error(NetworkError.noConnection))
                default:
                    if let data = result.value?.data, let ameDigitalError = try? target.decoder.decode(AmeDigitalError.self, from: data) {
                        return completion(.error(NetworkError.ameDigitalError(ameDigitalError: ameDigitalError)))
                    }
                    return completion(.error(NetworkError.unknown))
                }
            case .success(let value):
                //Use to handle when the status code 500 is needed to create a custom error
                if let ameDigitalError = try? target.decoder.decode(AmeDigitalError.self, from: value.data) {
                    return completion(.error(NetworkError.ameDigitalError(ameDigitalError: ameDigitalError)))
                }
                return self.engine.request(target: target, completion: completion)
            }
        }

    }

}
