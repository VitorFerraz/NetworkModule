//
//  NetworkEngine.swift
//  NetworkModule
//
//  Created by Vitor Ferraz Varela on 06/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import Moya
protocol NetworkEngine {
    func request(completion: @escaping(Result<Data>) -> Void)
}

