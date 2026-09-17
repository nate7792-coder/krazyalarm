import SwiftUI

struct NightLightView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var brightness = 0.65
    @State private var warmth = 0.80

    private var lightColor: Color {
        Color(red: 1.0, green: 0.22 + (0.34 * (1 - warmth)), blue: 0.04)
    }

    var body: some View {
        ZStack {
            lightColor.opacity(brightness)
                .ignoresSafeArea()
            RadialGradient(colors: [.white.opacity(0.12), .clear], center: .center, startRadius: 10, endRadius: 460)
                .ignoresSafeArea()

            VStack(spacing: 28) {
                HStack {
                    Label("Night Light", systemImage: "moon.stars.fill")
                        .font(.headline)
                    Spacer()
                    Button("Done") { dismiss() }
                        .buttonStyle(.borderedProminent)
                        .tint(.black.opacity(0.55))
                }

                Spacer()

                Image(systemName: "alarm.waves.left.and.right.fill")
                    .font(.system(size: 76))
                    .symbolRenderingMode(.hierarchical)
                Text("KRAZYALARM")
                    .font(.system(size: 28, weight: .black, design: .rounded))
                    .tracking(5)

                Spacer()

                VStack(spacing: 18) {
                    LabeledContent("Brightness") {
                        Slider(value: $brightness, in: 0.08...1)
                            .frame(maxWidth: 220)
                    }
                    LabeledContent("Warmth") {
                        Slider(value: $warmth, in: 0...1)
                            .frame(maxWidth: 220)
                    }
                }
                .padding(20)
                .background(.black.opacity(0.32), in: RoundedRectangle(cornerRadius: 22))
            }
            .foregroundStyle(.white)
            .padding(24)
        }
        .persistentSystemOverlays(.hidden)
        .statusBarHidden()
    }
}

