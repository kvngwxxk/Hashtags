//
//  HashtagConfiguration.swift
//  Hashtags
//
//  Created by Oscar Götting on 6/10/18.
//
import Foundation

open class HashtagConfiguration {
    var paddingLeft: CGFloat = 0.0
    var paddingTop: CGFloat = 0.0
    var paddingRight: CGFloat = 0.0
    var paddingBottom: CGFloat = 0.0
    var removeButtonSize: CGFloat = 0.0
    var removeButtonSpacing: CGFloat = 0.0
    var cornerRadius: CGFloat = 0.0
    var textSize: CGFloat = 0.0
    var textColor = UIColor()
    var backgroundColor = UIColor()
    var deSelectedTextFont = UIFont.init(name: "NotoSansCJKkr-Regular", size: 14.0)
    var selectedTextFont = UIFont.init(name: "NotoSansCJKkr-Medium", size: 14.0)
    var maxLine = 0
    var removeImage : UIImage?
    var isSelectable = true;
    var borderColor = UIColor()
    var borderWidth: CGFloat = 0.0
}
