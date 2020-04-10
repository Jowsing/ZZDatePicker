//
//  ViewController.swift
//  ZZDatePickerDemo
//
//  Created by 周鑫 on 2018/8/15.
//  Copyright © 2018年 Jowthing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var btn = { UIButton() }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Date
        btn.frame = CGRect(x: 30, y: 100, width: view.bounds.size.width-60, height: 50)
        btn.setTitle("请选择日期", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.red
        view.addSubview(btn)
        
        btn.addTarget(self, action: #selector(ViewController.selectDate(_:)), for: .touchDown)
    }
    
    @objc func selectDate(_ btn:UIButton) {
        let picker = ZZDatePicker { [unowned self] (date) in
            let fmt = DateFormatter()
            fmt.dateFormat = "yyyy-MM-dd"
            self.btn.setTitle(fmt.string(from: date), for: .normal)
        }
        present(picker.pickerViewController(), animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

