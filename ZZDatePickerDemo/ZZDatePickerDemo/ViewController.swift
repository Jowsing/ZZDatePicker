//
//  ViewController.swift
//  ZZDatePickerDemo
//
//  Created by 周鑫 on 2018/8/15.
//  Copyright © 2018年 Jowthing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var mode = ZZDatePicker.ZZDatePickerMode.default

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Date
        let btn = UIButton(frame: CGRect(x: 30, y: 100, width: view.bounds.size.width-60, height: 50))
        btn.setTitle("请选择日期", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.red
        view.addSubview(btn)
        
        btn.addTarget(self, action: #selector(ViewController.selectDate(_:)), for: .touchDown)
    }
    
    @objc func selectDate(_ btn:UIButton) {
        ZZDatePicker.show(self, mode: mode) { [weak self] (date) in
            self?.mode.date = date
            let fmt = DateFormatter()
            fmt.dateFormat = "yyyy-MM-dd"
            btn.setTitle(fmt.string(from: date), for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

