//
//  HaderCell.swift
//  Pocket Labs
//
//  Created by Ferdinand Lösch on 16/11/2019.
//  Copyright © 2019 Ferdinand Lösch. All rights reserved.
//

//
import Reusable
import UIKit

class HaderCell: UICollectionViewCell, NibReusable {
    weak var delegate: ButtonDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = false
        // Initialization code
    }

    @IBAction func button(_: Any) {
        delegate?.didClick()
    }
}

extension UIButton {
    open override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                    self.transform = self.transform.scaledBy(x: 0.75, y: 0.75)
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
                }, completion: nil)
            }
        }
    }
}
