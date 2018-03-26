//
//  ViewController.swift
//  Card Date App
//
//  Created by Christoph on 3/23/18.
//  Copyright © 2018 Christoph. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let didTapDone = #selector(ViewController.didTapDone)
    static let didTapTextField = #selector(ViewController.didTapTextField)
    static let didTapPickerDone = #selector(ViewController.didTapDoneInPickerView)
}


class ViewController: UIViewController {
    
    var selectedDates: (month: UInt, year: UInt) = (0, 0)
    
    lazy var datePickerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("DONE", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: .didTapPickerDone, for: .touchUpInside)
        
        return button
    }()
    
    lazy var datePicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        return pickerView
    }()
    
    lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "required"
        textField.textAlignment = .center
        textField.isUserInteractionEnabled = true
        textField.delegate = self
        textField.textAlignment = .left
        
        return textField
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "expiry date"
        
        return label
    }()
    
    let doneButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "done", style: .done, target: self, action: .didTapDone)
        
        return barButtonItem
    }()
    
    var bottomAnchor: NSLayoutConstraint?
    
    var dateComponents: (months: [String], years: [String]) {
        get {
            var monthStrings = Month.getAllMonths().map { String($0) }
            var yearStrings = Date.getYears().map { String($0) }
            monthStrings.insert("", at: 0)
            yearStrings.insert("", at: 0)
            
            return (monthStrings, yearStrings)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Card Date"
        view.backgroundColor = .white
        renderViews()
    }
    
    func animateDatePickerView(constraintConstant: CGFloat, completion: (() -> ())?) {
        UIView.animate(withDuration: 0.75, delay: 0, options: .curveLinear, animations: {
            self.bottomAnchor?.isActive = false
            self.bottomAnchor = self.datePickerContainer.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: constraintConstant)
            self.bottomAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }, completion: { (Bool) in
            if let unwrappedCompletion = completion {
                unwrappedCompletion()
            }
        })
    }
    
    private func renderViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "done", style: .done, target: self, action: .didTapDone)
        
        datePickerContainer.addSubview(datePicker)
        datePickerContainer.addSubview(doneButton)
        
        view.addSubview(dateTextField)
        view.addSubview(detailLabel)
        view.addSubview(datePickerContainer)
        
        dateTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        dateTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dateTextField.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        detailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailLabel.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 0).isActive = true
        detailLabel.widthAnchor.constraint(equalTo: dateTextField.widthAnchor).isActive = true
        detailLabel.heightAnchor.constraint(equalTo: dateTextField.heightAnchor).isActive = true
        
        bottomAnchor = datePickerContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 1000)
        bottomAnchor?.isActive = true
        datePickerContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        datePickerContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        datePickerContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        
        dateTextField.addGestureRecognizer(UIGestureRecognizer(target: self, action: .didTapTextField))
        
        
        datePicker.centerXAnchor.constraint(equalTo: datePickerContainer.centerXAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: datePickerContainer.centerYAnchor).isActive = true
        datePicker.widthAnchor.constraint(equalTo: datePickerContainer.widthAnchor, multiplier: 0.6).isActive = true
        datePicker.heightAnchor.constraint(equalTo: datePickerContainer.heightAnchor, multiplier: 0.6).isActive = true
        
        doneButton.topAnchor.constraint(equalTo: datePickerContainer.topAnchor, constant: 10).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: datePickerContainer.trailingAnchor, constant: 10).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    let alertTitles = (fail: "Validation Error", success: "Success!")
    let alertDescriptions = (pastDate: "The selected date cannot be in the past", invalid: "The specified date is not valid", success: "Thank you, the selected date has been saved")
    
    func validateSelection(onComplete: () -> ()) {
        do {
            try Date.isCurrentDateBefore(selectedDates: selectedDates)
            onComplete()
//            animateDatePickerView(constraintConstant: 1000, completion: {
//                self.dateTextField.text = "\(self.selectedDates.month)/\(self.selectedDates.year)"
//            })
        }
            
        catch DateError.dateInPast {
            UIAlertController.showSimpleAlert(self, withTitle: alertTitles.fail, andDescription: alertDescriptions.pastDate)
        }
            
        catch DateError.invalidDate {
            UIAlertController.showSimpleAlert(self, withTitle: alertTitles.fail, andDescription: alertDescriptions.invalid)
        }
            
        catch { return }

    }
    
    @objc func didTapDone() {
        validateSelection {
            UIAlertController.showSimpleAlert(self, withTitle: alertTitles.success, andDescription: alertDescriptions.success)
        }

    }
    
    @objc func didTapDoneInPickerView() {
        validateSelection {
            animateDatePickerView(constraintConstant: 1000, completion: {
                self.dateTextField.text = "\(self.selectedDates.month)/\(self.selectedDates.year)"
            })
        }
    }
}





