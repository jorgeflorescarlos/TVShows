//
//  TVSNavigationController.swift
//  TVShows
//
//  Created by Jorge Flores Carlos on 30/09/21.
//

import UIKit

class TVSNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .always
            navigationBar.prefersLargeTitles = true
            navigationBar.largeTitleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .regular)
            ]
            
            navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
        }
        
        navigationBar.backgroundColor = .indigo
        
    }

}
