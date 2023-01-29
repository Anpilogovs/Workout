//
//  Int + Extensions.swift
//  Workout
//
//  Created by Сергей Анпилогов on 29.01.2023.
//

import Foundation

extension Int {
    
    func convertSeconds() -> (Int, Int) {
        let min = self / 60
        let sec = self % 60
        return (min, sec)
    }
}
