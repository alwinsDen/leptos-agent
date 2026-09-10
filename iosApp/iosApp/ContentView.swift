import SharedLogic
import SwiftUI

struct ContentView: View {
    @State private var showContent = false
    @State private var username: String = ""
    var body: some View {
        VStack {
//            if showContent {
//                VStack(spacing: 16) {
//                    Image(systemName: "swift")
//                        .font(.system(size: 200))
//                        .foregroundColor(.accentColor)
//                    Text("SwiftUI: \(Greeting().greet())")
//                }
//                .transition(.move(edge: .top).combined(with: .opacity))
//            }
            ScrollView(){
                //
            }
            VStack {
                TextField("Ask Leptos agent...", text: $username, axis: .vertical)
                    .lineLimit(6)
                    .multilineTextAlignment(.leading)
                Spacer().frame(height: 20)
                HStack {
                    Menu {
                        Button {
                            print("C:camera-lock")
                        } label: { Label("Camera", systemImage: "camera") }
                        Button { } label: { Label("Photos", systemImage: "photo") }
                        Button { } label: { Label("Files", systemImage: "paperclip") }
                        Button { } label: { Label("Plugins", systemImage: "at") }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .frame(width: 34, height: 34)
                            .foregroundStyle(.white.opacity(0.8))
                    }.labelStyle(.iconOnly)
                    Spacer()
                    Button{
                        //
                    } label: {
                        Image(systemName: "music.microphone.circle.fill")
                            .font(.largeTitle)
                            .frame(width: 34, height: 34)
                            .foregroundStyle(.white.opacity(0.8))
                    }
                    .labelStyle(.iconOnly)
                    Spacer().frame(width: 20)
                    Button{
                        //
                    } label: {
                        Image(systemName: "paperplane.circle.fill")
                            .font(.largeTitle)
                            .frame(width: 34, height: 34)
                            .foregroundStyle(.white.opacity(0.8))
                    }
                    .labelStyle(.iconOnly)
                }
            }.padding(12)
            .background(.ultraThinMaterial, in: .rect(cornerRadius: 14))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
    }
}
