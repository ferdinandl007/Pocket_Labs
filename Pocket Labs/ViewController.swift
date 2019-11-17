//
//  ViewController.swift
//  Pocket Labs
//
//  Created by Ferdinand Lösch on 16/11/2019.
//  Copyright © 2019 Ferdinand Lösch. All rights reserved.
//

import UIKit

import BLTNBoard
import IGListKit
import Reusable
import UIKit
import Alamofire
import MJPEGStreamLib
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

    let defaults = UserDefaults.standard
    lazy var adapter: ListAdapter = {
        ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.collectionView = collectionView
        adapter.dataSource = self
        collectionView.scrollsToTop = true
        let rootItem: BLTNItem = getNname()
        self.bulletinManager = BLTNItemManager(rootItem: rootItem)

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
        return itemModelList(arr: arr, titel: "ON THIS DAY: \(Date().toString(dateFormat: "dd-MMM-yyyy"))")
    }
    
    func getBloodSample() -> VideoBulletinPage {
           let page = VideoBulletinPage(title: "Gets your blood sample")

           page.appearance.actionButtonTitleColor = .white
           page.descriptionText = "identify a spot with visible cells and press continue"
           page.actionButtonTitle = "continue"
           page.Video = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
           page.Video.layer.masksToBounds = false
           page.Video.layer.borderColor = UIColor.white.cgColor
           page.Video.layer.cornerRadius = 10
           page.Video.clipsToBounds = true
       
           let stream = MJPEGStreamLib(imageView: page.Video!)
           // Start Loading Indicator
           // Your stream url should be here !
           let url = URL(string: "http://\(ip_addr):9999/?action=stream")
           stream.contentURL = url
           stream.play()

           
           page.actionHandler = { item in
               item.manager?.displayActivityIndicator()
               
               Alamofire.request("http://\(ip_addr):9998/detect").responseJSON {
                   response in
                       if let status = response.response?.statusCode {
                           switch(status){
                           case 200:
                               print("example success")
                           default:
                               print("error with response status: \(status)")
                               item.manager?.popItem()
                           }
                       }
                   if let result = response.result.value {
                       let JSON = result as! NSDictionary
                       print(JSON)
                       let modell = PatientModel(name: self.name, age: self.age, pos: "\(Bool(JSON["health_level"] as? Float ?? 0.0 < 0.1))", image: self.image ?? #imageLiteral(resourceName: "Me"), percentage: "102", p1: JSON["percentage_infected"]  as? Int ?? 0, p2: JSON["highest_prob"] as? Int ?? 0, p3: JSON["health_level"] as? Int ?? 0)
                    NotificationCenter.default.post(name: .didReceiveData, object: self, userInfo: ["data": modell])
                       
                    let m = itemModelList(arr: [], titel: "cool")
                       m.arry.append(modell)
                       print(self.modelPrenson)
                       self.modelPrenson.append(m)
                       self.adapter.performUpdates(animated: true)
                    item.manager?.displayNextItem()
                       
                   }
               }
               
           }
          

           page.next = makeCompletionPage()
           return page
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
