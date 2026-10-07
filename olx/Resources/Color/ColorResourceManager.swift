//
//  ColorResourceManager.swift
//  olx
//
//  Created by Eshqulov Xudoyorbek  on 05/10/26.
//

import UIKit

class ColorResourceManager {
    static let shared = ColorResourceManager()
    private init() {}
    
    let mainColor = UIColor(red: 0/255, green: 47/255, blue: 52/255, alpha: 1.0)
}

/*
 1) Singleton ->
    a) What is that? -> Concepts fully
    b) How to use that?
    c) Where to use that? -> To use it in my OLX project
 
 
 2) Injections
    d) What type of injections exists in programing in general
    e) What type of lybraries exists in swift to provide injection
    f) Difference between pure and container based injections
    ...
    ...
 
 3) UI design patterns
    MVP
    MVC
    MVVM
    VIPER
    ...
    ...
 
 4) ...
 
 final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
 
    func network() {
        print("Someting...")
    }
 }
 
 let childroomNetwork = NetworkManager.shared.network()
 */


protocol Engine {
    func start()
}

class PetrolEngine: Engine {
    func start() {
        print("Petrol engine is started")
    }
}

class ElectricEngine: Engine {
    func start() {
        print("Electric engine is started")
    }
}

class Car {
    let engine: Engine
    init(engine: Engine) {
        self.engine = engine
    }
    
    func drive() {
        engine.start()
        print("Car is driving")
    }
}

let petrolEngine = PetrolEngine()
let car = Car(engine: petrolEngine)
