//
//  RegisterVC.swift
//  VSCPU
//
//  Created by Walter Berreta on 11/17/15.
//  Copyright © 2015 Edsims. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    @IBOutlet weak var READ: UILabel!
    @IBOutlet weak var CLK: UILabel!
    @IBOutlet weak var ACINC: UILabel!
    @IBOutlet weak var PCINC: UILabel!
    @IBOutlet weak var ACLOAD: UILabel!
    @IBOutlet weak var IRLOAD: UILabel!
    @IBOutlet weak var DRLOAD: UILabel!
    @IBOutlet weak var PCLOAD: UILabel!
    @IBOutlet weak var ARLOAD: UILabel!
    
    @IBOutlet weak var memoryLoc: UILabel!
    @IBOutlet weak var RTLstatement: UILabel!
    @IBOutlet weak var status: UILabel!
    
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //xStart,yStart,xEnd, yEnd
    let IRDR = [470, 390, 685, 390, 685, 390, 685, 720, 685, 720, 50, 720, 50, 720, 50, 505, 50, 505, 265, 505]
    
    let ARDR = [470, 390, 685, 390, 685, 390, 685, 720, 685, 720, 50, 720, 50, 720, 50, 175, 50, 175, 265, 175]
    
    let DRM = [660, 55, 685, 55, 685, 55, 685, 720, 685, 720, 50, 720, 50, 720, 50, 390, 50, 390, 265, 390]
    
    let ARPC = [470, 282, 685, 282, 685, 282, 685, 720, 685, 720, 50, 720, 50, 720, 50, 175, 50, 175, 265, 175]
    
    let ALUDR = [470, 390, 685, 390, 685, 390, 685, 720, 685, 720, 50, 720, 50, 720, 50, 630, 50, 630, 130, 630]
    
    let ALUAC = [470, 603, 485, 603, 485, 603, 485, 565, 485, 565, 105, 565, 105, 565, 105, 605, 105, 605, 130, 605]
    
    let ACALU = [205, 615, 265, 615]
    
    let PAAC = [760, 568, 780, 568, 780, 568, 780, 620, 780, 620, 820, 620]
    
    let PADR = [760, 653, 820, 653]
    
    let MUXPA = [880, 625, 935, 625]
    
    //DR start is at y=390
    //Bus x=685
    

    
    @IBAction func Start(sender: UIButton) {
        
        let disableMyButton = sender
        disableMyButton.enabled = false
        
        status.text = "Running"
        
        //FETCH1
   
        ARLOAD.textColor = UIColor.redColor()
        RTLstatement.text = "FETCH1"
        Paths(ARPC)
        
        
        //FETCH2
        delay(5.0){
            self.ARLOAD.textColor = UIColor.blackColor()
            self.READ.textColor = UIColor.redColor()
            self.DRLOAD.textColor = UIColor.redColor()
            self.PCINC.textColor = UIColor.redColor()
            self.RTLstatement.text = "FETCH2"
            self.Paths(self.DRM)
            
        }
        
        delay(10.0){
            //FETCH3
            self.READ.textColor = UIColor.blackColor()
            self.DRLOAD.textColor = UIColor.blackColor()
            self.PCINC.textColor = UIColor.blackColor()
            self.ARLOAD.textColor = UIColor.redColor()
            self.IRLOAD.textColor = UIColor.redColor()
            self.RTLstatement.text = "FETCH3"
            self.Paths(self.ARDR)
            self.Paths(self.IRDR)
            
        }
        
        delay(15.0){
            self.ARLOAD.textColor = UIColor.blackColor()
            self.IRLOAD.textColor = UIColor.blackColor()
            self.READ.textColor = UIColor.redColor()
            self.DRLOAD.textColor = UIColor.redColor()
            self.RTLstatement.text = "ADD1"
            self.Paths(self.DRM)
            
        }
        
        delay(20.0){
            self.READ.textColor = UIColor.blackColor()
            self.DRLOAD.textColor = UIColor.blackColor()
            self.ACLOAD.textColor = UIColor.redColor()
            self.RTLstatement.text = "ADD2"
            self.Paths(self.ALUDR)
            self.Paths(self.ALUAC)
            
        }
        
        delay(25.0){
            self.RTLstatement.text = "ADD2"
            self.Paths(self.PAAC)
            self.Paths(self.PADR)
            
        }
        
        delay(30.0){
            self.RTLstatement.text = "ADD2"
            self.Paths(self.MUXPA)
        }
        
        delay(35.0){
            self.RTLstatement.text = "ADD2"
            self.Paths(self.ACALU)
        }
        
        delay(40.0){
            self.ACLOAD.textColor = UIColor.blackColor()
            disableMyButton.enabled = true
        }
        

        
        
        
    }
    
    func delay(delay: Double, closure: ()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(),
            closure
        )
    }
    
    func Paths(pathArr: [Int])
    {
        let path = UIBezierPath()
        
        let imageName = "redDot.png"
        let image = UIImage(named: imageName)
        let redDot = UIImageView(image: image!)
        
        redDot.frame = CGRect(x: screenWidth, y: screenHeight, width: 10, height: 10)
        self.view.addSubview(redDot)
        
        for var i = 0;  i < pathArr.count; i = i+4 {
            
            path.moveToPoint(CGPoint(x: pathArr[i],y: pathArr[i+1]))
            
            path.addQuadCurveToPoint(CGPoint(x: pathArr[i+2], y: pathArr[i+3]), controlPoint: CGPoint(x: pathArr[i], y: pathArr[i+1]))
        }
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.CGPath
        
        animation.repeatCount = 0
        animation.duration = 5.0
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = true
        
        redDot.layer.addAnimation(animation, forKey: "animate position along path")
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
