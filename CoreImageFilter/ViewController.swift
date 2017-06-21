//
//  ViewController.swift
//  CoreImageFilter
//
//  Created by Mac on 6/21/17.
//  Copyright © 2017 baon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    
    let filterArray = [
        "CIPhotoEffectChrome",
        "CISepiaTone",
        "CIPhotoEffectTransfer",
        "CIPhotoEffectTonal",
        "CIPhotoEffectProcess",
        "CIPhotoEffectNoir",
        "CIPhotoEffectInstant",
        "CIPhotoEffectFade"
    ]
    
    private var context: CIContext!
    private var filter: CIFilter!
    private var beginImage: CIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyFilter(with: slider.value)
        logAllFilters()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        filter.setValue(sender.value, forKey: kCIInputIntensityKey)
        let outputImage = filter.outputImage!
        
        let cgImg = context.createCGImage(outputImage, from: outputImage.extent)
        let newImage = UIImage(cgImage: cgImg!)
        imageView.image = newImage
    }
    func applyFilter(with intensity: Float) {
        beginImage = CIImage(image: #imageLiteral(resourceName: "image"))
        
        filter = CIFilter(name: "CISepiaTone")!
        filter.setValue(beginImage, forKey: kCIInputImageKey)
        filter.setValue(intensity, forKey: kCIInputIntensityKey)
        
        context = CIContext(options: nil)
        let cgImg = context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        let newImage = UIImage(cgImage: cgImg!)
        imageView.image = newImage
    }

    func logAllFilters() {
        let properties = CIFilter.filterNames(inCategory: kCICategoryBuiltIn)
        print(properties)
        
        for filterName in properties {
            let fltr = CIFilter(name:filterName as String)
            print(fltr!.attributes)
        }
    }

}

