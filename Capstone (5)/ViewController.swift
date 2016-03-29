//
//  ViewController.swift
//  Capstone (5)
//
//  Created by Yuan-Hsiang Wang on 2015-11-27.
//  Copyright © 2015 Yuan-Hsiang Wang. All rights reserved.
//

import UIKit

// import CoreMotion calss for CMMotionManager and CMAltimeter
import CoreMotion

class ViewController: UIViewController {
    
    // Indicate Labels from main.storyboard
    
    @IBOutlet weak var AcceX: UILabel!
    @IBOutlet weak var AcceY: UILabel!
    @IBOutlet weak var AcceZ: UILabel!

    
    @IBOutlet weak var GyroX: UILabel!
    @IBOutlet weak var GyroY: UILabel!
    @IBOutlet weak var GyroZ: UILabel!
    
    @IBOutlet weak var Meters: UILabel!
    @IBOutlet weak var Kilopascal: UILabel!
    
    
    // Indicate CMMotionManager() to invoke accelerometer and gyroscope
    let motionManager = CMMotionManager()
    // Indicate CMAltimeter() to invoke barometer
    let altimeterManager = CMAltimeter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Controll the tracking time by invoke accelerometerUpdateInterval and gyroUpdateInterval
        motionManager.accelerometerUpdateInterval = 0.5
        motionManager.gyroUpdateInterval = 0.5
        
        // Invoke accelerometerAvailable to check if the device supports an accelerometer
        if(motionManager.accelerometerAvailable == true)
        {
            // Indicate CMAccelerometerHandler and CMAccelerometerData to get data
            let accHandler : CMAccelerometerHandler = {
                (data: CMAccelerometerData? , error: NSError?) -> Void in
                // Convert data type double to string
                self.AcceX.text = String(format: "%.6f", data!.acceleration.x);
                self.AcceY.text = String(format: "%.6f", data!.acceleration.y);
                self.AcceZ.text = String(format: "%.6f", data!.acceleration.z);
            }
            // Invoke startAccelerometerUpdatesToQueue(NSOperationQueue, withHandler) to update data
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: accHandler)
        }
        else
        {
            // Show "Not Available" if device doesn't supports an accelerometer
            self.AcceX.text = "Not Available";
            self.AcceY.text = "Not Available";
            self.AcceZ.text = "Not Available";
        }
        
         // Invoke gyroscope to check if the device supports a gyroscope
        if(motionManager.gyroAvailable == true)
        {
            // Indicate CMGyroHandler and CMGyroData to get data
            let gyroHandler : CMGyroHandler = {
                (data : CMGyroData? , error : NSError? ) -> Void in
                // Convert data type double to string
                self.GyroX.text = String(format: "%.6f", data!.rotationRate.x);
                self.GyroY.text = String(format: "%.6f", data!.rotationRate.y);
                self.GyroZ.text = String(format: "%.6f", data!.rotationRate.z);
            }
            // Invoke startGyroUpdatesToQueue(NSOperationQueue, withHandler) to update data
            motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: gyroHandler)
        }
        else
        {
            // Show "Not Available" if device doesn't supports a gyroscope
            self.GyroX.text = "Not Available";
            self.GyroY.text = "Not Available";
            self.GyroZ.text = "Not Available";
        }
        
        
        
        // Invoke isRelativeAltitudeAvailable() to check if the device supports a barometer
        if(CMAltimeter.isRelativeAltitudeAvailable() == true)
        {
            // Indicate CMAltitudeHandler and CMAltitudeData to get data
            let AltitudeHandler : CMAltitudeHandler = {
                (data: CMAltitudeData? , error : NSError?) -> Void in
                // Convert data type double to string
                self.Meters.text = String(format: "%.2@", data!.relativeAltitude);
                self.Kilopascal.text = String(format: "%.2@", data!.pressure);
            }
            altimeterManager.startRelativeAltitudeUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: AltitudeHandler)
        }
        else
        {
            // Show "Not Available" if device doesn't supports a barometer
            self.Meters.text = "Not Available";
            self.Kilopascal.text = "Not Available";
        }
        

    }
      //Indicate stop button from main.storyboard
    @IBAction func OnClick_Stop(sender: AnyObject) {
        // invoke stopAccelerometerUpdates(), stopGyroUpdates() and stopRelativeAltitudeUpdates() to stop tracking
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
        altimeterManager.stopRelativeAltitudeUpdates()
        
    }
    
    //Indicate start button from main.storyboard
    @IBAction func OnClick_Start(sender: AnyObject) {
        // invoke viewDidLoad() to restart tracking
        viewDidLoad()
    }
    
    
    //Indicate reset button from main.storyboard
    @IBAction func OnClick_Reset(sender: AnyObject) {
        
        // reset all value to "0"
        self.AcceX.text = "0.000000";
        self.AcceY.text = "0.000000";
        self.AcceZ.text = "0.000000";
        
        self.GyroX.text = "0.000000";
        self.GyroY.text = "0.000000";
        self.GyroZ.text = "0.000000";
        
        self.Meters.text = "0.000000";
        self.Kilopascal.text = "0.000000";
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

