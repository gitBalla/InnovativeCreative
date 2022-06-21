import SwiftUI

struct RecycleView: View {
    var body: some View {
        NavigationView {
            VStack{
                Rectangle()
                  .strokeBorder()
                  .foregroundColor(.black)
                HStack{
                  Text("Scan")
                  Image(systemName: "camera.viewfinder")
                }
              
              .font(.largeTitle)
              .foregroundColor(.blue)
            }
            .padding()
            .navigationTitle("Recycle")
        }
        
        
    }
}

struct RecycleView_Previews: PreviewProvider {
    static var previews: some View {
        RecycleView()
    }
}
