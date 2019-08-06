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

    init(target: Target) {
        self.provider = MoyaProvider<Target>()
        self.target = target
    }
}
extension ErrorHandlerEngine: NetworkEngine {

    func request(completion: @escaping (Result<Data>) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case .failure(let error):
                switch result.value?.statusCode {
                case let .some(code) where 401 == code || 409 == code:
                    //TODO: HandleUnauthorizedAccess
                    break

                default:
                    do {
                        
                    } catch {

                    }
                    guard let data = result.value?.data else {
                        return completion(.error(NetworkError.serverError))
                    }

                    if let ameDigitalError = try? target.decoder.decode(AmeDigitalError.self, from: result.value?.data) {
                        return completion(Result.error(APIError.ameDigitalError(error: ameDigitalError)))
                    }
                    return completion(Result.error(APIError.unknown))
                }
                let statusCode =
            case .success(let value):
                completion(.success(value.data))
            }
        }
    }
}
