//
//  NetworkEngineBuilder.swift
//  NetworkModule
//
//  Created by Vitor Ferraz Varela on 06/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya
final class NetworkEngineBuilder<Target: Service> {
    
    private var provider: MoyaProvider<Target>
    private var engine: NetworkRequestEngine
    
    init(provider: MoyaProvider<Target>) {
        self.provider = provider
        engine = NetworkDecoderEngine(provider: provider)
    }
    
    func withErrorHandler() -> Self {
        engine = ErrorHandlerEngine(provider: provider, engine: engine)
        return self
    }

    func withReachability() -> Self {
        engine = ReachabilityEngine(engine: engine)
        return self
    }

    func withRefreshToken() -> Self {
        engine = RefreshTokenEngine(provider: provider, engine: engine)
        return self
    }

    func build() -> NetworkRequestEngine {
        return engine
    }
}
