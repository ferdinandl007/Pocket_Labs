//
//  PersonCollectionViewCell.swift
//  Pocket Labs
//
//  Created by Ferdinand Lösch on 16/11/2019.
//  Copyright © 2019 Ferdinand Lösch. All rights reserved.
//

import Reusable
import UIKit
import UICircularProgressRing
class PersonCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet var Background: UIView!
    @IBOutlet var image: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var age: UILabel!
    @IBOutlet var pos: UILabel!
    @IBOutlet weak var p1: UICircularProgressRing!
    @IBOutlet weak var p2: UICircularProgressRing!
    @IBOutlet weak var p3: UICircularProgressRing!
    var trip = (0,0,0)
    
    public func configer(model: PatientModel) {
        self.image.image = model.image
        self.age.text = model.age
        self.name.text = model.name
        self.pos.text = model.pos
        trip.0 = model.p1
        trip.1 = model.p2
        trip.2 = model.p3
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
        self.image.layer.masksToBounds = false
        self.image.layer.borderColor = UIColor.black.cgColor
        self.image.layer.cornerRadius = image.frame.height/2
        self.image.clipsToBounds = true
        p1.startProgress(to: CGFloat(trip.0), duration: 2.0)
        p2.startProgress(to: CGFloat(trip.1), duration: 2.0)
        p3.startProgress(to: CGFloat(trip.2), duration: 2.0)
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
