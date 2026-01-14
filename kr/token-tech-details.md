---
order: 90
icon: code
---

# FIGHT 토큰 - 기술 개요

## 개요

FIGHT는 솔라나와 BNB 스마트 체인(BSC)에 배포된 크로스체인 대체 가능 토큰으로, 원활한 크로스체인 전송을 위해 LayerZero V2 프로토콜을 활용합니다. 토큰은 옴니체인 대체 가능 토큰(OFT) 표준을 구현하여 체인 간 안전하고 효율적인 브리징을 보장합니다.

---

## 토큰 사양

### 솔라나 (기본 체인)
- **토큰 타입:** SPL 토큰 (네이티브)
- **토큰 민트:** `8f62NyJGo7He5uWeveTA2JJQf4xzf8aqxkmzxRQ3mxfU`
- **총 공급량:** 10,000,000,000 FIGHT (100억)
- **소수점:** 9
- **토큰 표준:** Metaplex 메타데이터가 있는 SPL 토큰

### BNB 스마트 체인 (보조 체인)
- **토큰 타입:** ERC-20 (OFT)
- **컨트랙트 주소:** `0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab`
- **공급 모델:** Wrapped (네이티브 민팅 없음, 모든 토큰이 솔라나에서 브리지됨)
- **소수점:** 18
- **토큰 표준:** LayerZero OFT V2

---

## 아키텍처

### 크로스체인 브리지 (LayerZero V2)

FIGHT는 신뢰할 수 없는 크로스체인 전송을 위해 LayerZero의 옴니체인 대체 가능 토큰(OFT) 프로토콜을 활용합니다:

**솔라나 컴포넌트:**
- **OFT 프로그램:** `FXnms2y5FUjzxzEaDEnEF54pYWZLteTdKUwQhDbCAUfL`
- **OFT 스토어:** `8TRG47KgD9KgZaHyKH5CKZRCAhfUAzbqivXV8SZWWhYk`
- **토큰 에스크로:** `6rZoHSARsboMx1vNesfqd7q1DasgxWs5yivrRJvKaSPe`
- **LayerZero 엔드포인트:** `76y77prsiCMvXMjuoZ5VRrhG5qYBrUMYTE5WgHqgjEn6`
- **엔드포인트 ID:** 30168 (솔라나 메인넷)

**BSC 컴포넌트:**
- **OFT 컨트랙트:** `0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab`
- **LayerZero 엔드포인트:** `0x1a44076050125825900e736c501f859c50fE728c`
- **엔드포인트 ID:** 30102 (BSC 메인넷)

### 브리지 메커니즘

1. **솔라나 → BSC:**
   - 토큰이 솔라나 에스크로 계정에 잠김
   - LayerZero 메시지가 BSC로 전송됨
   - 동등한 토큰이 BSC에서 민팅됨

2. **BSC → 솔라나:**
   - 토큰이 BSC에서 소각됨
   - LayerZero 메시지가 솔라나로 전송됨
   - 동등한 토큰이 솔라나의 에스크로에서 해제됨

---

## 거버넌스 & 보안

### 멀티시그 지갑

FIGHT 토큰은 향상된 보안과 탈중앙화를 위해 멀티시그 거버넌스를 구현합니다:

#### 솔라나 멀티시그 (Squads V4)
- **주소:** `GCQ8wGjU5TYmzC1YJckqgTGQLRjRxktB4rNuemPA9XWh`
- **타입:** Squads V4 Vault
- **제어:**
  - ✅ OFT 관리자 (프로그램 구성)
  - ✅ 토큰 메타데이터 업데이트 권한
  - ⚠️ LayerZero 델리게이트 (멀티시그 작업 대기 중)
  - ✅ 프로그램 업그레이드 권한

#### BSC 멀티시그
- **주소:** `0x1381c63F11Fe73998d80e2b42876C64362cF98Ab`
- **제어:**
  - ✅ 컨트랙트 소유권
  - ⚠️ LayerZero 델리게이트 (멀티시그 작업 대기 중)

### 보안 기능

