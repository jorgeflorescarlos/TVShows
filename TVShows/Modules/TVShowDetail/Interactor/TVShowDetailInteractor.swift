//
//  TVShowDetailInteractor.swift
//  TVShows
//
//  Created by Jorge Flores Carlos on 01/10/21.
//

import Foundation

protocol TVShowDetailInteractorProtocol {
    var presenter : TVShowDetailPresenterProtocol? { get set }
    
    func goToIMDB(withUrl url: String)
    func provideTVShow(withTVShow tvShow: TVShow)
    func saveFavorite(tvShow: TVShow)
    func deleteFavorite(tvShow: TVShow)
    func deleteFavorite(tvShow: FavoritesTVShows)
}

class TVShowDetailInteractor: TVShowDetailInteractorProtocol {
    var favorites: [FavoritesTVShows]?
    var presenter: TVShowDetailPresenterProtocol?
    
    
    func provideTVShow(withTVShow tvShow: TVShow) {
        self.presenter?.interactorDidFetchTVShow(withTVShow: tvShow)
    }
    
    @objc func goToIMDB(withUrl url: String) {
        GlobalDataManager.instance.openURL(withString: url)
    }
    
    func notificateToApp(){

    }
    
    func saveFavorite(tvShow: TVShow) {
        CoreDataManager.instance.save(withTVShow: tvShow) { [weak self] (result: Result<FavoritesTVShows, Error>) in
            switch result {
            case .success(_):
                NotificationCenter.default.post(name: Notification.Name("favoritesUpdated"), object: nil)
                var newTVShow = tvShow
                newTVShow.updateFavoriteStatus(true)
                self?.provideTVShow(withTVShow: newTVShow)
            case.failure(let error):
                self?.presenter?.showError(msg: error.localizedDescription, completion: {
                    self?.saveFavorite(tvShow: tvShow)
                })
            }
        }
    }
    
    func deleteFavorite(tvShow: TVShow) {
        CoreDataManager.instance.delete(withTVShow: tvShow) { [weak self] (result: Result<FavoritesTVShows, Error>) in
            switch result {
            case .success(_):
                NotificationCenter.default.post(name: Notification.Name("favoritesUpdated"), object: nil)
                var newTVShow = tvShow
                newTVShow.updateFavoriteStatus(false)
                self?.provideTVShow(withTVShow: newTVShow)
            case.failure(let error):
                self?.presenter?.showError(msg: error.localizedDescription, completion: {
                    self?.deleteFavorite(tvShow: tvShow)
                })
            }
        }
    }
    
    func deleteFavorite(tvShow: FavoritesTVShows) {
        CoreDataManager.instance.delete(withTVShow: tvShow) { [weak self] (result: Result<FavoritesTVShows, Error>) in
            switch result {
            case .success(_):
                NotificationCenter.default.post(name: Notification.Name("favoritesUpdated"), object: nil)
                self?.presenter?.router?.returnToRootController()
            case.failure(let error):
                self?.presenter?.showError(msg: error.localizedDescription, completion: {
                    self?.deleteFavorite(tvShow: tvShow)
                })
            }
        }
    }
}
