//
//  AddHabitViewController.swift
//  Habitual
//
//  Created by Rinni Swift on 11/18/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import UIKit

class AddHabitViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func pickPhotoButtonPressed(_ sender: UIButton) {
        guard let selectedindexPath = collectionView.indexPathsForSelectedItems?.first else { return }
        let confirmHabitVC = ConfirmHabitViewController.instantiate()
        confirmHabitVC.habitImage = habitImages[selectedindexPath.row]
        navigationController?.pushViewController(confirmHabitVC, animated: true)
    }
    
    let habitImages = Habit.Images.allCases
    

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(HabitImageCollectionViewCell.nib, forCellWithReuseIdentifier: HabitImageCollectionViewCell.identifier)
        
        setupNavBar()
        
        collectionView.allowsMultipleSelection = false
    }
    
    func setupNavBar() {
        title = "Select Image"
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAddHabit(_:)))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc func cancelAddHabit(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    

}

extension AddHabitViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitImageCollectionViewCell.identifier, for: indexPath) as! HabitImageCollectionViewCell
        cell.setImage(image: habitImages[indexPath.row].image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth / 4, height: collectionViewWidth / 4)
    }
}

extension AddHabitViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.yellow.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderWidth = 0.0
        
    }
    
}

extension AddHabitViewController: UICollectionViewDelegateFlowLayout {
    
}
