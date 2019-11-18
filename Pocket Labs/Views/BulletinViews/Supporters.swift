//
//  Supporters.swift
//  Finderr
//
//  Created by Ferdinand Lösch on 09/03/2019.
//  Copyright © 2019 Ferdinand Lösch. All rights reserved.
//

import Foundation

import BLTNBoard
import Haptica
import MJPEGStreamLib
import UICircularProgressRing
class TextFieldBulletinPage: FeedbackPageBLTNItem {
    @objc public var textField: UITextField!

    @objc public var textInputHandler: ((BLTNActionItem, String?) -> Void)?

    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        textField = interfaceBuilder.makeTextField(placeholder: "Enter your text here!", returnKey: .done, delegate: self)
        return [textField]
    }

    override func tearDown() {
        super.tearDown()
        textField?.delegate = nil
    }

    override func actionButtonTapped(sender: UIButton) {
        textField.resignFirstResponder()
        super.actionButtonTapped(sender: sender)
    }
}

class VideoBulletinPage: FeedbackPageBLTNItem {
    @objc public var Video: UIImageView!

    @objc public var VideoHandler: ((BLTNActionItem, String?) -> Void)?

    override func makeViewsUnderDescription(with _: BLTNInterfaceBuilder) -> [UIView]? {
        return [Video]
    }

    override func tearDown() {
        super.tearDown()
    }
}

class StatisticsBulletinPage: FeedbackPageBLTNItem {
    @objc public var statisview: StatisticView!

    override func makeViewsUnderDescription(with _: BLTNInterfaceBuilder) -> [UIView]? {
        return [statisview]
    }

    override func tearDown() {
        super.tearDown()
    }
}

// MARK: - UITextFieldDelegate

extension TextFieldBulletinPage: UITextFieldDelegate {
    @objc open func isInputValid(text: String?) -> Bool {
        if text == nil || text!.isEmpty {
            return false
        }

        return true
    }

    func textFieldShouldEndEditing(_: UITextField) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if isInputValid(text: textField.text) {
            textInputHandler?(self, textField.text)
        } else {
            descriptionLabel!.textColor = .red
            descriptionLabel!.text = "You must enter some text to continue."
            textField.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        }
    }
}

import Haptica
class FeedbackPageBLTNItem: BLTNPageItem {
    override func actionButtonTapped(sender: UIButton) {
        // Play an haptic feedback
        Haptic.impact(.light).generate()

        // Call super

        super.actionButtonTapped(sender: sender)
    }

    override func alternativeButtonTapped(sender: UIButton) {
        // Play an haptic feedback
        Haptic.impact(.light).generate()
        super.alternativeButtonTapped(sender: sender)
    }
}
