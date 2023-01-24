//
//  TableViewCellProtocol.swift
//  Workout
//
//  Created by Сергей Анпилогов on 23.01.2023.
//

import Foundation


protocol StartWorkoutProtocol: AnyObject {
    func startButtonTapped(model: WorkoutModel)
}

protocol NextSetProtocol: AnyObject {
    func nextSetTapped()
}
