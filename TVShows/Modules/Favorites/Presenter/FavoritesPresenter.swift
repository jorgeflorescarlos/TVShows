    //
    //  FavoritesPresenter.swift
    //  TVShows
    //
    //  Created by Jorge Flores Carlos on 30/09/21.
    //

import Foundation

import UIKit

protocol FavoritesPresenterProtocol {
    var router: FavoritesRouterProtocol? { get set }
    var interactor: FavoritesInteractorProtocol? { get set }
    var view: FavoritesViewControllerProtocol? { get set }
    
    func interactorDidFetchTVShows(with result: Result<[FavoritesTVShows], Error>)
    func deleteFavoriteTVShow(withTVShow tvShow: FavoritesTVShows)
    func getEditAction(tvShow: FavoritesTVShows) -> UITableViewRowAction?
    func didSelectRow(tvShow: FavoritesTVShows)
    func viewDidLoad()
    func showError(msg: String, completion:@escaping() -> Void)
}

class FavoritesPresenter: FavoritesPresenterProtocol {
    var view: FavoritesViewControllerProtocol?
    
    var router: FavoritesRouterProtocol?
    
    var interactor: FavoritesInteractorProtocol?
    
    
    func viewDidLoad() {
        interactor?.observeFavorites()
    }
    
    func interactorDidFetchTVShows(with result: Result<[FavoritesTVShows], Error>) {
        switch result {
        case .success(let tvShows):
            view?.update(with: tvShows)
        case .failure:
            view?.update(with: "Something went wrong")
        }
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
    
    func deleteFavoriteTVShow(withTVShow tvShow: FavoritesTVShows) {
        self.interactor?.deleteFavorite(tvShow: tvShow)
    }
    
    func getEditAction(tvShow: FavoritesTVShows) -> UITableViewRowAction? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] action, indexPath in
            let alert = UIAlertController(title: "Delete Favorite", message: "Do you really want to remove this tv show from your favorites?", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.destructive, handler: { _ in
                self?.interactor?.deleteFavorite(tvShow: tvShow)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            self?.view?.present(alert, animated: true, completion: nil)
            
        }
        return deleteAction
        
    }
    
    func didSelectRow(tvShow: FavoritesTVShows) {
        self.interactor?.navigateToDetail(tvShow: tvShow)
    }
}
