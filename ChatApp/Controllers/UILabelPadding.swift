//
//  UILabelPadding.swift
//  ChatApp
//
//  Created by Barış Can Akkaya on 20.10.2021.
//
import UIKit

class UILabelPadding: UILabel {

    let padding = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }



}
