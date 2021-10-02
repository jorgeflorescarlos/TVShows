//
//  FavoritesInteractor.swift
//  TVShows
//
//  Created by Jorge Flores Carlos on 30/09/21.
//

import Foundation

protocol FavoritesInteractorProtocol {
    var presenter : FavoritesPresenterProtocol? { get set }
    var router : FavoritesRouterProtocol? { get set }
    func observeFavorites()
    func getFavorites()
    func deleteFavorite(tvShow: FavoritesTVShows)
    func navigateToDetail(tvShow: FavoritesTVShows)
}

class FavoritesInteractor: FavoritesInteractorProtocol {
    var presenter: FavoritesPresenterProtocol?
    var router : FavoritesRouterProtocol?
    
    func observeFavorites() {
        getFavorites()
        NotificationCenter.default.addObserver(self, selector: #selector(getFavorites), name: Notification.Name("favoritesUpdated"), object: nil)
    }
    
    @objc func getFavorites() {
        CoreDataManager.instance.list { [weak self] (result: Result<[FavoritesTVShows], Error>) in
            switch result {
            case .success(let tvShows):
                self?.presenter?.interactorDidFetchTVShows(with: .success(tvShows))
                
            case.failure(let error):
                self?.presenter?.interactorDidFetchTVShows(with: .failure(error))
            }
        }
    }
    
    func deleteFavorite(tvShow: FavoritesTVShows) {
        CoreDataManager.instance.delete(withTVShow: tvShow) { [weak self] (result: Result<FavoritesTVShows, Error>) in
            switch result {
            case .success(_):
                NotificationCenter.default.post(name: Notification.Name("favoritesUpdated"), object: nil)
            case.failure(_):
                self?.getFavorites()
            }
        }
    }
    
    func navigateToDetail(tvShow: FavoritesTVShows){
        self.router?.goToDetail(withTVShow: tvShow)
    }
}
