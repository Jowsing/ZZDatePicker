//
//  ZZDatePicker.swift
//  Intelligence
//
//  Created by 周鑫 on 2018/8/14.
//  Copyright © 2018年 ls. All rights reserved.
//

import UIKit

class ZZDatePicker: UIViewController {
    
    struct ZZDatePickerMode {
        var date:Date = Date()
        var maximumDate:Date?
        var minimumDate:Date?
        var backgroundColor:UIColor?
        var datePickerMode:UIDatePickerMode = .date
        
        static var `default`:ZZDatePickerMode { get { return ZZDatePickerMode(date: Date(),
                                                                       maximumDate: Date(),
                                                                       minimumDate: nil,
                                                                       backgroundColor: UIColor.white,
                                                                       datePickerMode: .date) } }
    }
    
    // MARK: - Public Properties
    
    
    
    // MARK: - Private Properties
    
    private var date:Date!
    private var mode:ZZDatePickerMode!
    
    private var pickDone:((Date)->Void)?
    
    // MARK: - Lazy Properties
    
    private lazy var box:UIView = { return UIView() }()
    
    
    // MARK: - Setup UI
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        show_animate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Self
        
        
        // Box
        self.box.frame = CGRect(x: 0, y: view.bounds.size.height, width: view.bounds.size.width, height: 260)
        view.addSubview(self.box)
        
        // Topline
        let line = UIView.init(frame: CGRect(x: 0, y: 0, width: box.bounds.size.width, height: 1/UIScreen.main.scale))
        line.backgroundColor = UIColor.black
        box.addSubview(line)
        
        // ToolBar
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: line.frame.maxY, width: box.bounds.size.width, height: 40))
        toolBar.barStyle = .default
        toolBar.items = [
            UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(ZZDatePicker.clickcancel)),
            UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(ZZDatePicker.clickdone))
        ]
        box.addSubview(toolBar)
        
        // Picker
        let datePicker = UIDatePicker.init()
        datePicker.frame = CGRect(x: 0, y: toolBar.frame.maxY, width: box.bounds.size.width, height: box.bounds.size.height-toolBar.bounds.size.height)
        datePicker.date = date
        datePicker.maximumDate = mode.maximumDate
        datePicker.minimumDate = mode.minimumDate
        datePicker.backgroundColor = mode.backgroundColor
        datePicker.datePickerMode = mode.datePickerMode
        box.addSubview(datePicker)
        datePicker.addTarget(self, action: #selector(ZZDatePicker.dateChanged(_:)), for: .valueChanged)
        
    }
    
    // MARK: - Methods
    
    public class func show(_ inViewController:UIViewController, mode:ZZDatePickerMode = .default, pickDone:@escaping (Date)->Void) {
        let vc = ZZDatePicker()
        vc.pickDone = pickDone
        vc.mode = mode
        vc.date = mode.date
        vc.view.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        vc.modalPresentationStyle = .overCurrentContext
        inViewController.definesPresentationContext = true
        inViewController.present(vc, animated: false, completion: nil)
    }
    
    private func show_animate() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.2, options: .curveLinear, animations: {
            self.box.frame.origin.y = self.view.bounds.size.height - self.box.bounds.size.height
        }) { (_) in
            
        }
    }
    
    private func dissmiss() {
        UIView.animate(withDuration: 0.25, animations: {
            self.box.frame.origin.y = self.view.bounds.size.height
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dissmiss()
    }
    
    @objc
    func dateChanged(_ picker:UIDatePicker) {
        self.date = picker.date
    }
    
    @objc
    func clickcancel() {
        dissmiss()
    }
    
    @objc
    func clickdone() {
        self.pickDone?(date)
        dissmiss()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
