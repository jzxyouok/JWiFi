//
//  ViewController.swift
//  JWiFi
//
//  Created by 晋先森 on 16/7/5.
//  Copyright © 2016年 晋先森. All rights reserved.
//

import UIKit
 
 
class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var datas = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        configDatas()

    }

    func configDatas() {

        let steps =  [["step":"Step 1","imageName":"1.png"],
                      ["step":"Step 2","imageName":"2"],
                      ["step":"Step 3","imageName":"3"],
                      ["step":"Step 4","imageName":"4"],
                      ["step":"Step 5","imageName":"5"]]

        for index  in 0..<steps.count {
            let model = StepModel(dict: steps[index])
            datas.addObject(model)
        }
    }

    func updateScrollView() {

        let width = scrollView.frame.size.width / 5 * 4

        for index in 0..<datas.count {

            let model:StepModel = datas[index] as! StepModel

            let stepView = UIView.init(frame: CGRectMake( CGFloat(index) * (width+10),0, width, scrollView.frame.size.height))
            stepView.backgroundColor = UIColor.whiteColor()
            stepView.layer.cornerRadius = 5
            scrollView.addSubview(stepView)

            let label = UILabel.init(frame: CGRectMake(0, 0,stepView.frame.size.width, 35))
            label.text = model.step
            label.textAlignment = NSTextAlignment.Center
            stepView.addSubview(label)

            let imageView = UIImageView.init(image: UIImage.init(named: model.imageName!))
            imageView.frame = CGRectMake(0, CGRectGetMaxY(label.frame), stepView.frame.size.width, stepView.frame.size.height - label.frame.size.height - 10)

            stepView.addSubview(imageView)
        }
        scrollView.contentSize = CGSizeMake((width + 10) * CGFloat(datas.count), 0)
    }

    override func viewDidLayoutSubviews() {
           updateScrollView()
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

