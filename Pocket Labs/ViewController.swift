//
//  ViewController.swift
//  Pocket Labs
//
//  Created by Ferdinand Lösch on 16/11/2019.
//  Copyright © 2019 Ferdinand Lösch. All rights reserved.
//

import UIKit


import IGListKit
import Reusable
import UIKit
class ViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!

    var model = [ListDiffable]()
    let defaults = UserDefaults.standard
    lazy var adapter: ListAdapter = {
        ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.collectionView = collectionView
        adapter.dataSource = self
        collectionView.scrollsToTop = true
        model =  defaults.object(forKey: "model") as? [ListDiffable] ?? [ListDiffable]()
        model.append(makeSomeData())
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        adapter.reloadData(completion: nil)
    }
    
    func makeSomeData() -> ListDiffable {
        
        var arr = [PatientModel]()
        for _ in 0 ... 20 {
            let cell = PatientModel(name: "Ferdinand", age: "13", pos: "\(Bool.random())", image: #imageLiteral(resourceName: "33616593978_152195db6d_o 3 copy") , percentage: "12%")
            arr.append(cell)
        }
        return itemModelList(arr: arr, titel: "On This Day: \(Date().toString(dateFormat: "dd-MMM-yyyy"))")
    }
    
}

extension ViewController: ListAdapterDataSource {
    func objects(for _: ListAdapter) -> [ListDiffable] {
        return model
    }
    
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is itemModelList {
            return ItemController()
        }
        return ItemController()
    }


    func emptyView(for _: ListAdapter) -> UIView? {
       
        return UIView()
    }
}
