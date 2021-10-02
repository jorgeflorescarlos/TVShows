    //
    //  TVShowsPresenter.swift
    //  TVShows
    //
    //  Created by Jorge Flores Carlos on 30/09/21.
    //

import Foundation
import UIKit

protocol TVShowsPresenterProtocol {
    var router: TVShowsRouterProtocol? { get set }
    var interactor: TVShowsInteractorProtocol? { get set }
    var view: TVShowsViewControllerProtocol? { get set }
    
    func getEditAction(tvShow: TVShow) -> UITableViewRowAction?
    func didSelectRow(tvShow: TVShow)
    func interactorDidFetchTVShows(with result: Result<[TVShow], Error>)
    func interactorSaveFavoriteTVShow(withTVShow tvShow: TVShow)
    func showError(msg: String, completion:@escaping()->Void)
}

class TVShowsPresenter: TVShowsPresenterProtocol {
    
    var view: TVShowsViewControllerProtocol?
    
    var router: TVShowsRouterProtocol?
    
    var interactor: TVShowsInteractorProtocol? {
        didSet {
            interactor?.getTVShows()
            interactor?.observeFavorites()
        }
    }
    
    func interactorDidFetchTVShows(with result: Result<[TVShow], Error>) {
        switch result {
        case .success(let tvShows):
            view?.update(with: tvShows)
        case .failure:
            view?.update(with: "Something went wrong")
        }
    }
    
    func interactorSaveFavoriteTVShow(withTVShow tvShow: TVShow) {
        interactor?.saveFavorite(tvShow: tvShow)
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
    
    func getEditAction(tvShow: TVShow) -> UITableViewRowAction? {
        if let favorite = tvShow.isFavorite, favorite == true {
            let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] action, indexPath in
                let alert = UIAlertController(title: "Delete Favorite", message: "Do you really want to remove this tv show from your favorites?", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.destructive, handler: { _ in
                    self?.interactor?.deleteFavorite(tvShow: tvShow)
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
                self?.view?.present(alert, animated: true, completion: nil)
                
            }
            return deleteAction
        } else {
            let favoriteAction = UITableViewRowAction(style: .default, title: "Favorite") { [weak self] action, indexPath in
                self?.interactorSaveFavoriteTVShow(withTVShow: tvShow)
            }
            favoriteAction.backgroundColor = .systemGreen
            return favoriteAction
        }
    }
    
    func didSelectRow(tvShow: TVShow) {
        self.interactor?.navigateToDetail(tvShow: tvShow)
    }
    
}
