#!/bin/bash

# Test CI build locally using Docker to simulate GitHub Actions Ubuntu environment

echo "Testing PDF builds in clean Ubuntu environment..."

docker run --rm -v "$PWD:/workspace" -w /workspace ubuntu:latest bash -c "
  apt-get update -qq && \
  apt-get install -y -qq \
    pandoc \
    texlive-xetex \
    texlive-fonts-recommended \
    texlive-latex-recommended \
    texlive-latex-extra \
    texlive-lang-cjk \
    fonts-lmodern \
    fonts-unfonts-core && \
  echo '=== Building English PDF ===' && \
  bash build-pdf.sh && \
  echo '=== Building French PDF ===' && \
  bash build-pdf-fr.sh && \
  echo '=== Building Korean PDF ===' && \
  bash build-pdf-kr.sh && \
  echo '=== SUCCESS: All PDFs built ===' && \
  ls -lh *.pdf
"

echo ""
echo "Test complete! If successful, GitHub Actions should work."
