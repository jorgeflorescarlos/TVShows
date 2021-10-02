    //
    //  TVShowsDataManager.swift
    //  TVShows
    //
    //  Created by Jorge Flores Carlos on 30/09/21.
    //

import UIKit
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    
    func list(completion: @escaping(Result<[FavoritesTVShows], Error>) -> Void) {
        DispatchQueue.main.async {
            do {
                let context = GlobalDataManager.instance.getContext()
                var shows = [FavoritesTVShows]()
                shows = try context.fetch(FavoritesTVShows.fetchRequest())
                completion(.success(shows))
            } catch {
                completion(.failure(TVMazeApi.APIError.failedToManageLocalData))
            }
        }
        
    }
    
    func save(withTVShow show: TVShow, completion: @escaping(Result<FavoritesTVShows, Error>) -> Void) {
        do {
            let context = GlobalDataManager.instance.getContext()
            let newItem = FavoritesTVShows(context: context)
            newItem.name = show.name
            newItem.imdb_id = show.externals.imdb
            newItem.id = Int64(show.id)
            newItem.summary = show.summary
            newItem.img = try Data(contentsOf: URL(string: show.image.original)!)
            try context.save()
            completion(.success(newItem))
        } catch {
            completion(.failure(TVMazeApi.APIError.failedToManageLocalData))
        }
    }
    
    func delete(withTVShow show: FavoritesTVShows, completion: @escaping(Result<FavoritesTVShows, Error>) -> Void){
        let context = GlobalDataManager.instance.getContext()
        context.delete(show)
        do {
            try context.save()
            completion(.success(show))
        } catch {
            completion(.failure(TVMazeApi.APIError.failedToManageLocalData))
        }
    }
    
    func delete(withTVShow show: TVShow, completion: @escaping(Result<FavoritesTVShows, Error>) -> Void){
        do {
            let context = GlobalDataManager.instance.getContext()
            var shows = [FavoritesTVShows]()
            shows = try context.fetch(FavoritesTVShows.fetchRequest())
            guard let showDB = shows.filter({ tvShow in
                tvShow.id == show.id
            }).first else {
                completion(.failure(TVMazeApi.APIError.failedToManageLocalData))
                return
            }
            context.delete(showDB)
            try context.save()
            completion(.success(showDB))
        } catch {
            completion(.failure(TVMazeApi.APIError.failedToManageLocalData))
        }
    }
}
