//
//  ViewController.swift
//  NetworkModule
//
//  Created by Vitor Ferraz Varela on 06/08/19.
//  Copyright © 2019 Vitor Ferraz Varela. All rights reserved.
//

import UIKit
import Moya

struct Cars: DTO {
    var cars: [Car]
    init() {
        cars = []
    }
}
struct Car: DTO {
    var name: String

    init() {
        name = ""
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let provider = MoyaProvider<ExampleService>()
        let engine = NetworkEngine(provider: provider)
        engine.request(target: ExampleService.loadCars) { (result: Result<Cars>) in
            dump(result)
        }
    }


}

