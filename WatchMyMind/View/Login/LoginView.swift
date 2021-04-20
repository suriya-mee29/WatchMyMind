//
//  TextFieldView.swift
//  WatchMyMind
//
//  Created by Suriya on 28/1/2564 BE.
//

import SwiftUI

struct LoginView: View {
    // MARK: - PROPERTIES
    @State private var username : String = ""
    @State private var password : String = ""
    @ObservedObject var user : User = User()
    @Binding var isAuthen : Bool
    @Binding var dt : UserModel?
    @State var isLoading : Bool = false
    @State var showAlert : Bool = false
    @State var alertMessage : String = ""
    

    // MARK: - FUNCTION
    private func validate (usename : String , password : String , completion : @escaping (Bool,String)->Void){

        if usename == ""{
            completion(false,"username are empty")
            return
        }
        if password == "" {
            completion(false,"password are empty")
            return
        }
        completion(true ,"valide username and password")
        return

        
        
        
    }
    // MARK: - BODY
    var body: some View {
        
            VStack {
                Text("watch my mind".uppercased())
                    .font(.title)
                    .fontWeight(.black)
                    .foregroundColor(Color("wmm"))
                Image("watchmymind")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 220, alignment: .center)
                    .padding(.bottom,45)
                
               
                VStack {
                    //USERNAME
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                        Image(systemName: "person")
                            .font(.system(size: 24))
                            .foregroundColor(Color.white)
                            .frame(width: 60, height: 60)
                            .background(Color("wmm"))
                            .clipShape(Circle())
                        
                        TextField(L10n.Placeholder.userName.uppercased(), text: $username)
                            .padding(.horizontal)
                            .padding(.leading,65)
                            .frame(height:60)
                            .background(Color("background").opacity(0.2))
                            .clipShape(Capsule())
                            .onTapGesture {
                                
                                hideKeyboard()
                            }
                        
                        
                    })  //: ZSTACK
                    .padding(.horizontal)
                    
                    //PASSWORD
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                        Image(systemName: "lock")
                            .font(.system(size: 24))
                            .foregroundColor(Color.white)
                            .frame(width: 60, height: 60)
                            .background(Color("wmm"))
                            .clipShape(Circle())
                        
                        SecureField( L10n.Placeholder.palssword.uppercased(), text: $password)
                            .padding(.horizontal)
                            .padding(.leading,65)
                            .frame(height:60)
                            .background(Color("background").opacity(0.2))
                            .clipShape(Capsule())
                            .onTapGesture {
                                hideKeyboard()
                            }
                        
                        
                    })  //: ZSTACK
                    .padding(.horizontal)
                    
                    Button(action: {
                        
                        self.validate(usename: self.username, password: self.password){ (valide,mgs) in
                            print(valide)
                            print(mgs)
                            
                          
                            if valide{
                                self.isLoading = true
                                user.singIn(username: self.username, password: self.password){ (userdata ,mgs) in
                                    if mgs == "success"{
                                        DispatchQueue.main.async {
                                            user.displayData()
                                            if let data = userdata {
                                                self.dt = data
                                                self.isAuthen = true
                                            }
                                            
                                        }
                                       
                                        print(self.isLoading)
                                   
                                    }else{
                                        self.showAlert = true
                                        self.alertMessage = mgs
                                    }
                                    
                                }
                            }else{
                                self.showAlert = true
                                self.alertMessage = mgs
                            }
                        }
                        
                        
                    }, label: {
                        HStack {
                            Text(L10n.Placeholder.login.uppercased())
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                //.frame(width: UIScreen.main.bounds.width - 30)
                                
                            if self.isLoading{
                             ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(1)
                            }
                            
                        }
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color("wmm"))
                        .clipShape(Capsule())
                        
                    })
                    .padding(.top , 20)
                   
                    
                    
                }
                
                
                
                
                
            } .alert(isPresented: $showAlert , content: {
                Alert(title: Text("login wrong".uppercased()), message: Text("\(self.alertMessage)"), dismissButton: .default(Text("OK!")))
                        }
            )
            
           
      
        
    }
}
    // MARK: -PREVIEW
struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isAuthen: .constant(false), dt: .constant(UserModel(timestamp: 2, status: true, message: "ok", data: DataUserModel(type: "std", statusid: "12", statusname: "ok", userName: "name", prefixname: "Mr.", displayname_th: "th", displayname_en: "en", email: "mail", department: "str", faculty: "str"))))
            .preferredColorScheme(.light)
        
    }
}
