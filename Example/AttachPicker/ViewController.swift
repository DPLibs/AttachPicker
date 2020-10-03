//
//  ViewController.swift
//  AttachPicker
//
//  Created by Dmitriy Polyakov on 10/03/2020.
//  Copyright (c) 2020 Dmitriy Polyakov. All rights reserved.
//

import UIKit
import AttachPicker

class ViewController: UIViewController {
    
    @IBOutlet private weak var defaultSingleSelectionBt: UIButton!
    @IBOutlet private weak var photoLibraryBt: UIButton!
    @IBOutlet private weak var cameraBt: UIButton!
    @IBOutlet private weak var documentsMultipleSelectionBt: UIButton!
    
    private var attachPicker = AttachPicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        [self.defaultSingleSelectionBt, self.photoLibraryBt, self.cameraBt, self.documentsMultipleSelectionBt].forEach({
            $0?.addTarget(self, action: #selector(self.tapBt(_:)), for: .touchUpInside)
        })
        
        self.attachPicker.viewController = self
        self.attachPicker.didSelect = { [weak self] attach in
            guard let self = self else { return }
            let alert = UIAlertController()
            alert.addAction(UIAlertAction(title: attach.first?.fileName, style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc
    private func tapBt(_ btn: UIButton) {
        switch btn {
        case self.defaultSingleSelectionBt:
            self.attachPicker.present(.defaultSingleSelection)
        case self.photoLibraryBt:
            self.attachPicker.present(.photoLibrary)
        case self.cameraBt:
            self.attachPicker.present(.camera)
        case self.documentsMultipleSelectionBt:
            self.attachPicker.present(.documentsMultipleSelection)
        default:
            break
        }
    }

}

