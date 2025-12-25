//
//  TrackView.swift
//  UnivStore_One
//
//  Created by Kngmin Kang on 2023/09/04.
//

import SwiftUI

struct TrackView: View {
    @State private var trackingNumber = ""
    @State private var trackingInfo: String?
    // SweetTracker parameters
    @State private var carrierCode: String = "" // e.g., "04" for CJ대한통운 (예시)
    // 대표 배송사 목록 (코드는 SweetTracker 문서 기준 예시)
    private let carriers: [(name: String, code: String?)] = [
        ("미선택(자동)", nil),
        ("CJ대한통운", "04"),
        ("롯데택배", "08"),
        ("한진택배", "05"),
        ("우체국택배", "01"),
        ("로젠택배", "06"),
        ("CU 편의점택배", "46"),
        ("GS Postbox 택배", "24")
    ]
    @State private var selectedCarrierIndex: Int = 0
    
    private var sweetTrackerKey: String {
        Bundle.main.object(forInfoDictionaryKey: "SweetTrackerAPIKey") as? String ?? ""
    }
    
    func fetchTrackingInfo() {
        // Validate
        let trimmedInvoice = trackingNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedInvoice.isEmpty else {
            self.trackingInfo = "현재 조회가 불가합니다"
            return
        }
        guard !sweetTrackerKey.isEmpty else {
            self.trackingInfo = "현재 조회가 불가합니다"
            return
        }

        // Build URL: http://info.sweettracker.co.kr/api/v1/trackingInfo?t_key=...&t_invoice=...&t_code=...
        var components = URLComponents(string: "http://info.sweettracker.co.kr/api/v1/trackingInfo")!
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "t_key", value: sweetTrackerKey),
            URLQueryItem(name: "t_invoice", value: trimmedInvoice)
        ]
        if !carrierCode.trimmingCharacters(in: .whitespaces).isEmpty {
            queryItems.append(URLQueryItem(name: "t_code", value: carrierCode))
        }
        components.queryItems = queryItems

        guard let url = components.url else {
            self.trackingInfo = "현재 조회가 불가합니다"
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error:", error.localizedDescription)
                DispatchQueue.main.async { self.trackingInfo = "현재 조회가 불가합니다" }
                return
            }

            if let http = response as? HTTPURLResponse {
                print("HTTP status:", http.statusCode)
            }

            guard let data = data else {
                DispatchQueue.main.async { self.trackingInfo = "현재 조회가 불가합니다" }
                return
            }

            // Debug raw response (optional)
            if let raw = String(data: data, encoding: .utf8) {
                print("Raw JSON:", raw)
            }

            do {
                let decoded = try JSONDecoder().decode(SweetTrackingResponse.self, from: data)

                // If API returns an error message, prefer unified message
                if let msg = decoded.msg, !msg.isEmpty {
                    DispatchQueue.main.async { self.trackingInfo = "현재 조회가 불가합니다" }
                    return
                }

                // Build a simple summary string from response
                var lines: [String] = []
                if let itemName = decoded.itemName { lines.append("상품: \(itemName)") }
                if let status = decoded.status { lines.append("상태: \(status)") }
                if let whereNow = decoded.whereNow { lines.append("현재 위치: \(whereNow)") }
                if let kind = decoded.kind { lines.append("진행: \(kind)") }

                if let lastProgress = decoded.trackingDetails?.last {
                    let time = lastProgress.timeString ?? lastProgress.time ?? ""
                    let loc = lastProgress.where ?? ""
                    let kind = lastProgress.kind ?? ""
                    let line = [time, loc, kind].filter { !$0.isEmpty }.joined(separator: " | ")
                    if !line.isEmpty { lines.append("최근: \(line)") }
                }

                let summary = lines.isEmpty ? "조회 결과가 없습니다." : lines.joined(separator: "\n")
                DispatchQueue.main.async { self.trackingInfo = summary }
            } catch {
                print("Decoding error:", error)
                DispatchQueue.main.async { self.trackingInfo = "현재 조회가 불가합니다" }
            }
        }.resume()
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Title
                Text("배송 조회")
                    .font(.system(size: 34, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)

                VStack(spacing: 12) {
                    // Image
                    Image("tv_img")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                        .clipped()
                        .accessibilityLabel("배송 조회 이미지")

                    // Tracking number field
                    TextField("운송장 번호 입력:", text: $trackingNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .submitLabel(.search)
                        .onSubmit { fetchTrackingInfo() }
                    
                    // Carrier picker
                    Picker("택배사", selection: $selectedCarrierIndex) {
                        ForEach(Array(carriers.enumerated()), id: \.offset) { offset, element in
                            Text(element.name).tag(offset)
                        }
                    }
                    .pickerStyle(.menu)
                    .onChange(of: selectedCarrierIndex) { newValue in
                        carrierCode = carriers[newValue].code ?? ""
                    }

                    // Action button
                    Button(action: fetchTrackingInfo) {
                        Text("조회")
                            .font(.system(size: 20, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                    }
                    .buttonStyle(.borderedProminent)

                    // Result / info
                    if let trackingInfo {
                        Text(trackingInfo)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal)
                
                Text("⚠️ 현재 운송장 조회는 테스트중입니다.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
}

struct SweetTrackingResponse: Codable {
    // Common fields from SweetTracker (names may vary; map cautiously)
    let status: String?
    let itemName: String?
    let whereNow: String?
    let kind: String?
    let msg: String? // error message if any
    let trackingDetails: [SweetTrackingDetail]? // progress list (a.k.a. trackingDetails or 'progresses')

    enum CodingKeys: String, CodingKey {
        case status
        case itemName
        case whereNow
        case kind
        case msg
        case trackingDetails
    }
}

struct SweetTrackingDetail: Codable {
    let time: String?
    let timeString: String?
    let `where`: String?
    let kind: String?
}

struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        TrackView()
    }
}
