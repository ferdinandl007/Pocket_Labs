//
//  PersonCollectionViewCell.swift
//  Pocket Labs
//
//  Created by Ferdinand Lösch on 16/11/2019.
//  Copyright © 2019 Ferdinand Lösch. All rights reserved.
//

import UIKit
import Reusable

class PersonCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet var Background: UIView!
    @IBOutlet var image: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var age: UILabel!
    @IBOutlet var pos: UILabel!
    
    public func configer(image: UIImage, label: String,name: String, age: String, pos: String) {
        self.label.text = label
        self.image.image = image
        self.age.text = age
        self.name.text = name
        self.pos.text = pos
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        Background.layer.masksToBounds = false
        Background.layer.borderColor = UIColor.white.cgColor
        Background.layer.cornerRadius = 10
        Background.clipsToBounds = true
        backgroundColor = UIColor.clear
        clipsToBounds = false
        backgroundColor = UIColor.clear
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowOpacity = 0.12
        layer.shadowRadius = 10
        
    }



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                    self.transform = self.transform.scaledBy(x: 0.97, y: 0.97)
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
                }, completion: nil)
            }
        }
    }
}
