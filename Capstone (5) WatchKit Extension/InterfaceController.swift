//
//  InterfaceController.swift
//  Capstone (5) WatchKit Extension
//
//  Created by Yuan-Hsiang Wang on 2015-11-27.
//  Copyright © 2015 Yuan-Hsiang Wang. All rights reserved.
//

import WatchKit
import Foundation

// import CoreMotion calss for CMMotionManager and CMAltimeter
import CoreMotion

class InterfaceController: WKInterfaceController {
    
    // Indicate Labels from Interface.storyboard
    @IBOutlet var acceX: WKInterfaceLabel!
    @IBOutlet var acceY: WKInterfaceLabel!
    @IBOutlet var acceZ: WKInterfaceLabel!

    @IBOutlet var gyroX: WKInterfaceLabel!
    @IBOutlet var gyroY: WKInterfaceLabel!
    @IBOutlet var gyroZ: WKInterfaceLabel!
    
    @IBOutlet var meters: WKInterfaceLabel!
    @IBOutlet var kpa: WKInterfaceLabel!
    
    
   // Indicate CMMotionManager() to invoke accelerometer and gyroscope
    let motionManager = CMMotionManager()
    
    // Indicate CMAltimeter() to invoke barometer
    let altimeterManager = CMAltimeter()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        
        
        // Controll the tracking time by invoke accelerometerUpdateInterval and gyroUpdateInterval
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.gyroUpdateInterval = 0.1
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // Invoke accelerometerAvailable to check if the device supports an accelerometer
        if(motionManager.accelerometerAvailable == true)
        {
            // Indicate CMAccelerometerHandler and CMAccelerometerData to get data
            let Ahandler:CMAccelerometerHandler = {
                // Convert data type double to string
                (data: CMAccelerometerData? , error : NSError?) -> Void in
                self.acceX.setText(String(format: "%.6f", data!.acceleration.x))
                self.acceY.setText(String(format: "%.6f", data!.acceleration.y))
                self.acceZ.setText(String(format: "%.6f", data!.acceleration.z))
                
               
            }
            // Invoke startAccelerometerUpdatesToQueue(NSOperationQueue, withHandler) to update data
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: Ahandler)
        }
        else
        {
            self.acceX.setText("Not available")
            self.acceY.setText("Not available")
            self.acceZ.setText("Not available")
        }
        
        // Invoke gyroscope to check if the device supports a gyroscope
        if(motionManager.gyroAvailable == true)
        {
            // Indicate CMGyroHandler and CMGyroData to get data
            let Ghandler:CMGyroHandler = {
                // Convert data type double to string
                (data: CMGyroData? , error : NSError?) -> Void in
                self.gyroX.setText(String(format: "%.6f", data!.rotationRate.x))
                self.gyroY.setText(String(format: "%.6f", data!.rotationRate.y))
                self.gyroZ.setText(String(format: "%.6f", data!.rotationRate.z))
                
                print("Gyroscope" + "X : \(data!.rotationRate.x)" + "Y : \(data!.rotationRate.y)" + "Z : \(data!.rotationRate.z)")
            }
            // Invoke startGyroUpdatesToQueue(NSOperationQueue, withHandler) to update data
            motionManager.startGyroUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: Ghandler)
        }
        else
        {
            // Show "Not Available" if device doesn't supports a gyroscope
            self.gyroX.setText("Not available")
            self.gyroY.setText("Not available")
            self.gyroZ.setText("Not available")
        }
        
        // Invoke isRelativeAltitudeAvailable() to check if the device supports a barometer
        if(CMAltimeter.isRelativeAltitudeAvailable() == true)
        {
            // Indicate CMAltitudeHandler and CMAltitudeData to get data
            let AltitudeHandler : CMAltitudeHandler = {
                 // Convert data type double to string
                (data : CMAltitudeData? , error : NSError?) -> Void in
                self.meters.setText(String(format: "%.2@", data!.relativeAltitude));
                self.kpa.setText(String(format: "%.2@", data!.pressure))
                
                print("Barometer" + "Meters : \(data!.relativeAltitude)" + "Kpa : \(data!.pressure)")
            }
            altimeterManager.startRelativeAltitudeUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler: AltitudeHandler)
        }
        else
        {
            // Show "Not Available" if device doesn't supports a barometer
            self.meters.setText("Not available")
            self.kpa.setText("Not available")
        }
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //Indicate stop button from Interface.storyboard
    @IBAction func OnClick_Stop() {
        // invoke stopAccelerometerUpdates(), stopGyroUpdates() and stopRelativeAltitudeUpdates() to stop tracking
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
        altimeterManager.stopRelativeAltitudeUpdates()
    }
   
     //Indicate start button from Interface.storyboard
    @IBAction func OnClick_Start() {
        // invoke viewDidLoad() to restart tracking
        willActivate()
    }
    
    //Indicate reset button from Interface.storyboard
    @IBAction func OnClick_Reset() {
        // reset all value to "0"
        self.acceX.setText("0.000000")
        self.acceY.setText("0.000000")
        self.acceZ.setText("0.000000")
        
        self.gyroX.setText("0.000000")
        self.gyroY.setText("0.000000")
        self.gyroZ.setText("0.000000")
        
        self.meters.setText("0.000000")
        self.kpa.setText("0.000000")
        
    }

}
