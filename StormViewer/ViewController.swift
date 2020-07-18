//
//  ViewController.swift
//  StormViewer
//
//  Created by David Vargaspuga on 7/17/20.
//  Copyright © 2020 David Vargas Puga. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fn = FileManager.default // lets us work with the file system
        let path = Bundle.main.resourcePath! // bundle is a dir containing our compiled program an all assets; there will always be a resource path, we can force unwrap that
        let items = try! fn.contentsOfDirectory(atPath: path) //gets contents from bundle; if we cant read something is bad, it should never happen
        
        for item in items {
            if item.hasPrefix("nssl"){
                //this is a picture to load
                pictures.append(item)
            }
        }
        pictures.sort()
        
        // Do any additional setup after loading the view.
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

