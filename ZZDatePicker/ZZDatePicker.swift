//
//  ZZDatePicker.swift
//  Intelligence
//
//  Created by 周鑫 on 2018/8/14.
//  Copyright © 2018年 ls. All rights reserved.
//

import UIKit
import Foundation

public extension ZZDatePicker {
    
    enum Mode : Int {

        case time = 0

        case date = 1

        case dateAndTime = 2

        case countDownTimer = 3
        
        case monthAndYear = 4
        
        func mode_UIDatePicker() -> UIDatePicker.Mode {
            return UIDatePicker.Mode(rawValue: rawValue) ?? .date
        }
    }
}

public class ZZDatePicker {
    
    // MARK: - Properties (public)
    
    public var mode: Mode = .date
    
    public var locale: Locale?
    
    public var currentDate = Date()
    
    public var maximumDate: Date?
    
    public var minimumDate: Date?
    
    public var pickerHeight: CGFloat = 345.0
    
    public var lineColor: UIColor = Colors.lineColor
    
    public var toolBarTintColor: UIColor = Colors.toolBarTintColor
    
    public var dimissBackgroundColor: UIColor = Colors.dimissBackgroundColor
    
    public var pickerBackgroundColor: UIColor = Colors.pickerBackgroundColor
    
    
    // MARK: - Properties (internal)
    
    internal let pickHandler: PickHandler?
    
    
    // MARK: - Life Cycles
    
    public init(pickHandler: PickHandler?) {
        self.pickHandler = pickHandler
    }
    
    public func pickerViewController() -> UIViewController {
        return ZZDatePickerController(picker: self)
    }
}

public extension ZZDatePicker {
    
    func show(in viewController: UIViewController) {
        viewController.definesPresentationContext = true
        viewController.present(pickerViewController(), animated: false, completion: nil)
    }
}

public extension ZZDatePicker {
    
    typealias PickHandler = (Date) -> Void
    
    struct Colors {
        static var lineColor: UIColor { return UIColor.gray }
        static var toolBarTintColor: UIColor { return UIColor(white: 0.92, alpha: 1) }
        static var dimissBackgroundColor: UIColor { return UIColor(white: 0, alpha: 0.3) }
        static var pickerBackgroundColor: UIColor { return UIColor(red: 214.0 / 255.0, green: 216.0 / 255.0, blue: 221.0 / 255.0, alpha: 1.0) }
    }
}
