//
//  ViewController.swift
//  CoreAnimation
//
//  Created by  bochb on 2017/7/17.
//  Copyright © 2017年 boc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    static let tableViewCellReuseId = "tableViewCellReuseId"
    
    lazy var data = {
        return [
            "CAShapeLayer",
            "CAGradientLayer",
            "CAEmitterLayer",
            "CAReplicatorLayer",
            "CATransformLayer",
            "CATransition"
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ViewController.tableViewCellReuseId)
        
        
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.tableViewCellReuseId, for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var destinationViewController: UIViewController?
        if indexPath.row == 0 {
            destinationViewController = HLLShapeLayerController()
        }else if indexPath.row == 1{
            destinationViewController = HLLCAGradientLayerController()
        }else if indexPath.row == 2 {
            destinationViewController = HLLCAEmitterLayerController()
        }else if indexPath.row == 3 {
            destinationViewController = HLLCAReplicatorLayerController()
        }else if indexPath.row == 4{
            destinationViewController = HLLCATransformLayerController()
        }else if indexPath.row == 5{
            destinationViewController = HLLTransitoonViewController()
        }
        
        destinationViewController?.navigationItem.title = data[indexPath.row]
        navigationController?.pushViewController(destinationViewController!, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

