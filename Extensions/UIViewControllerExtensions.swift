//
//  UIViewControllerExtensions.swift
//  Habitual
//
//  Created by Rinni Swift on 11/15/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import UIKit

extension UIViewController {
    static func instantiate() -> Self {
        return self.init(nibName: String(describing: self), bundle: nil)
    }
}
