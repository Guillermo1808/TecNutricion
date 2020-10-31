//View controller que se encarga de mostrar tu dia, en donde muestra los datos de hoy y los que se llevan acumulado

import UIKit
import Charts

class ViewController: UIViewController, ChartViewDelegate {
    
    //declaracion de los outlets de la pantalla
    
    @IBOutlet weak var imgAgua: UIImageView!
    @IBOutlet weak var imgVegetales: UIImageView!
    @IBOutlet weak var imgCarnes: UIImageView!
    @IBOutlet weak var imgFrutas: UIImageView!
    @IBOutlet weak var imgCereales: UIImageView!
    @IBOutlet weak var imgGrasas: UIImageView!
    @IBOutlet weak var imgLeche: UIImageView!
    @IBOutlet weak var imgAzucares: UIImageView!
    @IBOutlet weak var imgLeguminosas: UIImageView!
    @IBOutlet weak var bttnAgregar: UIButton!
    var cantidad : Int!
    var agua = 0
    var vegetales = 0
    var carnes = 0
    var frutas = 0
    var cereales = 0
    var grasas = 0
    var leche = 0
    var azucares = 0
    var leguminosas = 0
    @IBOutlet weak var lblCantAgua: UILabel!
    @IBOutlet weak var lblCantVegetales: UILabel!
    @IBOutlet weak var lblCantCarnes: UILabel!
    @IBOutlet weak var lblCantFrutas: UILabel!
    @IBOutlet weak var lblCantCereales: UILabel!
    @IBOutlet weak var lblCantGrasas: UILabel!
    @IBOutlet weak var lblCantidadLeche: UILabel!
    @IBOutlet weak var lblCantAzucares: UILabel!
    @IBOutlet weak var lblCantLeguminosas: UILabel!
    
    //caso de prueba para mostrar
     var listaDias:[Dia] = [(Dia(dia: "22-05-2020", agua: 8, vegetales: 8, carnes: 1, frutas: 0, cereales: 0, grasas: 0, leche: 0, azucares: 0, leguminosas: 1, aguaP: 8, vegetalesP: 5, carnesP: 1, frutasP: 0, cerealesP: 0, grasasP: 0, lecheP: 0, azucaresP: 0, leguminosasP: 1)), (Dia(dia: "23-05-2020", agua: 8, vegetales: 0, carnes: 1, frutas: 0, cereales: 0, grasas: 0, leche: 0, azucares: 0, leguminosas: 1, aguaP: 8, vegetalesP: 5, carnesP: 1, frutasP: 0, cerealesP: 0, grasasP: 0, lecheP: 0, azucaresP: 0, leguminosasP: 1))]
    
    @IBOutlet weak var vegetalesPie: PieChartView!
    @IBOutlet weak var carnesPie: PieChartView!
    @IBOutlet weak var frutasPie: PieChartView!
    @IBOutlet weak var cerealesPie: PieChartView!
    @IBOutlet weak var grasasPie: PieChartView!
    @IBOutlet weak var lechePie: PieChartView!
    @IBOutlet weak var azucaresPie: PieChartView!
    @IBOutlet weak var leguminosasPie: PieChartView!
    @IBOutlet weak var aguaPie: PieChartView!
    
    
    var vegetalesChartData = [ChartDataEntry]()
    var carnesChartData = [ChartDataEntry]()
    var frutasChartData = [ChartDataEntry]()
    var cerealesChartData = [ChartDataEntry]()
    var grasasChartData = [ChartDataEntry]()
    var lecheChartData = [ChartDataEntry]()
    var azucaresChartData = [ChartDataEntry]()
    var leguminosasChartData = [ChartDataEntry]()
    var aguaChartData = [ChartDataEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // cargar la imagenes a los outlets
        imgAgua.image = UIImage(named: "agua")
        imgLeche.image = UIImage(named: "leche")
        imgCarnes.image = UIImage(named: "carnes")
        imgFrutas.image = UIImage(named: "frutas")
        imgVegetales.image = UIImage(named: "vegetales")
        imgCereales.image = UIImage(named: "cereales")
        imgAzucares.image = UIImage(named: "azucares")
        imgLeguminosas.image = UIImage(named: "leguminosas")
        imgGrasas.image = UIImage(named: "grasas")
        
        //se obtiene lafecha de hoy y se convierte a string
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let currentDateString = formatter.string(from: currentDate)
        
        //carga datos si es el dia de hoy
        for dia in listaDias{
            if(dia.dia == currentDateString){
                agua = dia.agua
                vegetales = dia.vegetales
                carnes = dia.carnes
                frutas = dia.frutas
                cereales = dia.cereales
                grasas = dia.grasas
                leche = dia.leche
                azucares = dia.azucares
                leguminosas = dia.leguminosas
            }
        }
        // en caso de no ser el dia de hoy se cargan 0
        lblCantAgua.text = String(agua)
        lblCantidadLeche.text = String(leche)
        lblCantCarnes.text = String(carnes)
        lblCantFrutas.text = String(frutas)
        lblCantVegetales.text = String(vegetales)
        lblCantCereales.text = String(cereales)
        lblCantAzucares.text = String(azucares)
        lblCantLeguminosas.text = String(leguminosas)
        lblCantGrasas.text = String(grasas)
        
        // codable persistencia
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(guardarDias), name: UIApplication.didEnterBackgroundNotification, object: app)
        
