//
//  NetworkRequestEngine.swift
//  NetworkModule
//
//  Created by Vitor Ferraz Varela on 06/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya
protocol NetworkRequestEngine {
    func request<T: DTO>(target: TargetType, completion: @escaping(Result<T>) -> Void)
    func update(token: String)
}

extension NetworkRequestEngine {
    func update(token: String) {}
}

