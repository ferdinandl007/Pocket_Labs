//
//  ViewController.swift
//  Pocket Labs
//
//  Created by Ferdinand Lösch on 16/11/2019.
//  Copyright © 2019 Ferdinand Lösch. All rights reserved.
//

import UIKit

import Alamofire
import BLTNBoard
import IGListKit
import MJPEGStreamLib
import Reusable
import UIKit
class ViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    var image: UIImage?
    var name = ""
    var age = ""
    var modelPrenson = [ListDiffable]()

    lazy var bulletinManager: BLTNItemManager = {
        let rootItem: BLTNItem = getNname()
        return BLTNItemManager(rootItem: rootItem)
    }()

    lazy var adapter: ListAdapter = {
        ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.collectionView = collectionView
        adapter.dataSource = self
        collectionView.scrollsToTop = true
        let rootItem: BLTNItem = getNname()
        bulletinManager = BLTNItemManager(rootItem: rootItem)

        let hader = HaderModel(completed: defaults.integer(forKey: "copm") ?? 0,
                               scheduled: defaults.integer(forKey: "donn") ?? 0)
        modelPrenson.append(hader)

        modelPrenson.append(makeSomeData())

//        defaults.set(modelPrenson, forKey: "model")
        subscribe()
    }

    func subscribe() {
        NotificationCenter.default.addObserver(forName: .didReceiveData, object: nil, queue: .main) { Notification in
            print(self.modelPrenson)
            let model = Notification.userInfo?["data"] as! PatientModel
            let c = self.modelPrenson[1] as! itemModelList
            c.arry.append(model)
            // self.defaults.set(c, forKey: "ferdinand")
            self.modelPrenson[1] = c as ListDiffable
            print(Notification)
            self.adapter.reloadData(completion: nil)
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        adapter.reloadData(completion: nil)
    }

    func makeSomeData() -> ListDiffable {
        var arr = [PatientModel]()
        for _ in 0 ... 1 {
            let cell = PatientModel(name: "Ferdinand", age: "13", pos: "\(Bool.random())", image: #imageLiteral(resourceName: "33616593978_152195db6d_o 3 copy"), percentage: "12%", p1: 12, p2: 55, p3: 88)
            arr.append(cell)
        }
//        let data = self.defaults.array(forKey: "ferdinand") as!itemModelList

        return itemModelList(arr: arr, titel: "ON THIS DAY: \(Date().toString(dateFormat: "dd-MMM-yyyy"))")
    }
}

extension ViewController: ListAdapterDataSource {
    func objects(for _: ListAdapter) -> [ListDiffable] {
        return modelPrenson
    }

    func listAdapter(_: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is itemModelList {
            return ItemController()
        } else if object is HaderModel {
            return HaderSectionController()
        }
        return ItemController()
    }

    func emptyView(for _: ListAdapter) -> UIView? {
        return UIView()
    }
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        self.image = image
        // print out the image size as a test
        print(image.size)
    }
}

extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
    static let didCompleteTask = Notification.Name("didCompleteTask")
    static let completedLengthyDownload = Notification.Name("completedLengthyDownload")
}
