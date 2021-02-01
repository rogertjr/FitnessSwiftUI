//
//  ChallengeItemViewModel.swift
//  Fitness
//
//  Created by Rogério Toledo on 01/02/21.
//

import SwiftUI

struct ChallengeItemViewModel: Hashable {
    private let challenge: Challenge
    
    var title: String {
        challenge.exercise.capitalized
    }
    
    private var daysFromStart: Int {
        guard let daysFromStart = Calendar.current.dateComponents([.day], from: challenge.startDate, to: Date()).day else { return 0}
        return abs(daysFromStart)
    }
    
    private var isComplete: Bool {
        daysFromStart - challenge.length > 0
    }
    
    var statusText: String {
        guard !isComplete else { return "Done" }
        let dayNumer = daysFromStart + 1
        return "Day \(dayNumer) of \(challenge.length)"
    }
    
    var increaseText: String {
        "+\(challenge.increase) daily"
    }
    
    init(_ challenge: Challenge) {
        self.challenge = challenge
    }
    
}
