//
import Reusable
//  TitleCell.swift
//  Finderr
//
//  Created by Ferdinand Lösch on 24/02/2019.
//  Copyright © 2019 Ferdinand Lösch. All rights reserved.
//
import UIKit
protocol ButtonDelegate: class {
    func didClick()
}

class TitleCell: UICollectionViewCell, NibReusable {

    @IBOutlet var roomLabel: UILabel!
    weak var delegate: ButtonDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = false
        // Initialization code
    }

    @IBAction func button(_: Any) {
        delegate?.didClick()
    }

    public func configure(with name: String) {
        roomLabel.text = name
    }
}
