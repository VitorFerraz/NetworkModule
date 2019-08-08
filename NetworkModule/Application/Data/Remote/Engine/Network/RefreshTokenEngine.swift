//
//  RefreshTokenEngine.swift
//  NetworkModule
//
//  Created by Vitor Ferraz Varela on 06/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya
final class RefreshTokenEngine<Target: Service>: NetworkRequestEngine {

    private var provider: MoyaProvider<Target>
    private var engine: NetworkRequestEngine
    private var refreshTokenProvider = MoyaProvider<TokenService>()
     private var newEngine: NetworkRequestEngine
    init(provider: MoyaProvider<Target>, engine: NetworkRequestEngine) {
        self.provider = provider
        self.engine = engine
        self.newEngine = NetworkEngineBuilder(provider: self.provider).withReachability().build()
    }

    func request<T>(target: TargetType, completion: @escaping (Result<T>) -> Void) where T : DTO {
        guard let target = target as? Target else {
            return completion(.error(NetworkError.unknown))
        }

        provider.request(target) { (result) in
            guard let statusCode = result.value?.statusCode ?? result.error?.response?.statusCode else {
                return completion(.error(NetworkError.unknown))
            }
            switch statusCode {
            case 404:
//                return completion(.error(NetworkError.custom("Refresh token")))
                return self.refresh(target: target, completion: completion)
            default:
              return self.engine.request(target: target, completion: completion)
            }
        }
    }

    func refresh<T>(target: TargetType, completion: @escaping (Result<T>) -> Void) where T : DTO {
        self.refreshTokenProvider.request(.refreshToken, completion: { (result) in
            switch result {
            case .failure(let error):
                //quit user
               return completion(.error(error))
            case .success(let value):
                self.newEngine.update(token: "newToken")
                return
                    self.newEngine.request(target: target, completion: completion)
            }
        })
    }
}
