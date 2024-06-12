//
//  Bluetooth.swift
//  team_project
//
//  Created by Taewon Yoon on 2/23/24.
//

import Foundation
import CoreBluetooth

enum BluetoothError: Error {
    case DecodingError
}

class Bluetooth: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate, ObservableObject {
    
    @Published var peripherals: Set<CBPeripheral> = Set<CBPeripheral>()
    @Published var values: String = .init()
    @Published var connected = false
        
    weak var writeCharacteristic: CBCharacteristic? // 데이터를 주변기기에 보내기 위한 characcteristic을 저장하는 변수
    
    // 데이터를 주변기기에 보내는 type을 설정한다. withResponse는 데이터를 보내면 이에 대한 답장이 오는 경우, withoutResponse는 데이터를 보내도 답장이 오지 않는 경우
    private var writeType: CBCharacteristicWriteType = .withoutResponse
    
    var centralManager : CBCentralManager! // centralManager 객체 만들기
    
    var pendingPeripheral : CBPeripheral? // 연결 시도중인 주변기기
    
    @Published var connectedPeripheral : CBPeripheral? // 연결된 아두이노 객체
    
    var serviceUUID = CBUUID(string: "FFE0") // 아래에 있는 128비트짜리 uuid를 사용하면 모듈을 못찾는다.
    //var serviceUUID = CBUUID(string: "DB91A538-062B-4444-1FCC-1B379D452DE1") // HM-10모듈이 기본적으로 갖고있다.
    // CBUUID initialisers는 16비트 또는 128비트 값을 모두 다룬다, 그리고 현재 Core Bluetooth 함수들은 이제 CBUUID를 사용한다.
    
    //characteristicUUID는 serviceUUID에 포함되어 있다. 이를 이용하여 데이터를 송수신한다. FFE0 서비스가 갖고있는 FFE1로 설정한다.
    var characteristicUUID = CBUUID(string: "FFE1")
    
    public override init() {
        super.init()
        print("초기화")
        self.centralManager = CBCentralManager.init(delegate: self, queue: nil, options: nil) // 1. centralManager 객체를 초기화 시킨다.
    }
    // central manager를 만들때 central manager는 이 메서드를 부른다.
    // centralManagerDidUpdateState 함수는 delegate한테 central manager'의 상태가 변했다고 알려주는데
    // 아래와 같은 경우는 init()에서 centralManager가 CBCentralManager.init(...)을 실행시켜서 초기화 시킴으로 상태가 변했으므로 이 함수를 실행시킨다.
    // 저전력 블루투스가 지원되고 central 기기에서 쓰일수 있도록 반드시 구현해야한다.
    func centralManagerDidUpdateState(_ central: CBCentralManager) { // 1. 그리고 대리자를 세팅시켜라
        print("만들어졌다")
        switch central.state {
        case .unknown:
            print("unknown")
        case .resetting:
            print("resetting")
        case .unsupported:
            print("unsupported")
        case .unauthorized:
            print("unauthorized")
        case .poweredOff:
            print("powered off")
        case .poweredOn:
            print("powered on")
//            self.centralManager.scanForPeripherals(withServices: nil, options: nil)
            self.centralManager.scanForPeripherals(withServices: [serviceUUID])
        @unknown default:
            fatalError()
        }
        connectedPeripheral = nil
        pendingPeripheral = nil
    }
    func startScan(){ // 2. 주변기기를 스캔해라
        guard centralManager.state == .poweredOn else {return}
        // [serviceUUID]만 갖고있는 기기만 검색
        print("주변기기 스캔시작")
        centralManager.scanForPeripherals(withServices: [serviceUUID], options: nil)
//        let peripherals = centralManager.retrieveConnectedPeripherals(withServices: [serviceUUID]) // 3. 이미 연결된 주변기기를 찾아라.
        // 아래 내용은 불필요한 것
//        for peripheral in peripherals { // 찾은 주변기기를 가지고
//            centralManager?.serialDidDiscoverPeripheral(peripheral: peripheral, RSSI: nil) // 대지라에게 찾은 peripheral를 넘겨준다.
         // 주변기기를 파라미터로 전달하여 ViewController의 peripheralList에 저장되도록 하고, TableView에 나타나도록 하는 것이다.
//         }
    }
    func stopScan() {
        centralManager.stopScan()
    }
    
    // central manager가 peripheral를 발견할 때마다 delegate 객체의 메서드를 호출한다. // RSSI: 신호강도
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        peripherals.insert(peripheral)
    }
        
    // 기기가 연결되면 호출되는 delegate 메서드다.
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self // 5. 연결되면 주변기기 대리자 만들기
        connectedPeripheral = peripheral
        
        // peripheral의 Service들을 검색한다. 파라미터를 nil으로 설정하면 Peripheral의 모든 service를 검색한다.
        peripheral.discoverServices([serviceUUID]) // 6.
        if peripheral.name == "YourNewName" {
            connected = true
        }
        print([serviceUUID])
        print("연결 성공")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("연결 끊김")
        if peripheral.name == "YourNewName" {
            print("연결 끊김")
            connected = false
            
        }
    }
    
//    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
//        print("다시 재접 연결")
//    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) { // 7.
        for service in peripheral.services! {
            //검색된 모든 service에 대해서 characteristic을 검색한다. 파라미터를 nil로 설정하면 해당 serivce의 모든 characteristic을 검색한다.
            print("특성검색")
            peripheral.discoverCharacteristics([characteristicUUID], for: service)
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) { // 8.
        for characteristic in service.characteristics!{
            if characteristic.uuid == characteristicUUID {
                print("구독")
                peripheral.setNotifyValue(true, for: characteristic) // 10. 구독한다.
                
                writeCharacteristic = characteristic // writeCharacteristic:  주변기기에 보내기 위한 특성을 저장하는 변수
                
                writeType = characteristic.properties.contains(.write) ? .withResponse : .withoutResponse // 9.
                
                connected = true
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        // 전송받은 데이터가 존재하는지 확인
        let data = characteristic.value
        guard data != nil else { return }
        
        do {
            guard let js = try? JSONDecoder().decode(BluetoothModel.self, from: data!) else {
                throw BluetoothError.DecodingError
            }
            print(js.bpm.description + " " + js.power_status.description)
        } catch {
            
        }
        
        if let str = String(data: data!, encoding: String.Encoding.utf8) {
            print(str)
            values = str
        }
    }
    
    func sendMessageToDevice(_ message: String) -> Bool{
        // 만약 블루투스가 연결되지 않았다면 보내면 안된다.
        if connectedPeripheral?.state == .connected {
            if let data = message.data(using: String.Encoding.utf8), let charater = writeCharacteristic {
                connectedPeripheral!.writeValue(data, for: charater, type: writeType) // writeCharacteristic은 주변기기에 보내기 위한 특성
                return true
            }
        }
        return false
    }
    
}

