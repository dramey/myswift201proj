//
//  TodoListDetailViewController.swift
//  TodoList
//
//  Created by Deb Ramey on 10/24/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//

import UIKit

class TodoListDetailViewController: UIViewController {
    @IBOutlet weak var todoListTitleField: UITextField!
    @IBOutlet weak var todoListTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var selectedDate: UILabel!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var completionSwitch: UISwitch!
    @IBOutlet weak var shouldRemindSwitch: UISwitch!
    
    var gestureRecognizer: UITapGestureRecognizer!
    var todoList = TodoList()
    // var todoList: TodoList? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        todoListTitleField.text = todoList.title
        todoListTextView.text = todoList.text
        selectedDate.text = todoList.dueDate
        completionSwitch.isOn = todoList.completion
        categoryPicker.selectRow(todoList.category, inComponent: 0, animated: true)  //get picker info
        //if already has image we want to show it--if not we want to hide it
        if let image = todoList.image{
            imageView.image = image
            addGestureRecognizer()
            
        }else {
            imageView.isHidden = true
        }
        
    }
    
    func addGestureRecognizer(){
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    func viewImage(){
        if let image = imageView.image{
            TodoListStore.shared.selectedImage = image
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageNavController")
            present(viewController, animated: true, completion: nil)
        }
    }
    
    fileprivate func showPicker(_ type: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = type
        present(imagePicker, animated: true, completion: nil)
        
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        todoList.title = todoListTitleField.text!
        todoList.text = todoListTextView.text
        todoList.date = Date()
        todoList.image = imageView.image
        todoList.dueDate = selectedDate.text!
        todoList.completion = completionSwitch.isOn
        //Grabs picker detail
        todoList.category = categoryPicker.selectedRow(inComponent: 0)
    
    }
    
    
    //MARK: - IBACtions
    @IBAction func choosePhoto(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Picture", message: "Choose a Picture type", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action) in self.showPicker(.camera)}))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action) in self.showPicker(.photoLibrary)}))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func dataPickerAction(_ sender: AnyObject) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm a"
        let strDate = dateFormatter.string(from : datePicker.date)
        self.selectedDate.text = strDate
    }
}

extension TodoListDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "Home"
        }else if row == 1 {
            return "Work"
        }
        return "Other"
    }
}

extension TodoListDetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    //implemented for us--no code--just include it--gives us the right to make functions to pull up picture or take camera pic
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            //take original image and scale it down 512 x 512 pixels
            let maxSize: CGFloat = 512
            let scale = maxSize / image.size.width
            let newHeight = image.size.height * scale
            
            UIGraphicsBeginImageContext(CGSize(width: maxSize, height:newHeight))
            image.draw(in: CGRect(x: 0, y: 0, width:maxSize, height:newHeight))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            imageView.image = resizedImage
            
            imageView.isHidden = false
            if gestureRecognizer != nil {
                imageView.removeGestureRecognizer(gestureRecognizer)
            }
            addGestureRecognizer()
        }
    }
}