1. **탈중앙화된 제어:** 모든 중요 기능에 멀티시그 승인 필요
2. **업그레이드 보호:** 프로그램/컨트랙트 업그레이드에 멀티시그 합의 필요
3. **속도 제한:** 크로스체인 전송을 위한 내장 속도 제한
4. **DVN 보안:** LayerZero V2는 메시지 검증을 위해 탈중앙화 검증자 네트워크(DVN) 사용
5. **불변 민트 권한:** 솔라나 토큰 민트 권한은 OFT 스토어가 제어 (추가 민팅 불가)

---

## 토큰 배포

### 초기 공급
- **총 민팅:** 10,000,000,000 FIGHT (솔라나)
- **유통 (솔라나):** 브리지 활동에 따라 가변
- **브리지됨 (BSC):** 사용자 브리지 전송에 따라 동적

### 현재 보유
- **멀티시그 트레저리:** 10,000,000,000 FIGHT
  - 트랜잭션: `5AGrL5Rm8sQQJnbVHYUVUAJZcYqJcEgNnyhkFiSXuXPy7iKfnMM28YjoPBEGESgHnNd5HvbbXzdJbkRhSy3aXVt6`

---

## 기술 세부사항

### 솔라나 프로그램

**프로그램 타입:** Anchor 기반 Rust 프로그램
**프로그램 ID:** `FXnms2y5FUjzxzEaDEnEF54pYWZLteTdKUwQhDbCAUfL`

**주요 명령어:**
- `send`: BSC로의 크로스체인 전송 시작
- `lz_receive`: BSC에서 토큰 수신
- `set_oft_config`: 관리자/델리게이트 구성 (멀티시그 전용)

**OFT 스토어 구성:**
- **타입:** 네이티브 OFT (기존 SPL 토큰 사용)
- **관리자:** 멀티시그 (구성 제어)
- **델리게이트:** LayerZero 엔드포인트 설정 제어
- **토큰 민트 권한:** OFT 스토어 PDA (추가 민팅 방지)

### BSC 스마트 컨트랙트

**컨트랙트 타입:** Solidity ERC-20 + LayerZero OFT
**주소:** `0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab`

**주요 함수:**
- `send()`: 솔라나로 토큰 브리지
- `_lzReceive()`: 솔라나에서 토큰 수신
- `transferOwnership()`: 소유권 이전 (멀티시그 전용)
- `setDelegate()`: LayerZero 델리게이트 설정 (멀티시그 전용)

**공급 한도:** 10,000,000,000 FIGHT (컨트랙트 레벨에서 적용)

---

## 배포 정보

### 배포 날짜
- **솔라나 프로그램:** 슬롯 376682336에서 배포
- **BSC 컨트랙트:** 2025년 11월 배포

### 배포 트랜잭션

**솔라나:**
- 프로그램 배포: 슬롯 376682336
- OFT 스토어 생성: 온체인
- 멀티시그로 토큰 전송: `5AGrL5Rm8sQQJnbVHYUVUAJZcYqJcEgNnyhkFiSXuXPy7iKfnMM28YjoPBEGESgHnNd5HvbbXzdJbkRhSy3aXVt6`

**BSC:**
- 컨트랙트 배포: 2025년 11월
- 소유권 이전: `0xa3f30a326d76c93bd872e501b69aa2a9e67867adc084bb3b38d1ca898c124124` (블록 67808442)

---

## 검증 & 감사

### 온체인 검증

**솔라나:**
- 프로그램이 온체인에 배포 및 검증 가능
- 소스 코드: https://github.com/Fight-Foundation/token

**BSC:**
- BscScan에서 컨트랙트 검증됨
- 검증: https://bscscan.com/address/0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab

### 보안 조치

1. **멀티시그 요구사항:**
   - 모든 관리 작업에 멀티시그 승인 필요
   - 멀티시그가 제어하는 업그레이드 권한
   - 멀티시그가 제어하는 델리게이트 구성

2. **LayerZero V2 보안:**
   - 탈중앙화 검증자 네트워크(DVN)
   - 메시지 인증 및 검증
   - 구성 가능한 보안 파라미터

3. **공급 제어:**
   - 고정 최대 공급량 (100억 토큰)
   - BSC에서 민팅 기능 없음 (wrapped 전용)
   - 솔라나의 민트 권한은 OFT 스토어 PDA가 보유

---

## 통합 가이드

### 지갑에 FIGHT 추가

**솔라나 지갑 (Phantom, Solflare 등):**
```
토큰 주소: 8f62NyJGo7He5uWeveTA2JJQf4xzf8aqxkmzxRQ3mxfU
```

