//
//  ZZDatePickerController.swift
//  ZZDatePickerDemo
//
//  Created by jowsing on 2020/4/9.
//  Copyright © 2020 Jowthing. All rights reserved.
//

import UIKit

internal class ZZDatePickerController: UIViewController {

    // MARK: - Properties (private)
       
    private var picker: ZZDatePicker
    

    // MARK: - Properties (private lazy)

    private lazy var containerView = { UIView() }()
    private lazy var toolBar = { UIToolbar() }()
    private lazy var datePicker: UIView = {
        switch picker.mode {
        case .monthAndYear:
            let pickerView = ZZDatePickerView()
            pickerView.date = picker.currentDate
            pickerView.maximumDate = picker.maximumDate
            pickerView.minimumDate = picker.minimumDate
            pickerView.locale = picker.locale
            return pickerView
        default:
            let pickerView = UIDatePicker()
            pickerView.date = picker.currentDate
            pickerView.maximumDate = picker.maximumDate
            pickerView.minimumDate = picker.minimumDate
            pickerView.datePickerMode = picker.mode.mode_UIDatePicker()
            pickerView.locale = picker.locale
            return pickerView
        }
    }()


    // MARK: - Life Cycles

    init(picker: ZZDatePicker) {
        self.picker = picker
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.configureBind()
    }
    
    public func configureUI() {
        
        view.backgroundColor = picker.dimissBackgroundColor
        let viewSize = view.bounds.size
        
        /// Container
        containerView.frame = CGRect(x: 0, y: viewSize.height, width: viewSize.width, height: picker.pickerHeight)
        containerView.backgroundColor = .clear
        view.addSubview(containerView)
        
        /// Picker
        do {
            /// Top Line
            let topLine = UIView(frame: CGRect(x: 0, y: 0, width: containerView.bounds.size.width, height: 1 / UIScreen.main.scale))
            topLine.backgroundColor = picker.lineColor
            containerView.addSubview(topLine)
            
            /// Tool Bar
            toolBar.frame = CGRect(x: 0, y: topLine.frame.maxY, width: containerView.bounds.size.width, height: 44)
            toolBar.barStyle = .default
            toolBar.barTintColor = picker.toolBarTintColor
            toolBar.isTranslucent = true
            containerView.addSubview(toolBar)
            
            /// Date Picker
            datePicker.frame = CGRect(x: 0, y: toolBar.frame.maxY, width: containerView.bounds.size.width, height: containerView.bounds.size.height - toolBar.frame.maxY)
            datePicker.backgroundColor = picker.pickerBackgroundColor
            containerView.addSubview(datePicker)
        }
        
    }
    
    public func configureBind() {
        let cancelItem = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        let doneItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        toolBar.items = [
            cancelItem,
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            doneItem,
        ]
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapViewAction))
        view.addGestureRecognizer(tapGesture)
    }
    
    override open func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
        self.showAnimated()
    }
    
    
    // MARK: - Methods (private)

    private func showAnimated() {
       UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .curveLinear, animations: {
           self.containerView.frame.origin.y = self.view.bounds.size.height - self.containerView.bounds.size.height
       }) { (_) in
           
       }
    }

    private func dissmiss() {
       UIView.animate(withDuration: 0.25, animations: {
           self.containerView.frame.origin.y = self.view.bounds.size.height
       }) { (_) in
           self.dismiss(animated: false, completion: nil)
       }
    }
    
    
    // MARK: - Methods (action)
    
    @objc private func tapViewAction() {
        self.dissmiss()
    }

    @objc private func cancelAction() {
        self.dissmiss()
    }

    @objc private func doneAction() {
        let date: Date
        switch picker.mode {
        case .monthAndYear:
            date = (datePicker as! ZZDatePickerView).date
        default:
            date = (datePicker as! UIDatePicker).date
        }
        self.picker.pickHandler?(date)
        self.dissmiss()
    }

}
