//
//  Weather.swift
//  Weather History
//
//  Created by Mohamed Hamed on 12/28/17.
//  Copyright © 2017 Hamed. All rights reserved.
//

import Foundation
import ObjectMapper

public class Weather: Mappable {

    var city = ""
    var info: Info?
    var temp: Temperature?
    
    init() {
        
    }
    
    required public init?(map: Map) {
        
    }

    public func mapping(map: Map)  {
        city    <- map["name"]
        var infoArray = [Info]()
        infoArray <- map["weather"]
        info = infoArray.first
        temp    <- map["main"]
    }
    
}

struct Temperature: Mappable {
    var temp: Double = 0
    var min: Double = 0
    var max: Double = 0
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map)  {
        temp    <- map["temp"]
        min    <- map["temp_min"]
        max    <- map["temp_max"]
    }
}


struct Info: Mappable {
    var description = ""
    var icon = ""
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map)  {
        description <- map["description"]
        icon        <- map["icon"]
    }
}
