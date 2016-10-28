//
//  ImageViewController.swift
//  todoList
//
//  Created by Deb Ramey on 10/24/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let image = TodoListStore.shared.selectedImage{
            imageView.image = image
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func close(_ sender: AnyObject) {
        TodoListStore.shared.selectedImage = nil
        dismiss(animated: true, completion: nil)
    }
    
}
