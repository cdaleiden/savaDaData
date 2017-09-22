//
//  ViewController.swift
//  savaDaData
//
//  Created by apcs2 on 9/13/17.
//  Copyright © 2017 apcs2. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var textField1 = UITextField()
    let newView = UIView()
    
    var array : [NSManagedObject] = [NSManagedObject(context: ("" as? NSManagedObjectContext)!)]
    var meat: [String] = []
    var grain: [String] = []
    var veggies: [String] = []
    var fruit: [String] = []
    
    @IBOutlet weak var myTableView: UITableView!
    
    var timer = Timer()
    var time : Double = 2
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity")
        do
        {
                array = try fetchFunction(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
        }
        catch
        {
            
        }
        textField1.text = ""
        //view.backgroundColor = UIColor.red
        view.backgroundColor = UIColor(colorLiteralRed: Float(CGFloat(drand48())), green: Float(CGFloat(drand48())), blue: Float(CGFloat(drand48())), alpha: 1)
        
        
        
    }
    func fetchFunction(_ request: NSFetchRequest<NSFetchRequestResult>) throws -> [Any]
    {
        var array2 : [Any]! = []
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        do
        {
            array2 = try managedContext?.fetch(request)
        }
        catch
        {
            
        }
        return array2
        
    }
    func timerResults()
    {
        if time == 2.0
        {
            time -= 1.0
            timer.invalidate()
            view.backgroundColor = UIColor(colorLiteralRed: Float(CGFloat(drand48())), green: Float(CGFloat(drand48())), blue: Float(CGFloat(drand48())), alpha: 1)
            timer = Timer.scheduledTimer(timeInterval: 0.5 , target: self, selector: Selector("timerResult"), userInfo: nil, repeats: true)
            
        }
        time = 2.0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return array.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOne", for: indexPath)
        cell.textLabel?.text = array[indexPath.row].value(forKeyPath: "text") as? String
        return cell
    }

    func save(text: String, runningTimes: Float, type: String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else
        {
                return
        }
        let manageContext = appDelegate.persistentContainer.viewContext
        
        var entity = NSEntityDescription()
        if type == "Meat"
        {
            entity = NSEntityDescription.entity(forEntityName: "meat", in: manageContext)!
        }
        else if type == "Grain"
        {
            entity = NSEntityDescription.entity(forEntityName: "grain", in: manageContext)!
        }
        else if type == "Fruit"
        {
            entity = NSEntityDescription.entity(forEntityName: "fruit", in: manageContext)!
        }
        else if type == "Vegetable"
        {
            entity = NSEntityDescription.entity(forEntityName: "vegetable", in: manageContext)!
        }
        else if type == "All"
        {
            entity = NSEntityDescription.entity(forEntityName: "all", in: manageContext)!
        }
        let newObject = NSManagedObject(entity: entity, insertInto: manageContext)
        newObject.setValue(text, forKey: "text")
        newObject.setValue(runningTimes, forKey: "runningTimes")
        do
        {
            try manageContext.save()
        }
        catch
        {
            print("String")
        }
    }
    func changeValues(type: String)
    {
        if type == "Meat"
        {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Meat")
            do
            {
                array = try fetchFunction(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
            }
            catch
            {
                
            }
            
        }
        else if type == "Fruit"
        {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Meat")
            do
            {
                array = try fetchFunction(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
            }
            catch
            {
                
            }
        }
        else if type == "Vegetable"
        {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Meat")
            do
            {
                array = try fetchFunction(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
            }
            catch
            {
                
            }
        }
        else if type == "Grains"
        {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Meat")
            do
            {
                array = try fetchFunction(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
            }
            catch
            {
                
            }
        }
        else if type == "All"
        {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "All")
            do
            {
                array = try fetchFunction(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
            }
            catch
            {
                
            }
        }
    }
    func addNew()
    {
        textField1.text = ""
        newView.frame = CGRect(x: 20, y: 400, width: 500, height: 500)
        let textSize = CGSize(width: 300, height: 50)
        let textFrame = CGRect(origin: CGPoint(x: 20, y: 200), size: textSize)
        textField1 = UITextField(frame: textFrame)
        let buttonArea = CGRect(x: textField1.center.x, y: textField1.center.y, width: 50, height: 50)
        let button1 = UIButton(frame: buttonArea)
        let tapGesture = UITapGestureRecognizer(target: button1, action: #selector(buttonAction))
        button1.gestureRecognizers?.append(tapGesture)
        textField1.placeholder = "New Grocery Item"
        textField1.backgroundColor = UIColor.gray
        textField1.textColor = UIColor.black
        textField1.isUserInteractionEnabled = true
        textField1.center = newView.center
        newView.backgroundColor = UIColor.green
        newView.bringSubview(toFront: textField1)
        view.addSubview(newView)
        newView.addSubview(textField1)
        newView.addSubview(button1)
    }
    func buttonAction()
    {
        let text = textField1.text as Any
        array.append(NSManagedObject(context: (text as? NSManagedObjectContext)!))
        myTableView.reloadData()
        newView.removeFromSuperview()
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let tableViewAction1 = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Aisle") { (UITableViewRowAction, indexPath1: IndexPath) in
            self.addNew()
            self.myTableView.cellForRow(at: indexPath1)?.detailTextLabel?.text = self.textField1.text
        }
        return [tableViewAction1]
    }
    
    @IBAction func addBarButton(_ sender: UIBarButtonItem)
    {
        addNew()
    }
    @IBAction func meatButton(_ sender: UIBarButtonItem)
    {
        changeValues(type: "Meat")
    }
    @IBAction func grainsButton(_ sender: Any)
    {
        changeValues(type: "Grain")
    }
    @IBAction func allItemsButton(_ sender: Any)
    {
        changeValues(type: "All")
    }
    @IBAction func fruitButton(_ sender: Any)
    {
        changeValues(type: "Fruit")
    }
    @IBAction func veggieButton(_ sender: Any)
    {
        changeValues(type: "Vegetable")
    }
    
    
}

