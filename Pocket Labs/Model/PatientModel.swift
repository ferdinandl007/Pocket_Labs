//
//  PatientModel.swift
//  Pocket Labs
//
//  Created by Ferdinand Lösch on 16/11/2019.
//  Copyright © 2019 Ferdinand Lösch. All rights reserved.
//

import Foundation

import  UIKit

class PatientModel: NSObject {
    let name: String!
    let age: String!
    var pos: String!
    let image: UIImage!
    let percentage: String!
    init(name: String, age: String, pos: String,image: UIImage,percentage: String) {
        self.name = name
        self.age = age
        self.pos = pos
        self.image = image
        self.percentage = percentage
    }
}

class itemModelList: NSObject {
    var arry: [PatientModel]
    let title: String
    init(arr: [PatientModel], titel: String) {
        arry = arr
        title = titel
    }
}


