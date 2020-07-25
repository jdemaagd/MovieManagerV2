//
//  UIViewController+Extensions.swift
//  MovieManager
//
//  Created by JON DEMAAGD on 7/22/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - ViewControllers IBAction
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        Client.logout {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
