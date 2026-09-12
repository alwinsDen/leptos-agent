import SwiftUI

struct SharedIcon: View {
    let systemName: String
    let size: CGFloat = 34
    var body: some View {
        Image(systemName: systemName)
            .font(.largeTitle)
            .frame(width: size, height: size)
            .foregroundStyle(Color.primary.opacity(0.8))
    }
}

#Preview {
    SharedIcon(systemName: "plus.circle.fill")
}
