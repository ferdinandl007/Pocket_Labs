//
//  VC1.swift
//  Finderr
//
//  Created by Ferdinand Lösch on 17/03/2019.
//  Copyright © 2019 Ferdinand Lösch. All rights reserved.
//

import Alamofire
import BLTNBoard
import Foundation
import IGListKit
import MJPEGStreamLib
import UIKit
extension ViewController {
    func getNname() -> TextFieldBulletinPage {
        let page = TextFieldBulletinPage(title: "Enter Your Name")
        page.isDismissable = false
        page.descriptionText = "this name will be used to identify you later on"
        page.actionButtonTitle = "Next"

        page.textInputHandler = { item, text in
            self.name = text ?? ""
            item.manager?.displayNextItem()
        }
        page.isDismissable = true
        page.next = getAge()
        return page
    }

    func getAge() -> TextFieldBulletinPage {
        let page = TextFieldBulletinPage(title: "Enter Your Age")
        page.isDismissable = false
        page.descriptionText = "The edges used to identify you better"
        page.actionButtonTitle = "Next"

        page.textInputHandler = { item, text in
            self.age = text ?? ""
            item.manager?.displayNextItem()
        }
        page.next = getImage()
        return page
    }

    func getImage() -> BLTNPageItem {
        let page = BLTNPageItem(title: "Identification Image")

        page.appearance.actionButtonTitleColor = .white
        page.descriptionText = "This image is used to identify you automatically next time you get tested"
        page.actionButtonTitle = "Take A Photo"
        page.alternativeButtonTitle = "No Thanks!"

        page.isDismissable = false

        page.alternativeHandler = { item in
            item.manager?.displayNextItem()
        }
        page.actionHandler = { item in
            item.manager?.displayNextItem()
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.allowsEditing = true
            vc.delegate = self
            self.topMostController().present(vc, animated: true)

            item.manager?.displayNextItem()
        }

        page.next = getBloodSample()
        return page
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
                    switch status {
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
                    let modell = PatientModel(name: self.name, age: self.age, pos: "\(Bool(JSON["health_level"] as? Float ?? 0.0 < 0.1))", image: self.image ?? #imageLiteral(resourceName: "Me"), percentage: "102", p1: JSON["percentage_infected"] as? Int ?? 0, p2: JSON["highest_prob"] as? Int ?? 0, p3: JSON["health_level"] as? Int ?? 0)
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

    func ShowStatistics() -> StatisticsBulletinPage {
        let page = StatisticsBulletinPage(title: "Statistics")

        page.appearance.actionButtonColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        page.appearance.actionButtonTitleColor = .white

        page.descriptionText = "The analysis is complete"
        page.actionButtonTitle = "Next!"

        page.statisview = StatisticView.loadFromNib()
        page.statisview.sizeToFit()
        // page.statisview.configer(model: (model[1] as! itemModelList).arry.first!)

        page.isDismissable = true

        page.dismissalHandler = { item in
            item.manager?.dismissBulletin(animated: true)
            self.dismiss(animated: true, completion: nil)
        }

        page.actionHandler = { item in
            item.manager?.displayNextItem()
        }

        page.next = makeCompletionPage()

        return page
    }

    func makeCompletionPage() -> BLTNPageItem {
        let page = BLTNPageItem(title: "Check completed")
        page.image = #imageLiteral(resourceName: "IntroCompletion")
        page.imageAccessibilityLabel = "All complete"
        page.appearance.actionButtonColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        page.appearance.imageViewTintColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        page.appearance.actionButtonTitleColor = .white

        page.descriptionText = "Your blood was analysed successfully and is now available in the analyse agent table"
        page.actionButtonTitle = "let's Go!"
        page.alternativeButtonTitle = "Replay"

        page.isDismissable = true

        page.dismissalHandler = { item in
            item.manager?.dismissBulletin(animated: true)
            self.dismiss(animated: true, completion: nil)
        }

        page.actionHandler = { item in
            item.manager?.dismissBulletin(animated: true)
            self.dismiss(animated: true, completion: nil)
        }

        page.alternativeHandler = { item in
            item.manager?.popToRootItem()
        }

        return page
    }

    func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while topController.presentedViewController != nil {
            topController = topController.presentedViewController!
        }
        return topController
    }
}

extension UIImage {
    func scaleImage(toSize newSize: CGSize) -> UIImage? {
        var newImage: UIImage?
        let newRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        if let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage {
            context.interpolationQuality = .high
            let flipVertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: newSize.height)
            context.concatenate(flipVertical)
            context.draw(cgImage, in: newRect)
            if let img = context.makeImage() {
                newImage = UIImage(cgImage: img)
            }
            UIGraphicsEndImageContext()
        }
        return newImage
    }
}
