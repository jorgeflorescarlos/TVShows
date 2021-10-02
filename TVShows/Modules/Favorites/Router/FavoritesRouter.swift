//
//  FavoritesRouter.swift
//  TVShows
//
//  Created by Jorge Flores Carlos on 30/09/21.
//

import Foundation
import UIKit

protocol FavoritesRouterProtocol {
    var entry: FavoritesViewControllerProtocol? { get }
    func goToDetail(withTVShow: FavoritesTVShows)
    
    static func start() -> FavoritesRouterProtocol
}

class FavoritesRouter: FavoritesRouterProtocol {
    
    var entry: FavoritesViewControllerProtocol?
    
    static func start() -> FavoritesRouterProtocol {
        let router = FavoritesRouter()
        
        let view: FavoritesViewControllerProtocol = FavoritesViewController()
        var presenter: FavoritesPresenterProtocol = FavoritesPresenter()
        var interactor: FavoritesInteractorProtocol = FavoritesInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.router = router
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view
        
        return router
    }
    
    func goToDetail(withTVShow tvShow: FavoritesTVShows) {
        let tvShowDetailRouter = TVShowDetailRouter.start()

        guard let tvShowDetailVC = tvShowDetailRouter.entry else { return }
        tvShowDetailRouter.entry?.presenter?.interactorDidFetchTVShow(withTVShow: tvShow)
        self.entry?.presenter?.view?.navigationController?.pushViewController(tvShowDetailVC, animated: true)
    }
    
}
