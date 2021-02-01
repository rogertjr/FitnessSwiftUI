//
//  Challenge.swift
//  Fitness
//
//  Created by Rogério Toledo on 01/02/21.
//

import Foundation

struct Challenge: Codable {
    let exercise: String
    let startAmount: Int
    let increase: Int
    let length: Int
    let userUid: String
    let startDate: Date
}
