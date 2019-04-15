//
//  Model.swift
//  day04
//
//  Created by Kateryna KOSTRUBOVA on 4/6/19.
//  Copyright © 2019 Kateryna KOSTRUBOVA. All rights reserved.
//

import Foundation

struct Tweet: CustomStringConvertible {
    let name : String
    let text : String
    let date: String
    var description: String {
        return "\(name), \(text)"
    }
}
