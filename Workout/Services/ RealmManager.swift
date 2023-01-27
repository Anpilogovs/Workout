//
//  RealmManager.swift
//  Workout
//
//  Created by Сергей Анпилогов on 18.01.2023.
//

import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveWorkoutModel(model: WorkoutModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func updateStatusWorkoutModel(model: WorkoutModel, bool: Bool) {
        try! localRealm.write {
            model.status = bool
        }
    }
    
    func updateSetsAndRepsWorkoutModel(model: WorkoutModel, sets: Int, reps: Int) {
        try! localRealm.write {
            model.workoutSets = sets
            model.workoutReps = reps
        }
    }
    
    func deleteWorkoutModel(model: WorkoutModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
}
