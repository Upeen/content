# UI Customization & Styling

## Theme

Breaking News Finder uses a **dark theme** with **glassmorphism** styling.

### Color Palette

| Color | Hex | Usage |
|-------|-----|-------|
| Accent Red | `#FF3D71` | Primary accent, gradients |
| Accent Pink | `#C850C0` | Secondary accent |
| Accent Purple | `#4158D0` | Tertiary accent |
| Accent Blue | `#2BD2FF` | Highlights, links |
| Background Dark | `#050508` | Sidebar gradient start |
| Card Background | `rgba(10,10,15,0.95)` | Stat cards |

### Typography

- **Font Family**: Inter (Google Fonts)
- **Weights**: 300, 400, 500, 600, 700, 800, 900
- Applied globally via CSS import

### Components

#### Stat Cards
```css
.stat-card {
    background: linear-gradient(135deg, rgba(10,10,15,0.95), rgba(15,15,22,0.95));
    border: 1px solid rgba(255,255,255,0.05);
    border-radius: 16px;
    padding: 24px;
    text-align: center;
    backdrop-filter: blur(10px);
}
```

#### Medal Colors
- Gold: `#FFD700` (🥇 1st)
- Silver: `#C0C0C0` (🥈 2nd)
- Bronze: `#CD7F32` (🥉 3rd)
- Rank 4-7: `#2d2d3d` to `#5d5d6d`

#### Duplicate Score Colors
- ≥80%: Gold `#FFD700`
- ≥50%: Red `#FF6B6B`
- <50%: Blue `#2BD2FF`

### Animations

```css
@keyframes fadeInUp {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

@keyframes pulse {
    0% { transform: scale(1); box-shadow: 0 0 0 0 rgba(255, 61, 113, 0.4); }
    70% { transform: scale(1.05); box-shadow: 0 0 0 10px rgba(255, 61, 113, 0); }
    100% { transform: scale(1); box-shadow: 0 0 0 0 rgba(255, 61, 113, 0); }
}
```

### Navigation

Sidebar radio buttons with icons:
- `🏁 Coverage Race`
- `🔁 Duplicate Content`

### Streamlit Overrides

```css
#MainMenu {visibility: hidden;}
footer {visibility: hidden;}
header {visibility: hidden;}
```
