//
//  PersistenceLayer.swift
//  Habitual
//
//  Created by Rinni Swift on 11/18/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import Foundation

struct PersistenceLayer {
    // MARK: - Variables
    
    // create a settable array to be able to write to our array of habits
    // create a private variable to be accessable only in the PersistenceLayer
    private(set) var habits: [Habit] = []
    
    // create a static constant because we only want one instance of this key no matter how many times instantiated
    private static let userDefaultsHabitsKeyValue = "HABITS_ARRAY"
    
    init() {
        self.loadHabits()
    }
    
    // mutating so we can alter the copy of data when a user instantiates the persistence layer
    private mutating func loadHabits() {
        let userDefaults = UserDefaults.standard
        
        guard
            let habitData = userDefaults.data(forKey: PersistenceLayer.userDefaultsHabitsKeyValue),
            let habits = try? JSONDecoder().decode([Habit].self, from: habitData) else {
                return
        }
        
        self.habits = habits
    }
    
    // when we are not using the result directly
    @discardableResult
        mutating func createNewHabit(name: String, image: Habit.Images) -> Habit {
            let newHabit = Habit(title: name, image: image)
            self.habits.insert(newHabit, at: 0)
            self.saveHabits()
        
            return newHabit
        }
    
    private func saveHabits() {
        guard let habitsData = try? JSONEncoder().encode(self.habits) else {
            fatalError("could not encode list of habits")
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(habitsData, forKey: PersistenceLayer.userDefaultsHabitsKeyValue)
    }
    
    mutating func delete(_ habitIndex: Int) {
        self.habits.remove(at: habitIndex)
        self.saveHabits()
    }
    
    
    mutating func markHabitAsCompleted(_ habitIndex: Int) -> Habit {
        var updatedHabit = self.habits[habitIndex]
        guard updatedHabit.hasCompletedForToday == false else { return updatedHabit }
        updatedHabit.numberOfCompletions += 1
        
        if let lastCompletionDate = updatedHabit.lastCompletionDate, lastCompletionDate.isYesterday {
            updatedHabit.currentStreak += 1
        } else {
            updatedHabit.currentStreak = 1
        }
        
        if updatedHabit.currentStreak > updatedHabit.bestStreal {
            updatedHabit.bestStreal = updatedHabit.currentStreak
        }
        
        let now = Date()
        updatedHabit.lastCompletionDate = now
        
        self.habits[habitIndex] = updatedHabit
        self.saveHabits()
        
        return updatedHabit
    }
    
    mutating func swapHabits(habitIndex: Int, destinationIndex: Int) {
        let habitToSwap = self.habits[habitIndex]
        self.habits.remove(at: habitIndex)
        self.habits.insert(habitToSwap, at: destinationIndex)
        self.saveHabits()
    }
    
    mutating func setNeedsToReloadHabits() {
        self.loadHabits()
    }
}
