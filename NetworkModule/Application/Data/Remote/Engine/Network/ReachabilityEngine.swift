//
//  ReachabilityEngine.swift
//  NetworkModule
//
//  Created by Vitor Ferraz Varela on 06/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Reachability

final class ReachabilityEngine: NetworkRequestEngine {

    typealias Target = Service
    private let reachability: Reachability?
    private let engine: NetworkRequestEngine
    init(reachability: Reachability? = Reachability(), engine: NetworkRequestEngine) {
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
