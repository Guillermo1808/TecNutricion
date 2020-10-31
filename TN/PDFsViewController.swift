//Pantalla que muestra el pdf seleccionado en el menu de PDFS

import UIKit
import PDFKit

class PDFsViewController: UIViewController {

    @IBOutlet weak var menu: UIBarButtonItem!
    var Titulo : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(Titulo!)
        view.backgroundColor = UIColor(red: 84/255, green: 180/255, blue: 190/255, alpha: 1)
        let pdfView = PDFView()
        self.view.addSubview(pdfView)
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        //Contraints a las esquinas
        pdfView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        pdfView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
        pdfView.autoScales = true
        
        guard let path = Bundle.main.url(forResource: Titulo, withExtension: "pdf") else {
            return
        }
        
        if let doc = PDFDocument(url: path){
            pdfView.document = doc
        }
        
    }
    
    @IBAction func quitarView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}

