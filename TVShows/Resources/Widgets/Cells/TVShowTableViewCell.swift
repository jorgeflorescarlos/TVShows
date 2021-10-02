//
//  TVShowTableViewCell.swift
//  TVShows
//
//  Created by Jorge Flores Carlos on 30/09/21.
//

import UIKit
import SDWebImage

class TVShowTableViewCell: UITableViewCell {
    
    static let identifier = "TVShowTableViewCell"
    static let nib = UINib(nibName: "TVShowTableViewCell", bundle: .main)
   
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cover: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with tvShow: TVShow) {
        title.text = tvShow.name
        let photo = tvShow.image.medium
        if #available(iOS 13.0, *) {
            self.cover.sd_setImage(with: URL(string: photo), placeholderImage: UIImage(systemName: "tv"))
        } else {
            self.cover.sd_setImage(with: URL(string: photo), placeholderImage: UIImage())
        }
    }
    
    func configure(with tvShow: FavoritesTVShows) {
        title.text = tvShow.name
        if let data = tvShow.img, let img = UIImage(data: data) {
            self.cover.image = img
        }else {
            if #available(iOS 13.0, *) {
                self.cover.image = UIImage(systemName: "tv")
            } else {
                
            }
        }
    }
    
}
