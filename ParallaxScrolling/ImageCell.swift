//
//  ImageCell.swift
//  ParallaxScrolling
//
//  Created by Pedro Rolon on 2020-12-08.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet weak var parallaxImage: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var parallaxImageHeight: NSLayoutConstraint!
    @IBOutlet weak var parallaxTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var gradientView: UIView!
    let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        parallaxImage.clipsToBounds = true
        
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.systemPink.withAlphaComponent(0.3).cgColor
        ]
        
        gradientView.layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = gradientView.frame
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(title: String, image: UIImage) {
        self.imageTitle.text = title
        self.parallaxImage.image = image
    }

}
