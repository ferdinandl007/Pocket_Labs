//
//  File.swift
//  Pocket Labs
//
//  Created by Ferdinand Lösch on 16/11/2019.
//  Copyright © 2019 Ferdinand Lösch. All rights reserved.
//

import IGListKit
import Reusable
import SceneKit
import UIKit


class ItemController: ListSectionController {
    var model: itemModelList!

    override init() {
        super.init()
        inset = UIEdgeInsets(top: 10, left: 24, bottom: 15, right: 24)
        minimumLineSpacing = 22
        minimumInteritemSpacing = 22
    }

}


extension ItemController {
    override func numberOfItems() -> Int {
        return model.arry.count
    }

    override func sizeForItem(at index: Int) -> CGSize {
         guard let context = collectionContext else { return .zero }
               if index == 0 {
                   return CGSize(width: context.containerSize.width - 48, height: 68)
               } else {
                   return CGSize(width: 152, height: 152)
               }
       
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        if index != 0 {
            let callData = model.arry[index]
            let cell = collectionContext!.dequeueReusableCell(withNibName: PersonCollectionViewCell.reuseIdentifier,    bundle: Bundle.main, for: self, at: index) as! PersonCollectionViewCell
            cell.configer(image: callData.image, label: callData.percentage, name: callData.name, age: callData.age,pos: callData.pos)
            
            return cell
        } else {
             let cell2 = collectionContext!.dequeueReusableCell(withNibName: TitleCell.reuseIdentifier, bundle: Bundle.main, for: self, at: index) as! TitleCell
                       cell2.configure(with: model.title)
            return cell2
        }
    }

    override func didSelectItem(at index: Int) {
       
    }

    override func didUpdate(to object: Any) {
        model = object as? itemModelList
    }
}
