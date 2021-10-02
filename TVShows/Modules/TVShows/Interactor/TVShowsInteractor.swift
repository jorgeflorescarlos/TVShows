//
//  TVShowsInteractor.swift
//  TVShows
//
//  Created by Jorge Flores Carlos on 30/09/21.
//

import Foundation

protocol TVShowsInteractorProtocol {
    var presenter : TVShowsPresenterProtocol? { get set }
    var router : TVShowsRouterProtocol? { get set }
    
    func getTVShows()
    func observeFavorites()
    func saveFavorite(tvShow: TVShow)
    func deleteFavorite(tvShow: TVShow)
    func navigateToDetail(tvShow: TVShow)
}

class TVShowsInteractor: TVShowsInteractorProtocol {
    var favorites: [FavoritesTVShows]?
    var presenter: TVShowsPresenterProtocol?
    var router : TVShowsRouterProtocol?
    
    @objc func getTVShows() {
        let url = "\(TVMazeApi.BASEURL)shows?page=0"
        
        APICaller.instance.get(withUrl: url) { [weak self] (result: Result<[TVShow], Error>) in
            switch result {
            case .success(let tvShows):
                self?.getFavoriteTVShows { (result: Result<[FavoritesTVShows], Error>) in
                    switch result{
                    case .success(let favoriteShows):
                        let shows = tvShows.map { tvShow -> TVShow in
                            let results = favoriteShows.filter { $0.id == tvShow.id }
                            if !results.isEmpty {
                                return TVShow(id: tvShow.id, isFavorite: true, name: tvShow.name, externals: tvShow.externals, image: tvShow.image, summary: tvShow.summary)
                            }
                            return tvShow
                        }
                        DispatchQueue.main.async {
                            self?.presenter?.interactorDidFetchTVShows(with: .success(shows))
                        }
                        
                    case .failure(_):
                        DispatchQueue.main.async {
                            self?.presenter?.interactorDidFetchTVShows(with: .success(tvShows))
                        }
                    }
                
                }
                
            case.failure(let error):
                self?.presenter?.showError(msg: error.localizedDescription, completion: {
                    self?.getTVShows()
                })
            }
        }
    }
    
    func observeFavorites(){
        NotificationCenter.default.addObserver(self, selector: #selector(getTVShows), name: Notification.Name("favoritesUpdated"), object: nil)
    }
    
    func saveFavorite(tvShow: TVShow) {
        CoreDataManager.instance.save(withTVShow: tvShow) { [weak self] (result: Result<FavoritesTVShows, Error>) in
            switch result {
            case .success(_):
                NotificationCenter.default.post(name: Notification.Name("favoritesUpdated"), object: nil)
                self?.getTVShows()
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
                self?.getTVShows()
            case.failure(let error):
                self?.presenter?.showError(msg: error.localizedDescription, completion: {
                    self?.deleteFavorite(tvShow: tvShow)
                })
            }
        }
    }
    
    func getFavoriteTVShows(completion: @escaping(Result<[FavoritesTVShows],Error>)->Void) {
        CoreDataManager.instance.list {(result: Result<[FavoritesTVShows], Error>) in
            switch result {
            case .success(let tvShows):
                completion(.success(tvShows))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func navigateToDetail(tvShow: TVShow) {
        self.router?.goToDetail(withTVShow: tvShow)
    }
}
