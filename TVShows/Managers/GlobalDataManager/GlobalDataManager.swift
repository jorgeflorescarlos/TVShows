//
//  GlobalDataManager.swift
//  TVShows
//
//  Created by Jorge Flores Carlos on 02/10/21.
//

import Foundation
import CoreData
import UIKit

class GlobalDataManager {
    static let instance = GlobalDataManager()
    
    func getContext()-> NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func openURL(withString urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}
