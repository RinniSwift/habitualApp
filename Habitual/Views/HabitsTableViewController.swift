//
//  MainViewController.swift
//  Habitual
//
//  Created by Rinni Swift on 11/15/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import UIKit

class HabitsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let habitTableViewCell = HabitTableViewCell()
    
    var habits: [Habit] = [
        Habit(title: "wake up at 7", image: Habit.Images.sleep),
        Habit(title: "drink 10 cups of water in the day", image: Habit.Images.grow),
        Habit(title: "commit today", image: Habit.Images.code),
        Habit(title: "stretch every 1 hour", image: Habit.Images.gym)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(HabitTableViewCell.nib, forCellReuseIdentifier: HabitTableViewCell.identifier)
        
        setupNavBar()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.identifier, for: indexPath) as! HabitTableViewCell
        
        let habit = habits[indexPath.row]
        cell.configure(habit)
        
        
        return cell
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HabitsTableViewController {
    
    func setupNavBar() {
        title = "Habitual"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddHabit(_:)))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func pressAddHabit(_ sender: UIBarButtonItem) {
        let habitTitle = Habit(title: "Hello Guys!", image: Habit.Images.bulb)
        habits.insert(habitTitle, at: 0)
        let topIndexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [topIndexPath], with: .automatic)
    }
    
}
