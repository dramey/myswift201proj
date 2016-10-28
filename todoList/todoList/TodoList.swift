//
//  TodoList.swift
//  todoList
//
//  Created by Deb Ramey on 10/24/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//

import UIKit

class TodoList: NSObject, NSCoding {
    var title = ""
    var text = ""
    var date = Date()
    var image: UIImage?
    var dueDate = ""
    var category = 0
    var priority = 0.0
    var completion = false
    
    
    let titleKey = "title"
    let textKey = "text"
    let dateKey = "date"
    let imageKey = "image"
    let dueDateKey = "dueDate"
    let categoryKey = "category"
    let priorityKey = "priority"
    let completionKey = "completion"
    
    
    var dateString: String{
        let dateFormatter = DateFormatter()
        //MM are for months -- mm would be for minutes
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
    
    override init() {
        super.init()
    }
    
    //creating a custom initializer --convenience initializer
    init(title: String, text: String, dueDate: String, category: Int, priority: Double, completion: Bool){
        self.title = title
        self.text = text
        self.dueDate = dueDate
        self.category = category
        self.priority = priority
        self.completion = completion
        
    }
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: titleKey) as! String
        self.text = aDecoder.decodeObject(forKey: textKey) as! String
        self.date = aDecoder.decodeObject(forKey: dateKey) as! Date
        self.image = aDecoder.decodeObject(forKey: imageKey) as? UIImage
        self.dueDate = aDecoder.decodeObject(forKey: dueDateKey) as! String
        self.category = aDecoder.decodeInteger(forKey: categoryKey)
        self.priority = aDecoder.decodeDouble(forKey: priorityKey)
        self.completion = aDecoder.decodeBool(forKey: completionKey)
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: titleKey)
        aCoder.encode(text, forKey: textKey)
        aCoder.encode(date, forKey: dateKey)
        aCoder.encode(image, forKey: imageKey)
        aCoder.encode(dueDate, forKey: dueDateKey)
        aCoder.encode(category, forKey: categoryKey)
        aCoder.encode(priority, forKey: priorityKey)
        aCoder.encode(completion, forKey: completionKey)
        
    }
    
}
