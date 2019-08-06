//
//  ReachabilityEngine.swift
//  NetworkModule
//
//  Created by Vitor Ferraz Varela on 06/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Reachability

final class ReachabilityEngine: NetworkEngine {

    typealias Target = Service
    private let reachability: Reachability?
    private let engine: NetworkEngine
    init(reachability: Reachability? = Reachability(), engine: NetworkEngine) {
        self.reachability = reachability
        self.engine = engine
    }

    func request(completion: @escaping (Result<Data>) -> Void) {
        if reachability?.connection == .none {
            return completion(.error(NetworkError.noConnection))
        }

        engine.request(completion: completion)
    }
}
