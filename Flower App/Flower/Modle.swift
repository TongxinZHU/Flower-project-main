//
//  Modle.swift
//  Flower
//
//  Created by Chao Ma on 12/3/20.
//  Copyright © 2020 Ruijiang Ma. All rights reserved.
//

import Foundation
import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage


class Model
{
    func detect(image: CIImage) {
            
        let wikipediaURL = "https://en.wikipedia.org/w/api.php"
            
            guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
                fatalError("Can't load model")
            }
            
            let request = VNCoreMLRequest(model: model) { (request, error) in
                guard let classification = request.results?.first as? VNClassificationObservation else {
                    fatalError("Could not complete classfication")
                }
          
                
                self.navigationItem.title = classification.identifier.capitalized
                self.requestInfo(flowerName: classification.identifier)
                
            }
            
            let handler = VNImageRequestHandler(ciImage: image)
            
            do {
                try handler.perform([request])
            }
            catch {
                print(error)
            }
            
            
        }
    
    func requestInfo(flowerName: String) {
        let parameters : [String:String] = [
         "format" : "json",
         "action" : "query",
         "prop" : "extracts|pageimages",
         "exintro" : "",
         "explaintext" : "",
         "titles" : flowerName,
         "indexpageids" : "" ,
         "redirects" : "1",
         "pithumbsize" : "500"
            
         ]
        
        Alamofire.request(wikipediaURL, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                print("Got the wikipedia info.")
                print(response)
                
                let flowerJSON : JSON = JSON(response.result.value!)
                
                let pageid = flowerJSON["query"]["pageids"][0].stringValue
                let flowerDescription = flowerJSON["query"]["pages"][pageid]["extract"].stringValue
                self.label.text = flowerDescription
                
                let flowerImageURL = flowerJSON["query"]["pages"][pageid]["thumbnail"]["source"].stringValue
                
                self.imageView.sd_setImage(with: URL(string: flowerImageURL))
            }
        }
    }
}
