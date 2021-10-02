    //
    //  TVShowDetailPresenter.swift
    //  TVShows
    //
    //  Created by Jorge Flores Carlos on 01/10/21.
    //

import Foundation
import UIKit

protocol TVShowDetailPresenterProtocol {
    var router: TVShowDetailRouterProtocol? { get set }
    var interactor: TVShowDetailInteractorProtocol? { get set }
    var view: TVShowDetailViewControllerProtocol? { get set }
    
    func getButtonItem(isFavorite: Bool?, isOnFavoritesTab: Bool) -> UIBarButtonItem
    func toggleFavoriteAction()
    func interactorDidFetchTVShow(withTVShow tvShow: TVShow)
    func interactorDidFetchTVShow(withTVShow tvShow: FavoritesTVShows)
    func interactorSaveFavoriteTVShow(withTVShow tvShow: TVShow)
    func showError(msg: String, completion:@escaping() -> Void)
}

class TVShowDetailPresenter: TVShowDetailPresenterProtocol {
    
    var tvShow: TVShow?
    
    var favoriteTVShow: FavoritesTVShows?
    
    var view: TVShowDetailViewControllerProtocol?
    
    var router: TVShowDetailRouterProtocol?
    
    var interactor: TVShowDetailInteractorProtocol?
    
    func interactorDidFetchTVShow(withTVShow tvShow: TVShow) {
        self.tvShow = tvShow
        view?.displayTVShow(with: tvShow)
        
    }
    
    func interactorDidFetchTVShow(withTVShow tvShow: FavoritesTVShows) {
        self.favoriteTVShow = tvShow
        view?.displayTVShow(with: tvShow)
        
    }
    
    func showError(msg: String, completion:@escaping()->Void){
        
        let alert = UIAlertController(title: "Oops, algo salió mal!", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Continuar", style: UIAlertAction.Style.default, handler: { _ in
            completion()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

        DispatchQueue.main.async {
            self.view?.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func interactorSaveFavoriteTVShow(withTVShow tvShow: TVShow) {
        interactor?.saveFavorite(tvShow: tvShow)
    }
    
    @objc func toggleFavoriteAction() {
        self.tvShow = self.view?.tvShow
        guard let tvShow = self.tvShow else {return }
        if let favorite = self.tvShow?.isFavorite, favorite == true {
            let alert = UIAlertController(title: "Delete Favorite", message: "Do you really want to remove this tv show from your favorites?", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.destructive, handler: { _ in
                self.interactor?.deleteFavorite(tvShow: tvShow)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            self.view?.present(alert, animated: true, completion: nil)
        } else {
            self.interactorSaveFavoriteTVShow(withTVShow: tvShow)
        }
    }
    
    @objc func deleteFavoriteAction() {
        
            let alert = UIAlertController(title: "Delete Favorite", message: "Do you really want to remove this tv show from your favorites?", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.destructive, handler: { _ in
                self.interactor?.deleteFavorite(tvShow: self.favoriteTVShow!)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            self.view?.present(alert, animated: true, completion: nil)
        
    }
    
    func getButtonItem(isFavorite: Bool?, isOnFavoritesTab: Bool) -> UIBarButtonItem {
        if isOnFavoritesTab {
            if #available(iOS 13.0, *) {
                let favoriteBtn = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle.fill"), style: .plain, target: self, action: #selector(deleteFavoriteAction))
                return favoriteBtn
            } else {
                let favoriteBtn = UIBarButtonItem(title: "Delete", style: .plain, target: self, action:  #selector(deleteFavoriteAction))
                return favoriteBtn
            }
        }
        if isFavorite ?? false {
            if #available(iOS 13.0, *) {
                let favoriteBtn = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle.fill"), style: .plain, target: self, action: #selector(toggleFavoriteAction))
                return favoriteBtn
            } else {
                let favoriteBtn = UIBarButtonItem(title: "Delete", style: .plain, target: self, action:  #selector(toggleFavoriteAction))
                return favoriteBtn
            }
        } else {
            let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:  #selector(toggleFavoriteAction))
            return add
        }
    }
}
