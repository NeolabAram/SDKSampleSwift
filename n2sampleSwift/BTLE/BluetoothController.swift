//
//  BluetoothController.swift
//  n2sampleSwift
//
//  Created by Aram Moon on 2017. 5. 18..
//  Copyright © 2017년 Aram Moon. All rights reserved.
//

import Foundation
import CoreBluetooth

class BluetoothController: UIViewController, CBCentralManagerDelegate {
    
    var centralManager : CBCentralManager!
    
let PENCOMM_SERVICE_UUID = "E20A39F4-73F5-4BC4-A12F-17D1AD07A961"
let PENCOMM_READ_CHARACTERISTIC_UUID = "08590F7E-DB05-467E-8757-72F6FAEB13D4"
let PENCOMM_WRITE_CHARACTERISTIC_UUID = "C0C0C0C0-DEAD-F154-1319-740381000000"
let NEO_PEN_SERVICE_UUID = "18F1"
    override func viewDidLoad() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    @IBAction func Scan(_ sender: Any) {
        print("SCAN start!!")
        let servviceuuid = CBUUID(string: PENCOMM_SERVICE_UUID)
        let servviceuuidn = CBUUID(string: NEO_PEN_SERVICE_UUID)

        centralManager.scanForPeripherals(withServices: [servviceuuid,servviceuuidn], options: nil)
    }
    
    @IBAction func ScanStop(_ sender: Any) {
        print("SCAN stop!!")
        centralManager.stopScan()
    }
    
    
    //MARK: - CBCentralManagerDelegate
    func centralManagerDidUpdateState(_ central: CBCentralManager){
        print("State: \(central.state)")
    }


    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        print("peripheral: \(peripheral) rss:  \(RSSI)")
        print("ad: \(advertisementData)")
        if(Int(RSSI) > -15){
            print("Connect")
            self.centralManager.connect(peripheral, options: nil)
        }
    }
    

    //성공시
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("연결 성공")
    }
    
    //실패시
    func centralManager(_ central: CBCentralManager, didFailConnect peripheral: CBPeripheral, error: Error?) {
        print("연결 실패")
    }
    
    
}
