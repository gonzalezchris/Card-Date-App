//
//  ViewControllerExtensions.swift
//  Card Date App
//
//  Created by Christoph on 3/25/18.
//  Copyright © 2018 Christoph. All rights reserved.
//

import UIKit

extension ViewController: UITextFieldDelegate {
    @objc func didTapTextField() {
        animateDatePickerView(constraintConstant: 0.0, completion: nil)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        didTapTextField()
        return false
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return dateComponents.months.count
        case 1: return dateComponents.years.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return "\(row != 0 ? "\(String(row)) - ": "") \(dateComponents.months[row])"
        }
            
        else if component == 1 {
            return dateComponents.years[row]
        }
        
        return "no-op"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            selectedDates.month = Month(rawValue: UInt(row))?.rawValue ?? 0
            
        }
            
        else if (component == 1) {
            selectedDates.year = UInt(dateComponents.years[row]) ?? 0
        }
    }
}

extension ViewController {
    
}


