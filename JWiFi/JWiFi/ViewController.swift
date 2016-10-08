//
//  ViewController.swift
//  JWiFi
//
//  Created by 晋先森 on 16/7/5.
//  Copyright © 2016年 晋先森. All rights reserved.
//

import UIKit

let email = "hi@jinxiansen.com"
 
class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var datas = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        configDatas()

    }

    override func viewDidLayoutSubviews() {
        updateScrollView()
    }

    func configDatas() {

        let steps =  [["step":"Step 1","imageName":"1.png"],
                      ["step":"Step 2","imageName":"2"],
                      ["step":"Step 3","imageName":"3"],
                      ["step":"Step 4","imageName":"4"],
                      ["step":"Step 5","imageName":"5"]]

        for index  in 0..<steps.count {
            let model = StepModel(dict: steps[index] as [String : AnyObject])
            datas.add(model)
        }
    }

    func updateScrollView() {

        let width:CGFloat = scrollView.frame.size.height * 1.5

        for index in 0..<datas.count {

            let model:StepModel = datas[index] as! StepModel

            let stepView = UIView.init(frame: CGRect(x: CGFloat(index) * (width+10),y: 0,width: width,height: scrollView.frame.size.height))
            stepView.backgroundColor = UIColor.white
            stepView.layer.cornerRadius = 5
            scrollView.addSubview(stepView)

            let label = UILabel.init(frame: CGRect(x:0,y: 0,width:stepView.frame.size.width,height: 35))
            label.text = model.step
            label.textAlignment = NSTextAlignment.center
            stepView.addSubview(label)

            let imageView = UIImageView.init(image: UIImage.init(named: model.imageName!))
            imageView.frame = CGRect(x: 0,y: label.frame.maxY,width: stepView.frame.size.width, height: stepView.frame.size.height - label.frame.size.height - 10)

            stepView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width:(width + 10) * CGFloat(datas.count),height: 0)
    }

    @IBAction func logoButtonClick(sender: AnyObject) {

        let board = UIPasteboard.general
        board.string = email
        let alert = UIAlertController.init(title: email, message: "邮箱已复制", preferredStyle: UIAlertControllerStyle.alert)

        let action = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default) { (action) in

        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)

    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

