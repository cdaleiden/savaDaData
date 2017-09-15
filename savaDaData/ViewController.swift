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

    var array : [NSManagedObject] = []
    
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
            time - 1.0
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

    func save(text: String, runningTimes: Float)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else
        {
                return
        }
        let manageContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: manageContext)!
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

    
    

}

