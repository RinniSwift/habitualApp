//
//  HabitDetailedViewController.swift
//  Habitual
//
//  Created by Rinni Swift on 11/20/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import UIKit

class HabitDetailedViewController: UIViewController {

    // MARK: - Variables
    var habit: Habit!
    var habitIndex: Int!
    
    private var persistenceLayer = PersistenceLayer()
    
    // MARK: - outlet and actions
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var currentStreakLabel: UILabel!
    @IBOutlet weak var totalCompletionsLabel: UILabel!
    @IBOutlet weak var bestStreakLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var buttonAction: UIButton!
    @IBAction func actionButtonPressed(_ sender: UIButton) {
        
        habit = persistenceLayer.markHabitAsCompleted(habitIndex)
        updateUI()
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()

    }
    
    private func updateUI() {
        title = habit.title
        imageViewIcon.image = habit.selectedImage.image
        currentStreakLabel.text = "Current Streak: \(habit.currentStreak)"
        totalCompletionsLabel.text = "Total Completions: \(habit.numberOfCompletions)"
        bestStreakLabel.text = "Best Streak: \(habit.bestStreal)"
        dateLabel.text = String(habit.dateCreated.stringValue)
        
        if habit.hasCompletedForToday {
            buttonAction.setTitle("Completed For Today!", for: .normal)
        } else {
            buttonAction.setTitle("Mark as completed", for: .normal)
        }
    }
}
