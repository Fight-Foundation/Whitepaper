---
order: 90
icon: code
---

# FIGHT 토큰 - 기술 개요

## 개요

FIGHT는 솔라나 및 BNB 스마트 체인(BSC)에 배포된 크로스체인 대체 가능 토큰으로, 원활한 크로스체인 전송을 위해 LayerZero V2 프로토콜을 활용합니다. 토큰은 Omnichain Fungible Token(OFT) 표준을 구현하여 체인 간 안전하고 효율적인 브리징을 보장합니다.

---

## 토큰 사양

### 솔라나 (주요 체인)
- **토큰 유형:** SPL 토큰 (네이티브)
- **토큰 민트:** `8f62NyJGo7He5uWeveTA2JJQf4xzf8aqxkmzxRQ3mxfU`
- **총 공급량:** 10,000,000,000 FIGHT (100억)
- **소수점:** 9
- **토큰 표준:** Metaplex 메타데이터가 있는 SPL 토큰

### BNB 스마트 체인 (보조 체인)
- **토큰 유형:** ERC-20 (OFT)
- **계약 주소:** `0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab`
- **공급 모델:** 래핑됨 (네이티브 민팅 없음, 모든 토큰은 솔라나에서 브리지됨)
- **소수점:** 18
- **토큰 표준:** LayerZero OFT V2

---

## 아키텍처

### 크로스체인 브리지 (LayerZero V2)

FIGHT는 신뢰 없는 크로스체인 전송을 위해 LayerZero의 Omnichain Fungible Token(OFT) 프로토콜을 활용합니다:

**솔라나 구성 요소:**
- **OFT 프로그램:** `FXnms2y5FUjzxzEaDEnEF54pYWZLteTdKUwQhDbCAUfL`
- **OFT 스토어:** `8TRG47KgD9KgZaHyKH5CKZRCAhfUAzbqivXV8SZWWhYk`
- **토큰 에스크로:** `6rZoHSARsboMx1vNesfqd7q1DasgxWs5yivrRJvKaSPe`
- **LayerZero 엔드포인트:** `76y77prsiCMvXMjuoZ5VRrhG5qYBrUMYTE5WgHqgjEn6`
- **엔드포인트 ID:** 30168 (솔라나 메인넷)

**BSC 구성 요소:**
- **OFT 계약:** `0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab`
- **LayerZero 엔드포인트:** `0x1a44076050125825900e736c501f859c50fE728c`
- **엔드포인트 ID:** 30102 (BSC 메인넷)

### 브리지 메커니즘

1. **솔라나 → BSC:**
   - 토큰은 솔라나 에스크로 계정에 잠금됩니다
   - LayerZero 메시지가 BSC로 전송됩니다
   - BSC에서 동등한 토큰이 민팅됩니다

2. **BSC → 솔라나:**
   - BSC에서 토큰이 소각됩니다
   - LayerZero 메시지가 솔라나로 전송됩니다
   - 솔라나의 에스크로에서 동등한 토큰이 릴리스됩니다

---

## 거버넌스 및 보안

### 멀티시그 지갑

FIGHT 토큰은 향상된 보안 및 분산화를 위해 멀티시그 거버넌스를 구현합니다:

#### 솔라나 멀티시그 (Squads V4)
- **주소:** `GCQ8wGjU5TYmzC1YJckqgTGQLRjRxktB4rNuemPA9XWh`
- **유형:** Squads V4 Vault
- **제어:**
  - ✅ OFT 관리자 (프로그램 구성)
  - ✅ 토큰 메타데이터 업데이트 권한
  - ⚠️ LayerZero 위임 (멀티시그 작업 대기 중)
  - ✅ 프로그램 업그레이드 권한

#### BSC 멀티시그
- **주소:** `0x1381c63F11Fe73998d80e2b42876C64362cF98Ab`
- **제어:**
  - ✅ 계약 소유권
  - ⚠️ LayerZero 위임 (멀티시그 작업 대기 중)

### 보안 기능

