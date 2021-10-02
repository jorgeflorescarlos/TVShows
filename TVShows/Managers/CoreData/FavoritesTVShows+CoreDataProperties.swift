//
//  FavoritesTVShows+CoreDataProperties.swift
//  TVShows
//
//  Created by Jorge Flores Carlos on 30/09/21.
//
//

import Foundation
import CoreData

extension FavoritesTVShows {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritesTVShows> {
        return NSFetchRequest<FavoritesTVShows>(entityName: "FavoritesTVShows")
    }

    @NSManaged public var id: Int64
    @NSManaged public var imdb_id: String?
    @NSManaged public var img: Data?
    @NSManaged public var name: String?
    @NSManaged public var summary: String?

}
