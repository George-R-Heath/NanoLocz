---
layout: default
title: Image Levelling
---

<link rel="stylesheet" href="/assets/styles.css">

# NanoLocz User Guide <img src="https://github.com/George-R-Heath/NanoLocz/assets/90329395/36d664a6-38e2-4405-b5cc-a962093cf13b" width="30">

{% include nav.html %}

# Image Levelling

![leveling](https://github.com/George-R-Heath/NanoLocz/assets/90329395/2be0667b-9a0c-437e-95a2-c77f6eb34f9e)

---

## Manual Leveling

### Plane Leveling
💡 **Tip**: X/Y values of 1 remove tilt; 2+ remove image bow.

- Set **X** and **Y Plane** values to perform 2D polynomial fitting.
- Preview updates in real-time.
- Click **Accept** to apply.

### Line Leveling
💡 **Tip**: Use `-Med` to subtract the median of each line.

- Set **X** and **Y Line** values to fit polynomials per line.
- Real-time preview enabled.
- Click **Accept** to apply.

<details>
  <summary><strong>➕ Leveling with a Mask</strong></summary>

Leveling with a mask is helpful when large objects skew polynomial fits. Use masks to isolate level background regions.

**Masking methods:**
1. Height histogram threshold
2. Manual drawing
3. Z-scale-based
4. Otsu method
5. Gaussian-based threshold (±1.5σ)

Then proceed with line/plane leveling using only non-masked data.
</details>

---

##  Automatic Leveling

Automatic routines (e.g. *Iterative Holes*, *Iterative Peaks*) use the following sequence:

1. Subtract plane (x/y, 2nd order) and median line (x).
2. Fit Gaussian to heights → create mask with z > ±1.5σ.
3. Reapply step 1 with mask.
4. Regenerate mask from new z-distribution.
5. Final polynomial leveling with updated mask.

Use **Iterative Holes** for low features (e.g. defects), and **Iterative Peaks** for sparse tall features.

---

## 🎥 YouTube Tutorial

[![YouTube NanoLocz Leveling + Area Analysis](https://img.youtube.com/vi/R5D6T04M7Rc/0.jpg)](https://www.youtube.com/watch?v=R5D6T04M7Rc)

---

[🔝 Back to Index](index.html)
