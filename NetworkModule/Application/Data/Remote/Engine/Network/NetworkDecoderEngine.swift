//
//  NetworkDecoderEngine.swift
//  NetworkModule
//
//  Created by Vitor Ferraz Varela on 07/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya

final class NetworkDecoderEngine<Target: Service>: NetworkRequestEngine {

    private var provider: MoyaProvider<Target>

    init(provider: MoyaProvider<Target>) {
        self.provider = provider
    }

    func request<T>(target: TargetType, completion: @escaping (Result<T>) -> Void) where T : DTO {
        guard let target = target as? Target else {
            return completion(.error(NetworkError.unknown))
        }
        provider.request(target) { (result) in
            switch result {
            case .failure(let error):
                return completion(.error(error))
            case .success(let value):
                if value.data.isEmpty {
                    return completion(.success(T()))
                }
                guard let obj = try? target.decoder.decode(T.self, from: value.data) else {
                    return completion(.error(NetworkError.parserError))
                }
                return completion(.success(obj))
            }
        }

    }

    func update(token: String) {
        let authPlugin = AccessTokenPlugin { () -> String in
            return token
        }
        provider = ProviderBuilder().build(authPlugin)
    }
}
