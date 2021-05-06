//
//  HeaderView.swift
//  WatchMyMind
//
//  Created by Suriya on 31/1/2564 BE.
//

import SwiftUI
import HealthKit

struct HeaderView: View {
    // MARK: - PROPERTIES
    var healthStore : HealthStore? = HealthStore()
    @State private var isAnimated : Bool = false
    
    @State private var moveing : Int = 0
    @State private var aSleep : String = "No data"
    @State private var inBad : String = "No data"
    @State private var standing : String = "1.0"
    @State private var steping : Int = 100
    
    @State private var name : String = ""
    
    @Binding var observed : [String]
    
    @Binding var user : User
    @Binding var dt : UserModel?
    
    @State private var isSleep = false
    @State private var isMoving = false
    @State private var isStanding = false
    @State private var isStepping = false
    
    let currentusername: String
    
    
    let locale = Locale.current
    func update1122(  str : String){
       
    }
    func upload() {
        var activities = ActivitiesListViewModel(username: self.currentusername)
        activities.saveObservedIndicator(aSleep: self.aSleep, inBed: self.inBad, moving: self.moveing, standing: self.standing, stepping: self.steping) { success, msg in
            
        }
       
    }
    
    func fetch() {
        for indicator in self.observed{
            if indicator == "sleeping"{
                self.isSleep = true
            }
            if indicator == "stepping" {
                self.isStepping = true
                
            }
            if indicator == "burning" {
                self.isMoving = true
                
            }
            if indicator == "standing" {
                self.isStanding = true
                
            }
        }
    }

    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack (alignment: .leading){
                Text("watch my mind".uppercased())
                    .font(.title3)
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5 )
                    .padding(.top, UIScreen.main.bounds.height * 0.05)
                    .opacity(isAnimated ? 1 : 0)
                    .offset(x : 0 , y : isAnimated ? 0 : -25)
                    .onAppear(perform: {
                        withAnimation(Animation.easeIn(duration: 0.5)){
                            isAnimated = true
                        }
                    })
                    .onDisappear(perform: {
                        isAnimated = false
                    })
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.28)

               
               // dt?.data.displayname_en ?? name
                Text(locale.languageCode ?? "en" == "th" ? "\(dt?.data.displayname_th ?? name)" : "\(dt?.data.displayname_en ?? name)")
                                .font(.system(size: 20))
                                .font(.title)
                                .fontWeight(.bold)
                                .lineLimit(2)
                                .padding()
                                .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width)
                
                  
               
             
                    
                VStack (alignment: .leading ){
                    if isMoving{
                    HStack{
                        Image(systemName: "flame.fill")
                            .font(.title3)
                            .foregroundColor(Color("move"))
                       
                        
                        Text("\(L10n.Header.movement) \(moveing) \(L10n.Header.kcal)".uppercased())
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color("move"))
                    }
                    .padding(.bottom,1)
                    }
                    if isSleep {
                    //in bed
                    HStack{
                        Image(systemName: "bed.double.fill")
                            .font(.title3)
                            .foregroundColor(Color("sleep"))
                        Text("\(L10n.Header.inbed) \(self.inBad) \(L10n.Header.hr)".uppercased())
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color("sleep"))
                    }
                    .padding(.bottom,1)
                    // a sleep
                    HStack{
                        Image(systemName: "powersleep")
                            .font(.title3)
                            .foregroundColor(Color("sleep"))
                        Text("\(L10n.Header.asleep) \(self.aSleep) \(L10n.Header.hr)".uppercased())
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color("sleep"))
                    }
                    .padding(.bottom,1)
                    }
                    if isStanding {
                    HStack{
                        Image(systemName: "figure.stand")
                            .font(.title3)
                            .foregroundColor(Color("stand"))
                        Text("\(L10n.Header.standing) \(self.standing) \(L10n.Header.hr)".uppercased())
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color("stand"))
                    }
                    .padding(.bottom , 1)
                    }
                    if isStepping {
                    HStack{
                        Image(systemName: "figure.walk")
                            .font(.title3)
                            .foregroundColor(Color("step"))
                        Text("\(L10n.Header.steping) \(self.steping)  \(L10n.Header.steps)".uppercased())
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color("step"))
                    }
                    .padding(.bottom,1)
                    }
                    
                }
                .padding(.bottom,30)
                .padding(.horizontal)
               
            }// VSTACK
            .background(Color("wmm"))
            .clipShape(CustomShape())
            .onChange(of: self.observed, perform: { value in
                fetch()
            })
            .onChange(of: self.moveing, perform: { value in
                self.upload()
            })
            .onChange(of: self.aSleep, perform: { value in
                self.upload()
            })
            .onChange(of: self.inBad, perform: { value in
                self.upload()
            })
            .onChange(of: self.steping, perform: { value in
                self.upload()
            })
            .onChange(of: self.standing, perform: { value in
                self.upload()
            })
            .onAppear(perform: {
                
                print("local--> \(locale.languageCode?.description)")
                let userDefults = UserDefaults.standard
                do {
                    
                    let userData = try userDefults.getObject(forKey: "userData", castTo: UserModel.self)
                    
                    if userData != nil{
                        
                        let strLocale = locale.languageCode ?? "en"
                        if strLocale == "th" {
                        self.name = userData.data.displayname_th
                        }else {
                        self.name = userData.data.displayname_en
                        }
                        
                    }

                } catch {
                    print(error.localizedDescription)
                }
                
                
                
                
                
                if let healthStore = healthStore {
                    healthStore.requestAuthorization { success in
                        //Activity burned
                        healthStore.getDailyMoving { summary in
                            self.moveing = Int(summary?.activeEnergyBurned.doubleValue(for: HKUnit.kilocalorie()) ?? 0)
                            
                        }
 
                        //Sleeping
                        healthStore.getDailySleeping { samples in
                           // let startDate = Calendar.current.startOfDay(for: Date())
                            var asleep_ :TimeInterval = 0
                            var inbed_ :TimeInterval = 0
                            
                            if samples.count > 0{
                                for sample in samples {
                                    if let categorySample = sample as? HKCategorySample{
                                        if categorySample.value == HKCategoryValueSleepAnalysis.inBed.rawValue{
                                            //inBed
                                            inbed_ += categorySample.endDate.timeIntervalSince(categorySample.startDate)
                                          
                                        }else{
                                            //asleep
                                            asleep_ += categorySample.endDate.timeIntervalSince(categorySample.startDate)
                                        }
                                    }else{
                                        asleep_ = 0
                                        inbed_ = 0
                                    }
                                    
                                }
                                
                                //finaly
                                if asleep_ != 0 {
                                    self.aSleep = "\(asleep_.stringFromTimeInterval())"
                                    
                                }else{
                                    self.aSleep = "No data"
                                }
                                if inbed_ != 0 {
                                    self.inBad = "\(inbed_.stringFromTimeInterval())"
                                }else{
                                    self.inBad = "No data"
                                }
                                
                            }else{
                                self.aSleep = "No data"
                                self.inBad = "No data"
                            }
                            
                        }
                        
                        
                        //Standing
                        healthStore.getDailyStanding { standTime in
                            self.standing = standTime.stringFromTimeInterval()
                            
                        }
                        //Steping
                        let startDate  = Calendar.current.date(byAdding: .day,value: -1, to: Date())!
                        
                        healthStore.calculateSteps{ statisticsCollection in
                            
                            statisticsCollection?.enumerateStatistics(from: startDate, to: Date(), with: { (statistic, stop) in
                                let count = statistic.sumQuantity()?.doubleValue(for: .count())
                                self.steping = Int(count ?? 0)
                            })
                            
                            
                        }
                        self.upload()
                        //---------------
                    }
                }
             fetch()
            })
            
        }
        
        
      
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView( observed: .constant([]), user: .constant(User()), dt: .constant(UserModel(timestamp: 2, status: true, message: "ok", data: DataUserModel(type: "std", statusid: "12", statusname: "ok", userName: "name", prefixname: "Mr.", displayname_th: "th", displayname_en: "en", email: "mail", department: "str", faculty: "str"))), currentusername: "6009650026")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
