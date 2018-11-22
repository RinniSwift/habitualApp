//
//  HabitImageCollectionViewCell.swift
//  Habitual
//
//  Created by Rinni Swift on 11/18/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import UIKit

class HabitImageCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    @IBOutlet weak var habitImage: UIImageView!

    static let identifier = "habitImageCell"
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    func setImage(image: UIImage) {
        self.habitImage.image = image
    }

}
