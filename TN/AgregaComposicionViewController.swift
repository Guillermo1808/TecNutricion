//
//  AgregaComposicionViewController.swift
//  TN
//
//  Created by Fernando Leal  on 27/05/20.
//  Copyright © 2020 Fernando Leal . All rights reserved.
//

import UIKit

protocol protocoloAgreagarDatos {
    func agregaDatos(peso: Double, masaMuscular: Double, grasa: Double, fechaHoy: Date) -> Void
}

class AgregaComposicionViewController: UIViewController {

    
    @IBOutlet weak var pesoTf: UITextField!
    @IBOutlet weak var masaMuscular: UITextField!
    @IBOutlet weak var grasaTf: UITextField!
    
    
    var delegado: protocoloAgreagarDatos!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pesoTf.keyboardType = UIKeyboardType.numberPad
        masaMuscular.keyboardType = UIKeyboardType.numberPad
        grasaTf.keyboardType = UIKeyboardType.numberPad
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func quitaView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func agregar(_ sender: UIButton) {
        if(pesoTf.text == "" || masaMuscular.text == "" || grasaTf.text == ""){
            
        }else{
            let currentDate = Date()
            let pesot = Double(pesoTf.text!)!
            let masat = Double(masaMuscular.text!)!
            let grasat = Double(grasaTf.text!)!
            delegado.agregaDatos(peso: pesot, masaMuscular: masat, grasa: grasat, fechaHoy: currentDate)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
}

