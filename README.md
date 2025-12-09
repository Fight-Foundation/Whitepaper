---
icon: home
---

# Fight Whitepaper

**The Access Token for Combat Sports**

This repository contains the Fight Foundation whitepaper published as a static site using Retype.

---

## Quick start

Prerequisites:
- Node.js 18+ or .NET 6+

Install Retype and build locally:

```bash
npm install -g retypeapp
retype build
retype serve
```

Then open http://localhost:5000 in your browser.

## Deploying

GitHub Actions builds and deploys to GitHub Pages on push to `main`. The site will be available at:
- https://fight-foundation.github.io/Whitepaper/

If Pages isn't already enabled, set it to "GitHub Actions" in the repository settings.

## Project structure

```
retype.yml              # Retype configuration
executive-summary.md
ufc-partnership.md
product-stack/
tokenomics.md
assets/images/          # Extracted images
```