1. **분산 제어:** 모든 중요한 기능은 멀티시그 승인이 필요합니다
2. **업그레이드 보호:** 프로그램/계약 업그레이드는 멀티시그 합의가 필요합니다
3. **속도 제한:** 크로스체인 전송을 위한 내장 속도 제한
4. **DVN 보안:** LayerZero V2는 메시지 검증을 위해 분산 검증자 네트워크(DVN)를 사용합니다
5. **불변 민트 권한:** 솔라나 토큰 민트 권한은 OFT Store가 제어합니다(추가 민팅 불가능)

---

## 토큰 배포

### 초기 공급
- **총 민팅:** 10,000,000,000 FIGHT (솔라나에서)
- **유통 (솔라나):** 브리지 활동에 따라 가변
- **브리지됨 (BSC):** 사용자 브리지 전송에 따라 동적

### 현재 보유
- **멀티시그 재무:** 10,000,000,000 FIGHT
  - 거래: `5AGrL5Rm8sQQJnbVHYUVUAJZcYqJcEgNnyhkFiSXuXPy7iKfnMM28YjoPBEGESgHnNd5HvbbXzdJbkRhSy3aXVt6`

---

## 기술 세부 사항

### 솔라나 프로그램

**프로그램 유형:** Anchor 기반 Rust 프로그램
**프로그램 ID:** `FXnms2y5FUjzxzEaDEnEF54pYWZLteTdKUwQhDbCAUfL`

**주요 명령:**
- `send`: BSC로 크로스체인 전송 시작
- `lz_receive`: BSC에서 토큰 수신
- `set_oft_config`: 관리자/위임 구성 (멀티시그만)

**OFT Store 구성:**
- **유형:** 네이티브 OFT (기존 SPL 토큰 사용)
- **관리자:** 멀티시그 (구성 제어)
- **위임:** LayerZero 엔드포인트 설정 제어
- **토큰 민트 권한:** OFT Store PDA (추가 민팅 방지)

### BSC 스마트 계약

**계약 유형:** Solidity ERC-20 + LayerZero OFT
**주소:** `0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab`

**주요 기능:**
- `send()`: 솔라나로 토큰 브리지
- `_lzReceive()`: 솔라나에서 토큰 수신
- `transferOwnership()`: 소유권 이전 (멀티시그만)
- `setDelegate()`: LayerZero 위임 설정 (멀티시그만)

**공급 상한:** 10,000,000,000 FIGHT (계약 수준에서 시행됨)

---

## 배포 정보

### 배포 날짜
- **솔라나 프로그램:** 슬롯 376682336에서 배포됨
- **BSC 계약:** 2025년 11월 배포됨

### 배포 거래

**솔라나:**
- 프로그램 배포: 슬롯 376682336
- OFT Store 생성: 온체인
- 멀티시그로 토큰 전송: `5AGrL5Rm8sQQJnbVHYUVUAJZcYqJcEgNnyhkFiSXuXPy7iKfnMM28YjoPBEGESgHnNd5HvbbXzdJbkRhSy3aXVt6`

**BSC:**
- 계약 배포: TBD
- 소유권 이전: `0xa3f30a326d76c93bd872e501b69aa2a9e67867adc084bb3b38d1ca898c124124` (블록 67808442)

---

## 검증 및 감사

### 온체인 검증

**솔라나:**
- 프로그램이 배포되고 온체인에서 검증 가능합니다
- 소스 코드: https://github.com/Fight-Foundation/token

**BSC:**
- 계약은 BscScan에서 검증되었습니다
- 검증: https://bscscan.com/address/0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab

### 보안 조치

1. **멀티시그 요구 사항:**
   - 모든 관리 작업은 멀티시그 승인이 필요합니다
   - 업그레이드 권한은 멀티시그가 제어합니다
   - 위임 구성은 멀티시그가 제어합니다

2. **LayerZero V2 보안:**
   - 분산 검증자 네트워크(DVN)
   - 메시지 인증 및 검증
   - 구성 가능한 보안 매개변수

3. **공급 제어:**
   - 고정 최대 공급량 (100억 토큰)
   - BSC에서 민팅 기능 없음 (래핑만)
   - 솔라나의 민트 권한은 OFT Store PDA가 보유합니다

---

## 통합 가이드

### 지갑에 FIGHT 추가

**솔라나 지갑 (Phantom, Solflare 등):**
```
토큰 주소: 8f62NyJGo7He5uWeveTA2JJQf4xzf8aqxkmzxRQ3mxfU
```

