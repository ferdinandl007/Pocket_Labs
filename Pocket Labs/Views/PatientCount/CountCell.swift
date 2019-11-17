//
//  CountCell.swift
//  Pocket Labs
//
//  Created by Ferdinand Lösch on 16/11/2019.
//  Copyright © 2019 Ferdinand Lösch. All rights reserved.
//

import Reusable
import UIKit

class CountCell: UICollectionViewCell, NibReusable {
    @IBOutlet var copm: UILabel!
    @IBOutlet var donn: UILabel!
    var com = 0
    var p = 0
    let defaults = UserDefaults.standard
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(copm: Int, donn: Int) {
        self.copm.text = "\(copm)"
        self.donn.text = "\(donn)"
        com = copm
        p = donn
    }

    @IBAction func button(_: Any) {
        p += 1
        donn.text = "\(p)"
        defaults.set(com, forKey: "copm")
        defaults.set(p, forKey: "donn")
        print("gg")
    }
}
