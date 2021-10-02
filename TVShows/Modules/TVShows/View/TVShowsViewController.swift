//
//  TVShowsViewController.swift
//  TVShows
//
//  Created by Jorge Flores Carlos on 29/09/21.
//

import UIKit

protocol TVShowsViewControllerProtocol: UIViewController {
    var tvShows: [TVShow] { get set }
    
    var presenter: TVShowsPresenterProtocol? { get set }
    
    func update(with tvShows: [TVShow])
    func update(with error: String)
}

class TVShowsViewController: UIViewController {
    
    var tvShows: [TVShow] = []
    
    var presenter: TVShowsPresenterProtocol?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .indigo
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TVShowTableViewCell.nib, forCellReuseIdentifier: TVShowTableViewCell.identifier)
    }

}

extension TVShowsViewController: TVShowsViewControllerProtocol{
    
    
    func update(with tvShows: [TVShow]) {
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

extension TVShowsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectRow(tvShow: tvShows[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.5
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        guard let editAction = self.presenter?.getEditAction(tvShow: tvShows[indexPath.row]) else {
            return nil
        }
        
        return [editAction]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

extension TVShowsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TVShowTableViewCell.identifier, for: indexPath) as! TVShowTableViewCell
        cell.configure(with: tvShows[indexPath.row])
        return cell
    }
    
    
}
