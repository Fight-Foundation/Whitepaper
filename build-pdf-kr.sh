#!/bin/bash

# Build Fight Whitepaper PDF - Korean version

cd "$(dirname "$0")"

# Create a temporary header file for Korean support
cat > /tmp/korean-header.tex << 'EOF'
\usepackage{fontspec}
\usepackage{xeCJK}
\setCJKmainfont{Noto Sans CJK KR}
\setmainfont{DejaVu Sans}
\setsansfont{DejaVu Sans}
\setmonofont{DejaVu Sans Mono}
EOF

pandoc \
  --resource-path=. \
  --toc \
  --toc-depth=3 \
  --pdf-engine=xelatex \
  --number-sections \
  -V geometry:margin=1in \
  -V documentclass=report \
  -V colorlinks=true \
  -V linkcolor=orange \
  -V urlcolor=orange \
  -V toccolor=gray \
  --include-in-header=/tmp/korean-header.tex \
  --metadata title="Fight 백서" \
  --metadata subtitle="격투 스포츠를 위한 액세스 토큰" \
  --metadata date="2026년 1월 12일" \
  kr/executive-summary.md \
  kr/ufc-partnership.md \
  kr/product-stack/fightid.md \
  kr/product-stack/fp-points.md \
  kr/product-stack/fight-token.md \
  kr/roadmap.md \
  kr/utilities.md \
  kr/governance.md \
  kr/tokenomics.md \
  kr/token-tech-details.md \
  kr/links.md \
  kr/disclaimer.md \
  -o Fight-Whitepaper-KR.pdf

rm -f /tmp/korean-header.tex

echo "PDF generated: Fight-Whitepaper-KR.pdf"
