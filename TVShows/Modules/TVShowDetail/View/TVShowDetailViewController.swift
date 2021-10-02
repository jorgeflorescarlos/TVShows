    //
    //  TVShowDetailViewController.swift
    //  TVShows
    //
    //  Created by Jorge Flores Carlos on 01/10/21.
    //

import UIKit

protocol TVShowDetailViewControllerProtocol: UIViewController {
    var tvShow: TVShow? { get set }
    var favoriteTvShow: FavoritesTVShows? { get set }
    
    var presenter: TVShowDetailPresenterProtocol? { get set }
    
    func displayTVShow(with tvShow: TVShow)
    func displayTVShow(with tvShow: FavoritesTVShows)
}

class TVShowDetailViewController: UIViewController {
    var tvShow: TVShow?
    var favoriteTvShow: FavoritesTVShows?
    
    var presenter: TVShowDetailPresenterProtocol?
    
    @IBOutlet weak var scrollView: UIScrollView!
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(systemName: "photo")
        }
        return imageView
    }()
    
    private let imageViewCover: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(systemName: "photo")
        }
        return imageView
    }()
    
    private let imdbBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    let contentView = UIView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let summaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupScrollView()
        setupViews()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.isTranslucent = true
        view.backgroundColor = .black
        
        
        imdbBtn.setTitle("See on IMDB", for: .normal)
        navigationController?.navigationBar.tintColor = .white
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
    }
    
    func setupScrollView(){
        scrollView.backgroundColor = .black
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -90).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func setupViews(){
        contentView.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -1).isActive = true
        imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(blurEffectView)
        blurEffectView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        blurEffectView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -1).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        blurEffectView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        contentView.addSubview(imageViewCover)
        imageViewCover.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageViewCover.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100).isActive = true
        imageViewCover.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/5).isActive = true
        imageViewCover.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/5).isActive = true
        
        contentView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageViewCover.bottomAnchor, constant: 20).isActive = true
        
        contentView.addSubview(summaryLabel)
        summaryLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        summaryLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 8/9).isActive = true
        
        contentView.addSubview(imdbBtn)
        imdbBtn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imdbBtn.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 30).isActive = true
        imdbBtn.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/2).isActive = true
        imdbBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imdbBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60).isActive = true
    }
    
}

extension TVShowDetailViewController: TVShowDetailViewControllerProtocol {
    
    func displayTVShow(with tvShow: TVShow) {
        self.tvShow = tvShow
        if #available(iOS 13.0, *) {
            imageView.sd_setImage(with: URL(string: tvShow.image.original), placeholderImage: UIImage(systemName: "tv"))
            imageViewCover.sd_setImage(with: URL(string: tvShow.image.original), placeholderImage: UIImage(systemName: "tv"))
        } else {
            imageView.sd_setImage(with: URL(string: tvShow.image.original), placeholderImage: UIImage())
            imageViewCover.sd_setImage(with: URL(string: tvShow.image.original), placeholderImage: UIImage())
        }
        title = tvShow.name
        titleLabel.text = tvShow.name
        summaryLabel.text = tvShow.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        if tvShow.externals.imdb != nil {
            imdbBtn.isHidden = false
            imdbBtn.addTarget(self, action: #selector(goToIMDB), for: .touchUpInside)
        }
        let btnItem = self.presenter?.getButtonItem(isFavorite: tvShow.isFavorite, isOnFavoritesTab: false)
        navigationItem.rightBarButtonItem = btnItem
    }
    
    func displayTVShow(with tvShow: FavoritesTVShows) {
        self.favoriteTvShow = tvShow
        
        if let data = tvShow.img, let img = UIImage(data: data) {
            self.imageViewCover.image = img
            self.imageView.image = img
        }
        title = tvShow.name
        titleLabel.text = tvShow.name
        summaryLabel.text = tvShow.summary?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        if tvShow.imdb_id != nil {
            imdbBtn.isHidden = false
            imdbBtn.addTarget(self, action: #selector(goToIMDB), for: .touchUpInside)
        }
        let btnItem = self.presenter?.getButtonItem(isFavorite: true, isOnFavoritesTab: true)
        navigationItem.rightBarButtonItem = btnItem
    }
    
    @objc func goToIMDB() {
        guard let id = tvShow?.externals.imdb else {
            guard let id = favoriteTvShow?.imdb_id else {
                return
            }
            presenter?.interactor?.goToIMDB(withUrl:"https://www.imdb.com/title/\(id)")
            return
        }
        presenter?.interactor?.goToIMDB(withUrl:"https://www.imdb.com/title/\(id)")
    }
}
