//
//  TVShowDetailRouter.swift
//  TVShows
//
//  Created by Jorge Flores Carlos on 01/10/21.
//

import Foundation
import UIKit

protocol TVShowDetailRouterProtocol {
    var entry: TVShowDetailViewControllerProtocol? { get }
    
    static func start() -> TVShowDetailRouterProtocol
    
    func returnToRootController()
}

class TVShowDetailRouter: TVShowDetailRouterProtocol {
    
    var entry: TVShowDetailViewControllerProtocol?
    
    static func start() -> TVShowDetailRouterProtocol {
        let router = TVShowDetailRouter()
        
        // Assign VIP
        let view: TVShowDetailViewControllerProtocol = TVShowDetailViewController()
        var presenter: TVShowDetailPresenterProtocol = TVShowDetailPresenter()
        var interactor: TVShowDetailInteractorProtocol = TVShowDetailInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view
        
        return router
    }
    
    func returnToRootController(){
        entry?.navigationController?.popViewController(animated: true)
    }
    
}
