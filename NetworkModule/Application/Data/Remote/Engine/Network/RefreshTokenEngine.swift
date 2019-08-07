//
//  RefreshTokenEngine.swift
//  NetworkModule
//
//  Created by Vitor Ferraz Varela on 06/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya
final class RefreshTokenEngine<Target: Service> {
    
    private var provider: MoyaProvider<Target>
    let target: Target
    
    init(target: Target) {
        self.provider = MoyaProvider<Target>()
        self.target = target
    }
    func refreshToken(completion: @escaping (Result<Void>) -> Void) {
        //TODO: Add repository to handle refresh token
    }
}
extension RefreshTokenEngine: NetworkRequestEngine {
    
    func request(completion: @escaping (Result<Data>) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case .failure(let error):
                let statusCode = result.value?.statusCode ?? (error as NSError).code
                switch statusCode {
                case 401:
                    self.refreshToken(completion: { (result) in
                        switch result {
                        case .error(let error):
                            return completion(.error(error))
                        case .success:
                            self.provider.request(self.target, completion: { (result) in
                                if let data = result.value?.data {
                                    return completion(.success(data))
                                }
                                return completion(.error(NetworkError.unknown))
                            })
                        }
                    })
                default:
                    if let data = result.value?.data, let ameDigitalError = try? self.target.decoder.decode(AmeDigitalError.self, from: data) {
                        return completion(.error(NetworkError.ameDigitalError(ameDigitalError: ameDigitalError)))
                    }
                    return completion(.error(NetworkError.unknown))
                }
            case .success(let value):
                return completion(.success(value.data))
            }
        }
    }
}
