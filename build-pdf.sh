#!/bin/bash

# Build Fight Whitepaper PDF with proper hierarchy

cd "$(dirname "$0")"

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
  --metadata title="Fight Whitepaper" \
  --metadata subtitle="Access Token for Combat Sports" \
  --metadata date="$(date +%Y-%m-%d)" \
  index.md \
  executive-summary.md \
  ufc-partnership.md \
  product-stack/README.md \
  product-stack/fightid.md \
  product-stack/fp-points.md \
  product-stack/fight-token.md \
  tokenomics.md \
  utilities.md \
  governance.md \
  roadmap.md \
  token-tech-details.md \
  disclaimer.md \
  -o Fight-Whitepaper.pdf

echo "PDF generated: Fight-Whitepaper.pdf"
