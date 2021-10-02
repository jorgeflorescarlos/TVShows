    //
    //  FavoritesViewController.swift
    //  TVShows
    //
    //  Created by Jorge Flores Carlos on 29/09/21.
    //

import UIKit

protocol FavoritesViewControllerProtocol: UIViewController {
    var tvShows: [FavoritesTVShows]{ get set }
    var presenter: FavoritesPresenterProtocol? { get set }
    
    func update(with tvShows: [FavoritesTVShows])
    func update(with error: String)
}

class FavoritesViewController: UIViewController {
    
    var tvShows: [FavoritesTVShows] = []
    
    var presenter: FavoritesPresenterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .indigo
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TVShowTableViewCell.nib, forCellReuseIdentifier: TVShowTableViewCell.identifier)
    }
    
}

extension FavoritesViewController: FavoritesViewControllerProtocol{
    
    
    func update(with tvShows: [FavoritesTVShows]) {
        DispatchQueue.main.async {
            self.tvShows = tvShows
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.tvShows = []
            self.tableView.isHidden = true
        }
    }
}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectRow(tvShow: tvShows[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.5
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard let deleteAction = self.presenter?.getEditAction(tvShow: tvShows[indexPath.row]) else {return nil}
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TVShowTableViewCell.identifier, for: indexPath) as! TVShowTableViewCell
        cell.configure(with: tvShows[indexPath.row])
        return cell
    }
    
    
}