**BSC 지갑 (MetaMask, Trust Wallet 등):**
```
계약 주소: 0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab
토큰 심볼: FIGHT
소수점: 18
```

### 토큰 브리징

사용자는 LayerZero 호환 인터페이스 또는 직접 계약 상호 작용을 사용하여 솔라나와 BSC 간에 FIGHT 토큰을 브리지할 수 있습니다.

**중요:** 크로스체인 전송에는 브리지 수수료가 적용됩니다 (네이티브 가스 토큰으로 지불: SOL 또는 BNB).

---

## 탐색기 링크

### 솔라나
- **토큰 민트:** https://explorer.solana.com/address/8f62NyJGo7He5uWeveTA2JJQf4xzf8aqxkmzxRQ3mxfU
- **OFT 프로그램:** https://explorer.solana.com/address/FXnms2y5FUjzxzEaDEnEF54pYWZLteTdKUwQhDbCAUfL
- **OFT Store:** https://explorer.solana.com/address/8TRG47KgD9KgZaHyKH5CKZRCAhfUAzbqivXV8SZWWhYk
- **멀티시그:** https://explorer.solana.com/address/GCQ8wGjU5TYmzC1YJckqgTGQLRjRxktB4rNuemPA9XWh
- **Squads 앱:** https://v4.squads.so/

### BSC
- **계약:** https://bscscan.com/address/0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab
- **멀티시그:** https://bscscan.com/address/0x1381c63F11Fe73998d80e2b42876C64362cF98Ab
- **소유권 이전 TX:** https://bscscan.com/tx/0xa3f30a326d76c93bd872e501b69aa2a9e67867adc084bb3b38d1ca898c124124

### LayerZero
- **LayerZero Scan:** https://layerzeroscan.com/
- **솔라나 엔드포인트:** https://layerzeroscan.com/endpoint/30168
- **BSC 엔드포인트:** https://layerzeroscan.com/endpoint/30102

---

## 저장소 및 소스 코드

- **GitHub:** https://github.com/Fight-Foundation/token
- **라이선스:** MIT
- **문서:** 저장소에서 사용 가능

---

## 지원 및 연락

기술 문의, 통합 지원 또는 보안 문제는:

- **GitHub 이슈:** https://github.com/Fight-Foundation/token/issues
- **문서:** 저장소 README.md

---

## 부록: 완전한 주소 참조

### 솔라나 주소
| 구성 요소 | 주소 |
|-----------|---------|
| 토큰 민트 | `8f62NyJGo7He5uWeveTA2JJQf4xzf8aqxkmzxRQ3mxfU` |
| OFT 프로그램 | `FXnms2y5FUjzxzEaDEnEF54pYWZLteTdKUwQhDbCAUfL` |
| OFT Store | `8TRG47KgD9KgZaHyKH5CKZRCAhfUAzbqivXV8SZWWhYk` |
| 토큰 에스크로 | `6rZoHSARsboMx1vNesfqd7q1DasgxWs5yivrRJvKaSPe` |
| LayerZero 엔드포인트 | `76y77prsiCMvXMjuoZ5VRrhG5qYBrUMYTE5WgHqgjEn6` |
| 멀티시그 (Squads V4) | `GCQ8wGjU5TYmzC1YJckqgTGQLRjRxktB4rNuemPA9XWh` |
| 멀티시그 토큰 계정 | `HFzqZ8c7pRstrYe9dzk9mZZP7wA2c86p7m5L73o6bsk7` |

### BSC 주소
| 구성 요소 | 주소 |
|-----------|---------|
| FIGHT OFT 계약 | `0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab` |
| LayerZero 엔드포인트 | `0x1a44076050125825900e736c501f859c50fE728c` |
| 멀티시그 | `0x1381c63F11Fe73998d80e2b42876C64362cF98Ab` |

### LayerZero 엔드포인트 ID
| 체인 | 엔드포인트 ID |
|-------|-------------|
| 솔라나 메인넷 | 30168 |
| BSC 메인넷 | 30102 |

---

**문서 버전:** 1.0
**최종 업데이트:** 2025년 11월 11일
**상태:** 프로덕션 배포 활성
