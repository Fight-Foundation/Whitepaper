#!/bin/bash

# Build Fight Whitepaper PDF with proper hierarchy

cd "$(dirname "$0")"

pandoc \
  --resource-path=.:assets:assets/images \
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
  --include-in-header=latex/emoji-support.tex \
  --metadata title="Fight Whitepaper" \
  --metadata subtitle="Access Token for Combat Sports" \
  --metadata date="January 12, 2026" \
  executive-summary.md \
  ufc-partnership.md \
  product-stack/fightid.md \
  product-stack/fp-points.md \
  product-stack/fight-token.md \
  roadmap.md \
  utilities.md \
  governance.md \
  tokenomics.md \
  token-tech-details.md \
  links.md \
  disclaimer.md \
  -o Fight-Whitepaper.pdf

echo "PDF generated: Fight-Whitepaper.pdf"
