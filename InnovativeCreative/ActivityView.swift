import SwiftUI

extension Color {
    public static var outlineRed: Color {
        return Color(decimalRed: 34, green: 0, blue: 3)
    }
    
    public static var darkRed: Color {
        return Color(decimalRed: 221, green: 31, blue: 59)
    }
    
    public static var lightRed: Color {
        return Color(decimalRed: 239, green: 54, blue: 128)
    }
    
    public init(decimalRed red: Double, green: Double, blue: Double) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }
}

struct ActivityRingView: View {
    @Binding var progress: CGFloat
    
    var colors: [Color] = [Color.darkRed, Color.lightRed]
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.outlineRed, lineWidth: 20)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: colors),
                        center: .center,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360)
                    ),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
            )
        }.frame(idealWidth: 300, idealHeight: 300, alignment: .center)
    }
}

struct ActivityView: View {
    @StateObject private var userModel = FetchUserData()
    @State private var totalPoints: CGFloat = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack {
                        HStack {
                            Text("Hi Pranav")
                                .font(.title)
                                .bold()
                            Spacer()
                        }
                        HStack {
                            Text("Ready to make a difference to our planet?")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .italic()
                            Spacer()
                        }
                    }
                }
                Section {

                    VStack {
                        HStack {
                            Text("Activity")
                                .font(.headline)
                                .bold()
                            Spacer()
                        }
                        HStack {
                            Text("Today")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .italic()
                            Spacer()
                        }
                    }
                    HStack {
                        VStack {
                            Text("Materials")
                                .font(.title3)
                            Text("Plastic")
                                .font(.body)
                            Text("1/5 points")
                                .font(.body)
                            Text("Glass")
                                .font(.body)
                            Text("0/3 points")
                                .font(.body)
                            Text("Other")
                                .font(.body)
                            Text("0/3 points")
                                .font(.body)
                        }
                        padding()
                        ZStack {
                            ActivityRingView(progress: $totalPoints)
                                .fixedSize(horizontal: false, vertical: false)
                        }
                    }
                }
                Section {
                    HStack {
                        Text("Recent")
                            .font(.headline)
                            .bold()
                    }
                    VStack {
                        Text("Plastic")
                        Text("Today 4:04PM")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Activity")
        }
        .task {
            await userModel.fetchData()
            totalPoints = CGFloat(userModel.user.dailyData.last?.totalPoints ?? 0) / 30
        }
    }
    
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
