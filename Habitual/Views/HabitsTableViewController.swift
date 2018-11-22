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
    
    private var persistance = PersistenceLayer()
    
    let habitTableViewCell = HabitTableViewCell()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(HabitTableViewCell.nib, forCellReuseIdentifier: HabitTableViewCell.identifier)
        
        setupNavBar()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persistance.habits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.identifier, for: indexPath) as! HabitTableViewCell
        
        let habit = persistance.habits[indexPath.row]
        cell.configure(habit)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            // handling delete action
            let habitToDelete = persistance.habits[indexPath.row]
            let habitToDeleteIndex = indexPath.row
            
            let deleteAlert = UIAlertController(habitTitle: habitToDelete.title) {
                self.persistance.delete(habitToDeleteIndex)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            self.present(deleteAlert, animated: true)
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        persistance.swapHabits(habitIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(persistance.habits[indexPath.row].title)
        let habitDetailedVC = HabitDetailedViewController.instantiate()
        habitDetailedVC.habit = persistance.habits[indexPath.row]
        habitDetailedVC.habitIndex = indexPath.row
        navigationController?.pushViewController(habitDetailedVC, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        persistance.setNeedsToReloadHabits()
        tableView.reloadData()
    }

}

extension HabitsTableViewController {
    
    func setupNavBar() {
        title = "Habitual"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddHabit(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        navigationItem.leftBarButtonItem = self.editButtonItem
    }

    @objc func pressAddHabit(_ sender: UIBarButtonItem) {
        let addHabitVC = AddHabitViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: addHabitVC)
        present(navigationController, animated: true, completion: nil)
        
    }
    
}

extension UIAlertController {
    convenience init(habitTitle: String, confirmHandler: @escaping () -> Void) {
        self.init(title: "Delete habit", message: "Are you sure you want to delete \(habitTitle)?", preferredStyle: .actionSheet)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { _ in
            confirmHandler()
        }
        self.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        self.addAction(cancelAction)
        
    }
}
