//
//  NetworkEngine.swift
//  NetworkModule
//
//  Created by Vitor Ferraz Varela on 07/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya
final class NetworkEngine<Target: Service> {
    private var engine: NetworkRequestEngine

    init(provider: MoyaProvider<Target>) {
        engine = NetworkEngineBuilder(provider: provider).withErrorHandler().withRefreshToken().withReachability().build()
    }
}
extension NetworkEngine: NetworkRequestEngine {
    func request<T>(target: TargetType, completion: @escaping (Result<T>) -> Void) where T : DTO {
        engine.request(target: target, completion: completion)
    }
}
