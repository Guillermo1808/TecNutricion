//panatalla en donde se muestra las graficas de la composicion corporal dependiendo de lo seleccionado del segmented control, tambine muetsra la opcion de poder agregar datos

import UIKit
import Charts

class ComposicionCorporalViewController: UIViewController, protocoloAgreagarDatos {
    
    

    @IBOutlet weak var excepcionLb: UILabel!
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet var generalLineChart: LineChartView!
    var pesoDatos:[Double]!
    var masaDatos:[Double]!
    var grasaDatos:[Double]!
    var fechas:[String]!
    var data = [ChartDataEntry]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        excepcionLb.isHidden = false
        // Do any additional setup after loading the view.
        actualiza()
        
        //En caso de que haya datos muestra la grafica
        if pesoDatos.count > 0{
            updateChart(fechas: fechas, valores: pesoDatos, grafica: "Peso")
        }
        
    }
    
    //Segemented en donde dependiendo lo seleccionado manda a llamar con sus datos dependiendo de la categoria
    @IBAction func cambiaGrafica(_ sender: UISegmentedControl) {
        if pesoDatos.count > 0{
            if sender.selectedSegmentIndex == 0 {
                //PEso
                updateChart(fechas: fechas, valores: pesoDatos, grafica: "Peso")
            }
            else if sender.selectedSegmentIndex == 1{
                //Masa M
                updateChart(fechas: fechas, valores: masaDatos, grafica: "MasaMuscular")
            }
            else if sender.selectedSegmentIndex == 2{
                //Grasa
                updateChart(fechas: fechas,valores: grasaDatos, grafica: "Grasa")
            }
        }
    }
    
    //funcion que al abrir la pantalla carga los datos de los defaults guardados
    func actualiza(){
        let defaults = UserDefaults.standard
        if let pes = defaults.value(forKey: "pesoDatos") as? [Double]{
            pesoDatos = pes
        }else{
            pesoDatos = []
        }
        if let mas = defaults.value(forKey: "masaDatos") as? [Double]{
            masaDatos = mas
        }else{
            masaDatos = []
        }
        if let gra = defaults.value(forKey: "grasaDatos") as? [Double]{
            grasaDatos = gra
        }else{
            grasaDatos = []
        }
        if let fec = defaults.value(forKey: "fechaDatos") as? [String]{
            fechas = fec
        }else{
            fechas = []
        }
    }
    
    @IBAction func quitaView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    //funcion que actualiza la grafica dependiendo de los datos del segmented, tambien se cambia el X Axis para que pueda mostrar String en la grafica para poner la fechas
    func updateChart(fechas: [String], valores: [Double], grafica: String){
        if(valores.count < 2){
            excepcionLb.isHidden = false
        }else{
            excepcionLb.isHidden = true
            let formatter = LineChartFormatter()
            formatter.setValues(values: fechas)
            let xAxis:XAxis = XAxis()
            var i = 0
            data = []
            for dato in valores{
                data.append(ChartDataEntry(x: Double(i), y: dato))
                i += 1
            }
            let set = LineChartDataSet(entries: data, label: grafica)
            let lineData = LineChartData(dataSet: set)
            //generalLineChart.data = lineData
            xAxis.valueFormatter = formatter
            generalLineChart.xAxis.labelPosition = .bottom
            generalLineChart.xAxis.drawGridLinesEnabled = false
            generalLineChart.xAxis.valueFormatter = xAxis.valueFormatter
            generalLineChart.chartDescription?.enabled = false
            generalLineChart.legend.enabled = true
            generalLineChart.rightAxis.enabled = false
            generalLineChart.xAxis.granularityEnabled = true
            generalLineChart.xAxis.granularity = 1.0 //default granularity is 1.0, but it is better to be explicit
            generalLineChart.xAxis.decimals = 0
            generalLineChart.leftAxis.decimals = 2
            generalLineChart.xAxis.labelRotationAngle = -70.0
            generalLineChart.data = lineData
        }
        
    }
    
    
    
    // MARK: - Navigation

    //prepar en donde se llama la pantalla de agregar datos a la grafica utilizando protocolos
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AgregaComposicion"{
            let vistaAgrega = segue.destination as! AgregaComposicionViewController
            vistaAgrega.delegado = self
        }
    }
    
    //Funcion del protocolo en donde suma los datos ingresados en la otra pantalla para actualizarlos y se guardan en defaults
    func agregaDatos(peso: Double, masaMuscular: Double, grasa: Double, fechaHoy: Date) {
        pesoDatos.append(peso)
        masaDatos.append(masaMuscular)
        grasaDatos.append(grasa)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let currentDateString = formatter.string(from: fechaHoy)
        fechas.append(currentDateString)
        if segmented.selectedSegmentIndex == 0 {
           //PEso
            updateChart(fechas: fechas, valores: pesoDatos, grafica: "Peso")
        }
        else if segmented.selectedSegmentIndex == 1{
            //Masa M
            updateChart(fechas: fechas, valores: masaDatos, grafica:  "MasaMuscular")
        }
        else if segmented.selectedSegmentIndex == 2{
            //Grasa
            updateChart(fechas: fechas,valores: grasaDatos, grafica: "Grasa")
        }
        let defaults = UserDefaults.standard
        defaults.set(pesoDatos, forKey: "pesoDatos")
        defaults.set(masaDatos, forKey: "masaDatos")
        defaults.set(grasaDatos, forKey: "grasaDatos")
        defaults.set(fechas, forKey: "fechaDatos")
    }

}

//clase para poder cambiar el XAxis de Double a String
public class LineChartFormatter: NSObject, IAxisValueFormatter
{
    var names = [String]()

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String
    {
        return names[Int(value)]
    }

    public func setValues(values: [String])
    {
        self.names = values
    }
}


