//pantalla en donde se muestra un calendario por medio de FSCalendar y Charts para mostrar las graficas pie

import UIKit
import FSCalendar
import Charts

class ComoVoyViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, ChartViewDelegate {

    @IBOutlet var calendar: FSCalendar!
    
    var listaDias: [Dia]!
    
    var datos: [String]!
    //Outlets
    @IBOutlet weak var imgAgua: UIImageView!
    @IBOutlet weak var imgVegetales: UIImageView!
    @IBOutlet weak var imgCarnes: UIImageView!
    @IBOutlet weak var imgFrutas: UIImageView!
    @IBOutlet weak var imgCereales: UIImageView!
    @IBOutlet weak var imgGrasas: UIImageView!
    @IBOutlet weak var imgLeche: UIImageView!
    @IBOutlet weak var imgAzucares: UIImageView!
    @IBOutlet weak var imgLeguminosas: UIImageView!
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

        // Do any additional setup after loading the view.
        //Se carga el calendario y se modifca su scope a que nada mas se vea por semanas
        calendar.dataSource = self
        calendar.delegate = self
        calendar.scope = FSCalendarScope.week
        //Se cargan las imagenes a los outlets
        imgAgua.image = UIImage(named: "agua")
        imgLeche.image = UIImage(named: "leche")
        imgCarnes.image = UIImage(named: "carnes")
        imgFrutas.image = UIImage(named: "frutas")
        imgVegetales.image = UIImage(named: "vegetales")
        imgCereales.image = UIImage(named: "cereales")
        imgAzucares.image = UIImage(named: "azucares")
        imgLeguminosas.image = UIImage(named: "leguminosas")
        imgGrasas.image = UIImage(named: "grasas")
        
        //Lbls defaulys en caso de que no haya dia
        lblCantAgua.text = String(agua)
        lblCantidadLeche.text = String(leche)
        lblCantCarnes.text = String(carnes)
        lblCantFrutas.text = String(frutas)
        lblCantVegetales.text = String(vegetales)
        lblCantCereales.text = String(cereales)
        lblCantAzucares.text = String(azucares)
        lblCantLeguminosas.text = String(leguminosas)
        lblCantGrasas.text = String(grasas)
        
        //persistencia
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(guardarDias), name: UIApplication.didEnterBackgroundNotification, object: app)
        
        listaDias = []
        
        if FileManager.default.fileExists(atPath: dataFileURL().path){
            print("Obteniendo Dias")
            obtenerDias()
            print("\(listaDias.count)")
        }
        
        datos = []
        
        if (listaDias.count != 0){
            for dia in listaDias{
                print("\(dia.dia) MAX")
                datos.append(dia.dia)
                
            }
        }
        
        //Al abrir la pantalla muestra el dia de hoy
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let currentDateString = formatter.string(from: currentDate)
        
        if listaDias.count != 0 {
            if listaDias[listaDias.count - 1].dia == currentDateString{
                lblCantAgua.text = String(listaDias[listaDias.count - 1].agua)
                lblCantidadLeche.text = String(listaDias[listaDias.count - 1].leche)
                lblCantCarnes.text = String(listaDias[listaDias.count - 1].carnes)
                lblCantFrutas.text = String(listaDias[listaDias.count - 1].frutas)
                lblCantVegetales.text = String(listaDias[listaDias.count - 1].vegetales)
                lblCantCereales.text = String(listaDias[listaDias.count - 1].cereales)
                lblCantAzucares.text = String(listaDias[listaDias.count - 1].azucares)
                lblCantLeguminosas.text = String(listaDias[listaDias.count - 1].leguminosas)
                lblCantGrasas.text = String(listaDias[listaDias.count - 1].grasas)
            }
        }
        
        configuraCharts()
        updateCharts(date: currentDate)
        
        
    }
    
    //Funcion que se encarga de actualzar las graficas pie
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
    
    //Se configuran los Pies para que muestren el diseño
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
    
    //Funciones Update en donde se encargan de actulizar las graficas recibiendo el dia de hoy que es al principio y despues al seleccionar se manda ese
    //Se encarda de mostrar los acumulados comparando con los planeados usando Charts, en donde tambien se ve si se paso de los planeados
    
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
        var color = [UIColor(red: 255/255, green: 130/255, blue: 45/255, alpha: 1), UIColor.gray.withAlphaComponent(0)]
        
        for dia in listaDias{
            if dia.dia == dateSelected{
                var auxiliarComidos = dia.agua
                if auxiliarComidos > dia.aguaP{
                    auxiliarComidos = dia.aguaP
                    color = [UIColor.red, UIColor.gray]
                    
                }
                var entryData: [ChartDataEntry]!
                entryData = []
                if listaDias.count == 0{
                    entryData = [PieChartDataEntry(value: 0), PieChartDataEntry(value: 1)]
                }else{
                    
                    entryData = [PieChartDataEntry(value: Double(dia.agua)), PieChartDataEntry(value: Double(dia.aguaP - auxiliarComidos))]
                }
                
                aguaPie.isHidden = false
                aguaPie.noDataText = ""
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
    
    
    //Funcion de FScalendar en donde al seleccionar una fecha del calendario actualiza los labels  y llama la funcion updateCharts con la fecha seleccionada
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        var flag: Bool = false
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let dateSelected = formatter.string(from: date)
        //let date2 = formatter.date(from: string)
        
        
        for dia in listaDias{
            if(dia.dia == dateSelected){
                lblCantAgua.text = String(dia.agua)
                lblCantidadLeche.text = String(dia.leche)
                lblCantCarnes.text = String(dia.carnes)
                lblCantFrutas.text = String(dia.frutas)
                lblCantVegetales.text = String(dia.vegetales)
                lblCantCereales.text = String(dia.cereales)
                lblCantAzucares.text = String(dia.azucares)
                lblCantLeguminosas.text = String(dia.leguminosas)
                lblCantGrasas.text = String(dia.grasas)
                flag = true
            }
            updateCharts(date: date)
        }
        
        if !flag{
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
    }
    
    //Fscalendar que muestra los dias que se encuentran en la lista de los Dias registrados
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        let dateString = formatter.string(from: date)
        
        if datos.contains(dateString){
            return 1
        }
        return 0;
    }
    
    //Se actuzaliza el tamaño del evento para que sea mas grande
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        let eventScaleFactor: CGFloat = 4
        cell.eventIndicator.transform = CGAffineTransform(scaleX: eventScaleFactor, y: eventScaleFactor)
    }
    
    //Se compara que si el usuario cumplio con la planeado muestra el evento verde, si no rojo
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        var flag: Bool = false
        
        let dateString = formatter.string(from: date)
        
        for dia in listaDias{
            if dia.dia == dateString{
                if (dia.agua == dia.aguaP && dia.vegetales == dia.vegetalesP && dia.carnes == dia.carnesP && dia.frutas == dia.frutasP && dia.cereales == dia.cerealesP && dia.grasas == dia.grasasP && dia.leche == dia.lecheP && dia.azucares == dia.azucaresP && dia.leguminosas == dia.leguminosasP){
                    flag = true
                }
            }
        }
        if flag{
            return [UIColor.green]
        }else{
            return [UIColor.red]
        }
        
        
    }
    
    @IBAction func quitaView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //Persistencia
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
    
    

}
