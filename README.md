# ZZDatePicker


## About
This project is maintained by Jowthing, Inc.<br>
A date picker of Swift.<br>

## Try this UI control in action

Screencast from our Demo

<img src="https://github.com/Jowthing/ZZDatePicker/blob/master/gifs/screen0.gif" width="40%"/>

## Requirements

- iOS 8.0+
- Xcode 9

## Installation

Just add the ZZDatePicker folder to your project.

or use [CocoaPods](https://cocoapods.org) with Podfile:
``` ruby
pod 'ZZDatePicker'
```


## Usage

``` Swift
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
```





