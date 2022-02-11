//
//  ViewController.swift
//  Flower
//
//  Created by Chao Ma on 11/19/20.
//  Copyright © 2020 Ruijiang Ma. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    let imagePicker = UIImagePickerController()
    var model = Model()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .green
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
    }
    // imagePicker delegate method
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // let user pick a image
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage]  as? UIImage {
        
            // convert it into a ciimage
            guard let convertedciImage = CIImage(image: userPickedImage) else {
                
                fatalError("cannot convert to CIImage.")
        
            }
            
            // pass ciimage into the detect function
            detect(image: convertedciImage)
            //convert user picked image
        
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
         
    }
    
    // core image

    


 
    

    @IBAction func cameraTapped1(_ sender: UIBarButtonItem) {

        
        present(imagePicker, animated: true, completion: nil)
    }
    
}

