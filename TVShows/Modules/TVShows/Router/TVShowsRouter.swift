//
//  TVShowsRouter.swift
//  TVShows
//
//  Created by Jorge Flores Carlos on 30/09/21.
//

import Foundation
import UIKit

protocol TVShowsRouterProtocol {
    var entry: TVShowsViewControllerProtocol? { get }
    
    static func start() -> TVShowsRouterProtocol
    func goToDetail(withTVShow tvShow: TVShow)
}

class TVShowsRouter: TVShowsRouterProtocol {
    
    var entry: TVShowsViewControllerProtocol?
    
    static func start() -> TVShowsRouterProtocol {
        let router = TVShowsRouter()
        
        // Assign VIP
        let view: TVShowsViewControllerProtocol = TVShowsViewController()
        var presenter: TVShowsPresenterProtocol = TVShowsPresenter()
        var interactor: TVShowsInteractorProtocol = TVShowsInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.router = router
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view
        
        return router
    }
    
    func goToDetail(withTVShow tvShow: TVShow) {
        let tvShowDetailRouter = TVShowDetailRouter.start()

        guard let tvShowDetailVC = tvShowDetailRouter.entry else { return }
        tvShowDetailRouter.entry?.presenter?.interactorDidFetchTVShow(withTVShow: tvShow)
        self.entry?.presenter?.view?.navigationController?.pushViewController(tvShowDetailVC, animated: true)
    }
    
}
