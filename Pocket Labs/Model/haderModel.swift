//
//  haderModel.swift
//  Pocket Labs
//
//  Created by Ferdinand Lösch on 16/11/2019.
//  Copyright © 2019 Ferdinand Lösch. All rights reserved.
//

import Foundation

class HaderModel: NSObject {
    let completed: Int!
    let scheduled: Int!
    init(completed: Int, scheduled: Int) {
        self.completed = completed
        self.scheduled = scheduled
    }
}
