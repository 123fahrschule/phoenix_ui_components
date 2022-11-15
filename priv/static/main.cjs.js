var __getOwnPropNames = Object.getOwnPropertyNames;
var __commonJS = (cb, mod) => function __require() {
  return mod || (0, cb[__getOwnPropNames(cb)[0]])((mod = { exports: {} }).exports, mod), mod.exports;
};

// tailwind-preset.js
var require_tailwind_preset = __commonJS({
  "tailwind-preset.js"(exports2, module2) {
    module2.exports = {
      theme: {
        extend: {
          colors: {
            primary: {
              50: "#E1EEF4",
              100: "#B4CED8",
              200: "#6F97A7",
              300: "#2A6076",
              400: "#193A47",
              500: "#11262F",
              600: "#081318"
            },
            secondary: {
              50: "#FFEEE9",
              100: "#FFCDBD",
              200: "#FF9A7A",
              300: "#FF5722",
              400: "#CC461B",
              500: "#993414",
              600: "#66230E"
            },
            neutral: {
              100: "#FFFFFF",
              200: "#F5F7FA",
              300: "#E0E5EB",
              400: "#CAD2DA",
              500: "#98A5B3",
              600: "#798796",
              700: "#5F6E7E",
              800: "#252E37",
              900: "#171F26"
            },
            warning: {
              100: "#FFF3D5",
              200: "#FFD181",
              300: "#FFA02E",
              400: "#F57200",
              500: "#AD4500"
            },
            success: {
              100: "#D2FBD0",
              200: "#72E985",
              300: "#1CB854",
              400: "#0F8F57",
              500: "#096C53"
            },
            error: {
              100: "#FEE3D4",
              200: "#FB9580",
              300: "#F42D2D",
              400: "#C71938",
              500: "#75082E"
            },
            info: {
              100: "#C7E9F6",
              200: "#ACDDF2",
              300: "#74C7E9",
              400: "#48859E",
              500: "#1D4453"
            },
            driving: {
              100: "#DDEEEE",
              200: "#92C8CB",
              300: "#4AA4A8",
              400: "#3C8285",
              500: "#1E4243"
            },
            theory: {
              100: "#D6EEF5",
              200: "#82C5D9",
              300: "#0082A9",
              400: "#01627E",
              500: "#003444"
            }
          },
          boxShadow: {
            sm: "0px 2px 4px -2px rgba(31, 41, 51, 0.08)",
            "sm-2": "0px 2px 4px -2px rgba(31, 41, 51, 0.08)",
            "sm-3": "0px 4px 8px -2px rgba(31, 41, 51, 0.08)",
            "sm-4": "0px 4px 12px -4px rgba(31, 41, 51, 0.16)",
            md: "0px 12px 24px -8px rgba(31, 41, 51, 0.12)",
            "md-2": "0px 16px 24px -8px rgba(31, 41, 51, 0.16)",
            "md-3": "0px 24px 28px -12px rgba(31, 41, 51, 0.18)",
            "md-4": "0px 28px 40px -8px rgba(31, 41, 51, 0.2)",
            lg: "0px 32px 48px -24px rgba(31, 41, 51, 0.2)",
            "lg-2": "0px 36px 56px -24px rgba(31, 41, 51, 0.28)",
            "lg-3": "0px 40px 64px -24px rgba(31, 41, 51, 0.36)",
            "lg-4": "0px 48px 84px -32px rgba(31, 41, 51, 0.48)",
            input: "inset 0px 2px 2px rgba(224, 229, 235, 0.64)",
            "input-focus": "inset 0px 2px 2px rgba(42, 96, 118, 0.24)",
            "input-disabled": "inset 0px 2px 2px rgba(121, 135, 150, 0.24)",
            "input-success": "inset 0px 2px 2px rgba(28, 184, 84, 0.24)",
            "input-error": "inset 0px 2px 2px rgba(255, 87, 34, 0.24)"
          },
          fontFamily: {
            sans: ["Open Sans", "sans-serif"]
          }
        }
      }
    };
  }
});

// tailwind-plugin.js
var require_tailwind_plugin = __commonJS({
  "tailwind-plugin.js"(exports2, module2) {
    module2.exports = ({ addBase, addVariant, theme }) => {
      addBase({
        h1: {
          fontSize: theme("fontSize.5xl"),
          lineHeight: theme("lineHeight.tight"),
          fontWeight: "bold",
          letterSpacing: "0.24px"
        },
        h2: {
          fontSize: "2rem",
          lineHeight: theme("lineHeight.normal"),
          fontWeight: "bold",
          letterSpacing: "0.16px"
        },
        h3: {
          fontSize: theme("fontSize.2xl"),
          lineHeight: 1.333333,
          fontWeight: "bold"
        },
        h4: {
          fontSize: theme("fontSize.xl"),
          lineHeight: 1.4,
          fontWeight: "bold"
        },
        h5: {
          fontSize: theme("fontSize.normal"),
          lineHeight: theme("lineHeight.tight"),
          fontWeight: "bold"
        },
        h6: {
          fontSize: theme("fontSize.sm"),
          lineHeight: 1.333333,
          fontWeight: "bold",
          letterSpacing: "0.48px",
          textTransform: "uppercase"
        }
      });
      addVariant("group-selected", ":merge(.group).selected &");
    };
  }
});

// main.js
module.exports = {
  preset: require_tailwind_preset(),
  plugin: require_tailwind_plugin()
};
//# sourceMappingURL=main.cjs.js.map
