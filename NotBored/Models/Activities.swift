//
//  Activities.swift
//  NotBored
//
//  Created by Joao Victor Santana Santos on 24/06/22.
//

import Foundation

struct Activity: Codable {
    var activity, type, key, link: String
    var accessibility, price: Float
    var participants: Int
}


