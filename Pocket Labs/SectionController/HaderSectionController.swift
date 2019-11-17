//
//  ListSectionController.swift
//  Pocket Labs
//
//  Created by Ferdinand Lösch on 16/11/2019.
//  Copyright © 2019 Ferdinand Lösch. All rights reserved.
//

import IGListKit
import Reusable
import SceneKit
import UIKit

class HaderSectionController: ListSectionController {
    var model: HaderModel!

    override init() {
        super.init()
        inset = UIEdgeInsets(top: 30, left: 24, bottom: 15, right: 24)
        minimumLineSpacing = 22
        minimumInteritemSpacing = 22
    }
}

extension HaderSectionController: ButtonDelegate {
    func didClick() {
        let vc = viewController?.storyboard?.instantiateViewController(withIdentifier: "Main") as! ViewController
        vc.bulletinManager.showBulletin(above: topMostController())
    }

    func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while topController.presentedViewController != nil {
            topController = topController.presentedViewController!
        }
        return topController
    }
}

extension HaderSectionController {
    override func numberOfItems() -> Int {
        return 2
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let context = collectionContext else { return .zero }
        if index == 0 {
            return CGSize(width: context.containerSize.width - 48, height: 48)
        } else {
            return CGSize(width: context.containerSize.width - 48, height: 100)
        }
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        if index != 0 {
            let cell = collectionContext!.dequeueReusableCell(withNibName: CountCell.reuseIdentifier, bundle: Bundle.main, for: self, at: index) as! CountCell
            cell.configure(copm: model.completed, donn: model.scheduled)

            return cell
        } else {
            let cell2 = collectionContext!.dequeueReusableCell(withNibName: HaderCell.reuseIdentifier, bundle: Bundle.main, for: self, at: index) as! HaderCell
            cell2.delegate = self
            return cell2
        }
    }

    override func didSelectItem(at _: Int) {}

    override func didUpdate(to object: Any) {
        model = object as? HaderModel
    }
}
