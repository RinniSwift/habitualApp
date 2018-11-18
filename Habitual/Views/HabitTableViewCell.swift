//
//  HabitTableViewCell.swift
//  Habitual
//
//  Created by Rinni Swift on 11/17/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelHabitTitle: UILabel!
    @IBOutlet weak var labelStreaks: UILabel!
    
    
    
    static let identifier = "habitCell"
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    func configure(_ habit: Habit) {
        self.imageViewIcon.image = habit.selectedImage.image
        self.labelHabitTitle.text = habit.title
        self.labelStreaks.text = "streak: \(habit.currentStreak)"
        
        if habit.hasCompletedForToday {
            self.accessoryType = .checkmark
        } else {
            self.accessoryType = .disclosureIndicator
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
