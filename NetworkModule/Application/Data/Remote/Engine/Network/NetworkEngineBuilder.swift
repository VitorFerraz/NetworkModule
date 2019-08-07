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
    let target: Target
    
    init(target:Target, provider: MoyaProvider<Target>) {
        self.provider = provider
        self.target = target
    }
    
    func request<T: DTO>(completion: @escaping (Result<T>) -> Void) {
       
    }
}