**BSC 지갑 (MetaMask, Trust Wallet 등):**
```
컨트랙트 주소: 0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab
토큰 심볼: FIGHT
소수점: 18
```

### 토큰 브리징

사용자는 LayerZero 호환 인터페이스 또는 직접 컨트랙트 상호작용을 사용하여 솔라나와 BSC 간에 FIGHT 토큰을 브리지할 수 있습니다.

**중요:** 크로스체인 전송에 브리지 수수료가 적용됩니다 (네이티브 가스 토큰으로 지불: SOL 또는 BNB).

---

## 익스플로러 링크

### 솔라나
- **토큰 민트:** https://explorer.solana.com/address/8f62NyJGo7He5uWeveTA2JJQf4xzf8aqxkmzxRQ3mxfU
- **OFT 프로그램:** https://explorer.solana.com/address/FXnms2y5FUjzxzEaDEnEF54pYWZLteTdKUwQhDbCAUfL
- **OFT 스토어:** https://explorer.solana.com/address/8TRG47KgD9KgZaHyKH5CKZRCAhfUAzbqivXV8SZWWhYk
- **멀티시그:** https://explorer.solana.com/address/GCQ8wGjU5TYmzC1YJckqgTGQLRjRxktB4rNuemPA9XWh
- **Squads 앱:** https://v4.squads.so/

### BSC
- **컨트랙트:** https://bscscan.com/address/0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab
- **멀티시그:** https://bscscan.com/address/0x1381c63F11Fe73998d80e2b42876C64362cF98Ab
- **소유권 이전 TX:** https://bscscan.com/tx/0xa3f30a326d76c93bd872e501b69aa2a9e67867adc084bb3b38d1ca898c124124

### LayerZero
- **LayerZero Scan:** https://layerzeroscan.com/
- **솔라나 엔드포인트:** https://layerzeroscan.com/endpoint/30168
- **BSC 엔드포인트:** https://layerzeroscan.com/endpoint/30102

---

## 저장소 & 소스 코드

- **GitHub:** https://github.com/Fight-Foundation/token
- **라이선스:** MIT
- **문서:** 저장소에서 이용 가능

---

## 지원 & 연락처

기술 문의, 통합 지원 또는 보안 우려 사항:

- **GitHub Issues:** https://github.com/Fight-Foundation/token/issues
- **문서:** 저장소 README.md

---

## 부록: 전체 주소 참조

### 솔라나 주소
| 컴포넌트 | 주소 |
|----------|------|
| 토큰 민트 | `8f62NyJGo7He5uWeveTA2JJQf4xzf8aqxkmzxRQ3mxfU` |
| OFT 프로그램 | `FXnms2y5FUjzxzEaDEnEF54pYWZLteTdKUwQhDbCAUfL` |
| OFT 스토어 | `8TRG47KgD9KgZaHyKH5CKZRCAhfUAzbqivXV8SZWWhYk` |
| 토큰 에스크로 | `6rZoHSARsboMx1vNesfqd7q1DasgxWs5yivrRJvKaSPe` |
| LayerZero 엔드포인트 | `76y77prsiCMvXMjuoZ5VRrhG5qYBrUMYTE5WgHqgjEn6` |
| 멀티시그 (Squads V4) | `GCQ8wGjU5TYmzC1YJckqgTGQLRjRxktB4rNuemPA9XWh` |
| 멀티시그 토큰 계정 | `HFzqZ8c7pRstrYe9dzk9mZZP7wA2c86p7m5L73o6bsk7` |

### BSC 주소
| 컴포넌트 | 주소 |
|----------|------|
| FIGHT OFT 컨트랙트 | `0xB2D97C4ed2d0Ef452654F5CAB3da3735B5e6F3ab` |
| LayerZero 엔드포인트 | `0x1a44076050125825900e736c501f859c50fE728c` |
| 멀티시그 | `0x1381c63F11Fe73998d80e2b42876C64362cF98Ab` |

### LayerZero 엔드포인트 ID
| 체인 | 엔드포인트 ID |
|------|--------------|
| 솔라나 메인넷 | 30168 |
| BSC 메인넷 | 30102 |

---

**문서 버전:** 1.0
**최종 업데이트:** 2025년 11월 11일
**상태:** 프로덕션 배포 활성화