        if FileManager.default.fileExists(atPath: dataFileURL().path){
            obtenerDias()
            print("\(listaDias[listaDias.count - 1].vegetales) vege")
        }
        actualizaDia()
        configuraCharts()
        updateCharts(date: currentDate)
        
        
    }
    
    //Accion del boton de agregar que verifica que haya un plan nutricional guardado en caso de que no manda una alerta, en caso de si da acceso a la siguiente vista para poder agregar datos
    @IBAction func bttnAgregar(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        if let veg = defaults.value(forKey: "Vegetales") as? String{
            performSegue(withIdentifier: "AgregarDatosDia", sender: self)
        }
        else{
            let alert = UIAlertController(title: "ERROR", message: "No hay datos en el Plan Nutricional", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
        
    }
    
    //unwind de agregar para actulizar outlets utilizando los defaults de plan nutricional que tambien verifica si ya existe el dia de hoy o no
    @IBAction func unwindAgregar (unwindSegue: UIStoryboardSegue) {
        lblCantAgua.text = String(agua)
        lblCantidadLeche.text = String(leche)
        lblCantCarnes.text = String(carnes)
        lblCantFrutas.text = String(frutas)
        lblCantVegetales.text = String(vegetales)
        lblCantCereales.text = String(cereales)
        lblCantAzucares.text = String(azucares)
        lblCantLeguminosas.text = String(leguminosas)
        lblCantGrasas.text = String(grasas)
        
        var vegP = 0
        var carP = 0
        var fruP = 0
        var cerP = 0
        var graP = 0
        var lechP = 0
        var azuP = 0
        var legP = 0
        var aguP = 0
        
        
        var flag = false
        
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let currentDateString = formatter.string(from: currentDate)
        
        if(listaDias.count > 0){
            for dia in listaDias{
                if(dia.dia == currentDateString){
                    flag = true
                    dia.vegetales = vegetales
                    dia.agua = agua
                    dia.carnes = carnes
                    dia.frutas = frutas
                    dia.cereales = cereales
                    dia.grasas = grasas
                    dia.leche = leche
                    dia.azucares = azucares
                    dia.leguminosas = leguminosas
                }
            }
            if(!flag){
                let defaults = UserDefaults.standard
                
                if let veg = defaults.value(forKey: "Vegetales") as? String{
                    vegP = Int(veg)!
                }
                if let lech = defaults.value(forKey: "Leche") as? String{
                    lechP = Int(lech)!
                }
                if let car = defaults.value(forKey: "Carnes") as? String{
                    carP = Int(car)!
                }
                if let azu = defaults.value(forKey: "Azucares") as? String{
                    azuP = Int(azu)!
                }
                if let cer = defaults.value(forKey: "Cereales") as? String{
                    cerP = Int(cer)!
                }
                if let leg = defaults.value(forKey: "Leguminosas") as? String{
                    legP = Int(leg)!
                }
                if let fru = defaults.value(forKey: "Frutas") as? String{
                    fruP = Int(fru)!
                }
                if let gra = defaults.value(forKey: "Grasas") as? String{
                    graP = Int(gra)!
                }
                if let agu = defaults.value(forKey: "Agua") as? String{
                    aguP = Int(agu)!
                }
                //se crea un nuevo dia en caso de que no hay un dia actual
                let newDia = Dia(dia: currentDateString, agua: agua, vegetales: vegetales, carnes: carnes, frutas: frutas, cereales: cereales, grasas: grasas, leche: leche, azucares: azucares, leguminosas: leguminosas, aguaP: aguP, vegetalesP: vegP, carnesP: carP, frutasP: fruP, cerealesP: cerP, grasasP: graP, lecheP: lechP, azucaresP: azuP, leguminosasP: legP)
                listaDias.append(newDia)
                print("\(listaDias)")
            }
        }
        
        
        
        
        updateCharts(date: currentDate)
        
    }
    
    //Actualiza los datos y outlets para el dia de hoy
    func actualizaDia(){
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let currentDateString = formatter.string(from: currentDate)
        if(listaDias.count > 0){
            
            if(listaDias[listaDias.count - 1].dia == currentDateString) {
                agua = listaDias[listaDias.count - 1].agua
                vegetales = listaDias[listaDias.count - 1].vegetales
                carnes = listaDias[listaDias.count - 1].carnes
                frutas = listaDias[listaDias.count - 1].frutas
                cereales = listaDias[listaDias.count - 1].cereales
                grasas = listaDias[listaDias.count - 1].grasas
                leche = listaDias[listaDias.count - 1].leche
                azucares = listaDias[listaDias.count - 1].azucares
                leguminosas = listaDias[listaDias.count - 1].leguminosas
                print("\(vegetales)")
            }
            
        }
        //Carga los datos para las cantidades
        lblCantAgua.text = String(agua)
        lblCantidadLeche.text = String(leche)
        lblCantCarnes.text = String(carnes)
        lblCantFrutas.text = String(frutas)
        lblCantVegetales.text = String(vegetales)
        lblCantCereales.text = String(cereales)
        lblCantAzucares.text = String(azucares)
        lblCantLeguminosas.text = String(leguminosas)
        lblCantGrasas.text = String(grasas)
    }
    
    //Se configuran las piecharts para que tengan el estilo deseado
    func configuraCharts(){
        vegetalesPie.delegate = self
        vegetalesPie.legend.enabled = false
        vegetalesPie.holeRadiusPercent = 0.7
        vegetalesPie.transparentCircleRadiusPercent = 0
        vegetalesPie.chartDescription?.enabled = false
        vegetalesPie.minOffset = 0
        
        carnesPie.delegate = self
        carnesPie.legend.enabled = false
        carnesPie.holeRadiusPercent = 0.7
        carnesPie.transparentCircleRadiusPercent = 0
        carnesPie.chartDescription?.enabled = false
        carnesPie.minOffset = 0
        
        frutasPie.delegate = self
        frutasPie.legend.enabled = false
        frutasPie.holeRadiusPercent = 0.7
        frutasPie.transparentCircleRadiusPercent = 0
        frutasPie.chartDescription?.enabled = false
        frutasPie.minOffset = 0
        
        cerealesPie.delegate = self
        cerealesPie.legend.enabled = false
        cerealesPie.holeRadiusPercent = 0.7
        cerealesPie.transparentCircleRadiusPercent = 0
        cerealesPie.chartDescription?.enabled = false
        cerealesPie.minOffset = 0
        
        grasasPie.delegate = self
        grasasPie.legend.enabled = false
        grasasPie.holeRadiusPercent = 0.7
        grasasPie.transparentCircleRadiusPercent = 0
        grasasPie.chartDescription?.enabled = false
        grasasPie.minOffset = 0
        
        lechePie.delegate = self
        lechePie.legend.enabled = false
        lechePie.holeRadiusPercent = 0.7
        lechePie.transparentCircleRadiusPercent = 0
        lechePie.chartDescription?.enabled = false
        lechePie.minOffset = 0
        
        azucaresPie.delegate = self
        azucaresPie.legend.enabled = false
        azucaresPie.holeRadiusPercent = 0.7
        azucaresPie.transparentCircleRadiusPercent = 0
        azucaresPie.chartDescription?.enabled = false
        azucaresPie.minOffset = 0
        
        leguminosasPie.delegate = self
        leguminosasPie.legend.enabled = false
        leguminosasPie.holeRadiusPercent = 0.7
        leguminosasPie.transparentCircleRadiusPercent = 0
        leguminosasPie.chartDescription?.enabled = false
        leguminosasPie.minOffset = 0
        
        aguaPie.delegate = self
        aguaPie.legend.enabled = false
        aguaPie.holeRadiusPercent = 0.7
        aguaPie.transparentCircleRadiusPercent = 0
        aguaPie.chartDescription?.enabled = false
        aguaPie.minOffset = 0
        
        
    }
    
    //Manda a llamar los updates de las graficas
    //Las funciones que se llaman se actualizan por medio del uso de swift chart pods tomdando los datos de los acumulados y el plan nutricional en donde tambien compara si se paso de lo planeado
    func updateCharts(date: Date){
        vegetalesPieUpdate(date: date)
        carnesPieUpdate(date: date)
        frutasPieUpdate(date: date)
        cerealesPieUpdate(date: date)
        grasasPieUpdate(date: date)
        lechePieUpdate(date: date)
        azucaresPieUpdate(date: date)
        leguminosasPieUpdate(date: date)
        aguaPieUpdate(date: date)
    }
    
    func vegetalesPieUpdate(date: Date){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateSelected = formatter.string(from: date)
        vegetalesPie.isHidden = true
        var color = [UIColor(red: 137/255, green: 204/255, blue: 118/255, alpha: 1), UIColor.gray.withAlphaComponent(0)]
        
        for dia in listaDias{
            if dia.dia == dateSelected{
                var auxiliarComidos = dia.vegetales
                if auxiliarComidos > dia.vegetalesP{
                    auxiliarComidos = dia.vegetalesP
                    color = [UIColor.red, UIColor.gray]
                    
                }
                var entryData: [ChartDataEntry]!
                entryData = []
                if listaDias.count == 0{
                    entryData = [PieChartDataEntry(value: 0), PieChartDataEntry(value: 1)]
                }else{
                    
                    entryData = [PieChartDataEntry(value: Double(dia.vegetales)), PieChartDataEntry(value: Double(dia.vegetalesP - auxiliarComidos))]
                }
                vegetalesPie.isHidden = false
                let set = PieChartDataSet(entries: entryData)
                let data = PieChartData(dataSet: set)
                set.colors = color as! [NSUIColor]
                set.selectionShift = 0
                set.drawValuesEnabled = false
                vegetalesPie.data = data
                vegetalesPie.animate(xAxisDuration: 0, yAxisDuration: 1)
            }
        }
        
    }
    
    func carnesPieUpdate(date: Date){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateSelected = formatter.string(from: date)
        carnesPie.isHidden = true
        var color = [UIColor(red: 169/255, green: 85/255, blue: 178/255, alpha: 1), UIColor.gray.withAlphaComponent(0)]
        
        for dia in listaDias{
            if dia.dia == dateSelected{
                var auxiliarComidos = dia.carnes
                if auxiliarComidos > dia.carnesP{
                    auxiliarComidos = dia.carnesP
                    color = [UIColor.red, UIColor.gray]
                    
                }
                var entryData: [ChartDataEntry]!
                entryData = []
                if listaDias.count == 0{
                    entryData = [PieChartDataEntry(value: 0), PieChartDataEntry(value: 1)]
                }else{
                    
                    entryData = [PieChartDataEntry(value: Double(dia.carnes)), PieChartDataEntry(value: Double(dia.carnesP - auxiliarComidos))]
                }
                
                carnesPie.isHidden = false
                let set = PieChartDataSet(entries: entryData)
                let data = PieChartData(dataSet: set)
                set.colors = color as! [NSUIColor]
                set.selectionShift = 0
                set.drawValuesEnabled = false
                carnesPie.data = data
                carnesPie.animate(xAxisDuration: 0, yAxisDuration: 1)
            }
        }
    }
    
    func frutasPieUpdate(date: Date){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateSelected = formatter.string(from: date)
        frutasPie.isHidden = true
        var color = [UIColor(red: 201/255, green: 67/255, blue: 83/255, alpha: 1), UIColor.gray.withAlphaComponent(0)]
        
        for dia in listaDias{
            if dia.dia == dateSelected{
                var auxiliarComidos = dia.frutas
                if auxiliarComidos > dia.frutasP{
                    auxiliarComidos = dia.frutasP
                    color = [UIColor.red, UIColor.gray]
                    
                }
                var entryData: [ChartDataEntry]!
                entryData = []
                if listaDias.count == 0{
                    entryData = [PieChartDataEntry(value: 0), PieChartDataEntry(value: 1)]
                }else{
                    
                    entryData = [PieChartDataEntry(value: Double(dia.frutas)), PieChartDataEntry(value: Double(dia.frutasP - auxiliarComidos))]
                }
                
                frutasPie.isHidden = false
                let set = PieChartDataSet(entries: entryData)
                let data = PieChartData(dataSet: set)
                set.colors = color as! [NSUIColor]
                set.selectionShift = 0
                set.drawValuesEnabled = false
                frutasPie.data = data
                frutasPie.animate(xAxisDuration: 0, yAxisDuration: 1)
            }
        }
    }
    
    func cerealesPieUpdate(date: Date){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateSelected = formatter.string(from: date)
        cerealesPie.isHidden = true
        var color = [UIColor(red: 255/255, green: 210/255, blue: 76/255, alpha: 1), UIColor.gray.withAlphaComponent(0)]
        
        for dia in listaDias{
            if dia.dia == dateSelected{
                var auxiliarComidos = dia.cereales
                if auxiliarComidos > dia.cerealesP{
                    auxiliarComidos = dia.cerealesP
                    color = [UIColor.red, UIColor.gray]
                    
                }

                var entryData: [ChartDataEntry]!
                entryData = []
                if listaDias.count == 0{
                    entryData = [PieChartDataEntry(value: 0), PieChartDataEntry(value: 1)]
                }else{
                    
                    entryData = [PieChartDataEntry(value: Double(dia.cereales)), PieChartDataEntry(value: Double(dia.cerealesP - auxiliarComidos))]
                }
                
                cerealesPie.isHidden = false
                let set = PieChartDataSet(entries: entryData)
                let data = PieChartData(dataSet: set)
                set.colors = color as! [NSUIColor]
                set.selectionShift = 0
                set.drawValuesEnabled = false
                cerealesPie.data = data
                cerealesPie.animate(xAxisDuration: 0, yAxisDuration: 1)
            }
        }
    }
    
    func grasasPieUpdate(date: Date){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateSelected = formatter.string(from: date)
        grasasPie.isHidden = true
        var color = [UIColor(red: 194/255, green: 142/255, blue: 94/255, alpha: 1), UIColor.gray.withAlphaComponent(0)]
        
        for dia in listaDias{
            if dia.dia == dateSelected{
                var auxiliarComidos = dia.grasas
                if auxiliarComidos > dia.grasasP{
                    auxiliarComidos = dia.grasasP
                    color = [UIColor.red, UIColor.gray]
                    
                }
                var entryData: [ChartDataEntry]!
                entryData = []
                if listaDias.count == 0{
                    entryData = [PieChartDataEntry(value: 0), PieChartDataEntry(value: 1)]
                }else{
                    
                    entryData = [PieChartDataEntry(value: Double(dia.grasas)), PieChartDataEntry(value: Double(dia.grasasP - auxiliarComidos))]
                }
                
                grasasPie.isHidden = false
                let set = PieChartDataSet(entries: entryData)
                let data = PieChartData(dataSet: set)
                set.colors = color as! [NSUIColor]
                set.selectionShift = 0
                set.drawValuesEnabled = false
                grasasPie.data = data
                grasasPie.animate(xAxisDuration: 0, yAxisDuration: 1)
            }
        }
    }

    func lechePieUpdate(date: Date){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateSelected = formatter.string(from: date)
        lechePie.isHidden = true
        var color = [UIColor(red: 255/255, green: 214/255, blue: 176/255, alpha: 1), UIColor.gray.withAlphaComponent(0)]
        
        for dia in listaDias{
            if dia.dia == dateSelected{
                var auxiliarComidos = dia.leche
                if auxiliarComidos > dia.lecheP{
                    auxiliarComidos = dia.lecheP
                    color = [UIColor.red, UIColor.gray]
                    
                }
                var entryData: [ChartDataEntry]!
                entryData = []
                if listaDias.count == 0{
                    entryData = [PieChartDataEntry(value: 0), PieChartDataEntry(value: 1)]
                }else{
                    
                    entryData = [PieChartDataEntry(value: Double(dia.leche)), PieChartDataEntry(value: Double(dia.lecheP - auxiliarComidos))]
                }
                
                lechePie.isHidden = false
                let set = PieChartDataSet(entries: entryData)
                let data = PieChartData(dataSet: set)
                set.colors = color as! [NSUIColor]
                set.selectionShift = 0
                set.drawValuesEnabled = false
                lechePie.data = data
                lechePie.animate(xAxisDuration: 0, yAxisDuration: 1)
            }
        }
    }
    
    func azucaresPieUpdate(date: Date){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateSelected = formatter.string(from: date)
        azucaresPie.isHidden = true
        var color = [UIColor(red: 254/255, green: 159/255, blue: 200/255, alpha: 1), UIColor.gray.withAlphaComponent(0)]
        
        for dia in listaDias{
            if dia.dia == dateSelected{
                var auxiliarComidos = dia.azucares
                if auxiliarComidos > dia.azucaresP{
                    auxiliarComidos = dia.azucaresP
                    color = [UIColor.red, UIColor.gray]
                    
                }
                var entryData: [ChartDataEntry]!
                entryData = []
                if listaDias.count == 0{
                    entryData = [PieChartDataEntry(value: 0), PieChartDataEntry(value: 1)]
                }else{
                    
                    entryData = [PieChartDataEntry(value: Double(dia.azucares)), PieChartDataEntry(value: Double(dia.azucaresP - auxiliarComidos))]
                }
                
                azucaresPie.isHidden = false
                let set = PieChartDataSet(entries: entryData)
                let data = PieChartData(dataSet: set)
                set.colors = color as! [NSUIColor]
                set.selectionShift = 0
                set.drawValuesEnabled = false
                azucaresPie.data = data
                azucaresPie.animate(xAxisDuration: 0, yAxisDuration: 1)
            }
        }
    }
    
    func leguminosasPieUpdate(date: Date){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateSelected = formatter.string(from: date)
        leguminosasPie.isHidden = true
        var color = [UIColor(red: 255/255, green: 130/255, blue: 45/255, alpha: 1), UIColor.gray.withAlphaComponent(0)]
        
        for dia in listaDias{
            if dia.dia == dateSelected{
                var auxiliarComidos = dia.leguminosas
                if auxiliarComidos > dia.leguminosasP{
                    auxiliarComidos = dia.leguminosasP
                    color = [UIColor.red, UIColor.gray]
                    
                }
                var entryData: [ChartDataEntry]!
                entryData = []
                if listaDias.count == 0{
                    entryData = [PieChartDataEntry(value: 0), PieChartDataEntry(value: 1)]
                }else{
                    
                    entryData = [PieChartDataEntry(value: Double(dia.leguminosas)), PieChartDataEntry(value: Double(dia.leguminosasP - auxiliarComidos))]
                }
                
                leguminosasPie.isHidden = false
                let set = PieChartDataSet(entries: entryData)
                let data = PieChartData(dataSet: set)
                set.colors = color as! [NSUIColor]
                set.selectionShift = 0
                set.drawValuesEnabled = false
                leguminosasPie.data = data
                leguminosasPie.animate(xAxisDuration: 0, yAxisDuration: 1)
            }
        }
    }
    
    func aguaPieUpdate(date: Date){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateSelected = formatter.string(from: date)
        aguaPie.isHidden = true
        var color = [UIColor(red: 69/255, green: 179/255, blue: 215/255, alpha: 1), UIColor.gray.withAlphaComponent(0)]
        
        for dia in listaDias{
            if dia.dia == dateSelected{
                var auxiliarComidos = dia.agua
                if auxiliarComidos > dia.aguaP{
                    auxiliarComidos = dia.aguaP
                    
                }
                var entryData: [ChartDataEntry]!
                entryData = []
                if listaDias.count == 0{
                    entryData = [PieChartDataEntry(value: 0), PieChartDataEntry(value: 1)]
                }else{
                    
                    entryData = [PieChartDataEntry(value: Double(dia.agua)), PieChartDataEntry(value: Double(dia.aguaP - auxiliarComidos))]
                }
                
                aguaPie.isHidden = false
                let set = PieChartDataSet(entries: entryData)
                let data = PieChartData(dataSet: set)
                set.colors = color as! [NSUIColor]
                set.selectionShift = 0
                set.drawValuesEnabled = false
                aguaPie.data = data
                aguaPie.animate(xAxisDuration: 0, yAxisDuration: 1)
            }
        }
        
    }
    
    
    //Persistencia codable
    func dataFileURL() -> URL {
        let url = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let pathArchivo = url.appendingPathComponent("Dias.plist")
        return pathArchivo
    }
    
    @IBAction func guardarDias(){
        
        do{
            let data = try PropertyListEncoder().encode(listaDias)
            try data.write(to: dataFileURL())
        }
        catch{
            print("Error Guardar")
        }
    }
    
    func obtenerDias(){
        listaDias.removeAll()
        
        do{
            let data = try Data.init(contentsOf: dataFileURL())
            listaDias = try PropertyListDecoder().decode([Dia].self, from: data)
        }
        catch{
            print("Error al cargar los datos del archivo")
        }
        //reloads de los tablas
        
    }
    
    
    //Al seleccionar el menu se guardan los datos
    @IBAction func menu(_ sender: UIButton) {
        guardarDias()
        print("\(listaDias.count)")
    }
    
    

}


