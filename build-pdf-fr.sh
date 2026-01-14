#!/bin/bash

# Build Fight Whitepaper PDF - French version

cd "$(dirname "$0")"

# Create a temporary header file for French support
cat > /tmp/french-header.tex << 'EOF'
\usepackage{fontspec}
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
  -V lang=fr \
  --include-in-header=/tmp/french-header.tex \
  --metadata title="Fight Whitepaper" \
  --metadata subtitle="Jeton d'Accès pour les Sports de Combat" \
  --metadata date="12 janvier 2026" \
  fr/executive-summary.md \
  fr/ufc-partnership.md \
  fr/product-stack/fightid.md \
  fr/product-stack/fp-points.md \
  fr/product-stack/fight-token.md \
  fr/roadmap.md \
  fr/utilities.md \
  fr/governance.md \
  fr/tokenomics.md \
  fr/token-tech-details.md \
  fr/links.md \
  fr/disclaimer.md \
  -o Fight-Whitepaper-FR.pdf

rm -f /tmp/french-header.tex

echo "PDF generated: Fight-Whitepaper-FR.pdf"
