//
//  ZZDatePickerView.swift
//  ZZDatePickerDemo
//
//  Created by jowsing on 2020/7/31.
//  Copyright © 2020 Jowthing. All rights reserved.
//

import UIKit

public class ZZDatePickerView: UIPickerView {

    // MARK: - Properties (public)
    
    public var date: Date = .init()
    public var maximumDate: Date?
    public var minimumDate: Date?
    public var locale: Locale?
    
    // MARK: - Properties (private)
    
    private var isChinese = false
    private var years = 1000000
    private var minYear = 1970
    private var maxYear: Int?
    private var maxMonth: Int?
    
    private var calender: Calendar { Calendar.current }
    private var yearComponent: Int { isChinese ? 0 : 1 }
    private var monthComponent: Int { isChinese ? 1 : 0 }
    
    private var isDisplayedOnScreen = false
    
    private var selectYear = 0
    private var selectMonth = 0
    
    
    
    // MARK: - Life Cycles
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        reloadData()
    }
    
    func reloadData() {
        self.isChinese = (locale ?? Locale.current).identifier.hasPrefix("zh")
        let (currentYear, currentMon) = compoents(from: date)
        if let minDate = minimumDate {
            if isEqualOrGreaterThan(minDate, where: date)  {
                self.minYear = calender.component(.year, from: minDate)
            }
        }
        if let maxDate = maximumDate {
            let maxYear = calender.component(.year, from: maxDate)
            if maxYear >= minYear, isEqualOrGreaterThan(date, where: maxDate) {
                self.years = maxYear - minYear + 1
                self.maxYear = maxYear
                self.maxMonth = calender.component(.month, from: maxDate)
            }
        }
        
        self.selectYear = currentYear
        self.selectMonth = currentMon
        self.date = getSelectionDate()
        self.selectRow(currentYear - minYear, inComponent: yearComponent, animated: false)
        self.selectRow(currentMon - 1, inComponent: monthComponent, animated: false)
    }
    
    
    // MARK: - Methods (private)
    
    private func localizedStringForYear(_ year: Int) -> String {
        let yearStr = String(year)
        return isChinese ? (yearStr + "年") : yearStr
    }
    
    private func localizedStringForMonth(_ month: Int) -> String {
        if isChinese {
            return String(month) + "月"
        } else {
            let monIndex = min(11, month - 1)
            return [
                "January",
                "February",
                "March",
                "April",
                "May",
                "June",
                "July",
                "August",
                "September",
                "October",
                "November",
                "December",
            ][monIndex]
        }
    }
    
    private func getSelectionDate() -> Date {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyyMM"
        let dateStr = String(selectYear) + String(format: "%02d", selectMonth)
        return fmt.date(from: dateStr) ?? date
    }
    
    private func isEqualOrGreaterThan(_ date0: Date, where date1: Date) -> Bool {
        let year0 = calender.component(.year, from: date0)
        let year1 = calender.component(.year, from: date1)
        guard year0 == year1 else {
            return year1 > year0
        }
        let month0 = calender.component(.month, from: date0)
        let month1 = calender.component(.month, from: date1)
        return month1 >= month0
    }
    
    private func compoents(from date: Date) -> (year: Int, month: Int) {
        let year = calender.component(.year, from: date)
        let month = calender.component(.month, from: date)
        return (year, month)
    }
    
}

extension ZZDatePickerView: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case yearComponent:
            return years
        default:
            return 12
        }
    }
}

extension ZZDatePickerView: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.bounds.size.width * 0.5
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case yearComponent:
            return localizedStringForYear(minYear + row)
        default:
            return localizedStringForMonth(row + 1)
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case yearComponent:
            self.selectYear = row + minYear
            if maxYear == selectYear, let maxMonth = self.maxMonth, selectMonth > maxMonth {
                self.selectMonth = maxMonth
                selectRow(maxMonth - 1, inComponent: monthComponent, animated: true)
            }
        default:
            let month = row + 1
            if maxYear == selectYear, let maxMonth = self.maxMonth, month > maxMonth {
                self.selectMonth = maxMonth
                selectRow(maxMonth - 1, inComponent: component, animated: true)
            } else {
                self.selectMonth = month
            }
        }
        self.date = getSelectionDate()
    }
}
