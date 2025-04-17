var __getOwnPropNames = Object.getOwnPropertyNames;
var __commonJS = (cb, mod) => function __require() {
  return mod || (0, cb[__getOwnPropNames(cb)[0]])((mod = { exports: {} }).exports, mod), mod.exports;
};

// tailwind_plugins/typography.js
var require_typography = __commonJS({
  "tailwind_plugins/typography.js"(exports2, module2) {
    var plugin = require("tailwindcss/plugin");
    var textStyles = {
      h1: {
        fontSize: "3rem",
        lineHeight: "3.75rem",
        fontWeight: 700,
        letterSpacing: "0.24px"
      },
      h2: {
        fontSize: "2rem",
        lineHeight: "3rem",
        fontWeight: 700,
        letterSpacing: "0.16px"
      },
      h3: {
        fontSize: "1.5rem",
        lineHeight: "2rem",
        fontWeight: 700
      },
      h4: {
        fontSize: "1.25rem",
        lineHeight: "1.75rem",
        fontWeight: 700
      },
      h5: {
        fontSize: "1rem",
        lineHeight: "1.25rem",
        fontWeight: 700
      },
      h6: {
        fontSize: "0.75rem",
        lineHeight: "1rem",
        fontWeight: 700,
        letterSpacing: "0.48px",
        textTransform: "uppercase"
      },
      body: {
        fontSize: "1rem",
        lineHeight: "1.5rem"
      },
      "body-sm": {
        fontSize: "0.875rem",
        lineHeight: "1.25rem"
      },
      "body-xs": {
        fontSize: "0.75rem",
        lineHeight: "1rem"
      },
      "button-lg": {
        fontSize: "1rem",
        lineHeight: "1.5rem",
        fontWeight: 700
      },
      button: {
        fontSize: "0.875rem",
        lineHeight: "1.25rem",
        fontWeight: 700
      },
      "button-sm": {
        fontSize: "0.75rem",
        lineHeight: "1rem",
        fontWeight: 700
      },
      helper: {
        fontSize: "11px",
        lineHeight: "12px"
      }
    };
    module2.exports = plugin(function({ addBase }) {
      addBase(
        Object.fromEntries(
          Object.entries(textStyles).map(([name, styles]) => [`.text-${name}`, styles])
        )
      );
    });
    module2.exports.textStyles = textStyles;
  }
});

// tailwind_plugins/layout.js
var require_layout = __commonJS({
  "tailwind_plugins/layout.js"(exports2, module2) {
    var plugin = require("tailwindcss/plugin");
    module2.exports = plugin(function({ addComponents }) {
      addComponents({
        ".page": {
          height: "100%",
          display: "grid",
          gridTemplateRows: "auto 1fr auto",
          gridTemplateAreas: '"header" "content" "footer"'
        },
        ".page-header": {
          "@apply bg-neutral-200 border-b border-neutral-300 px-14 pt-5": {},
          gridArea: "header"
        },
        ".page-content": {
          "@apply px-14 pt-8 pb-6": {},
          overflow: "auto",
          gridArea: "content"
        },
        ".page-footer": {
          "@apply bg-neutral-100 flex items-center border-t border-neutral-300 px-14 py-4": {},
          height: "72px",
          gridArea: "footer"
        }
      });
    });
  }
});

// tailwind_plugins/variants.js
var require_variants = __commonJS({
  "tailwind_plugins/variants.js"(exports2, module2) {
    var plugin = require("tailwindcss/plugin");
    module2.exports = plugin(function({ addVariant }) {
      addVariant("group-selected", ":merge(.group).selected &");
    });
  }
});

// tailwind_plugins/badge.js
var require_badge = __commonJS({
  "tailwind_plugins/badge.js"(exports2, module2) {
    var plugin = require("tailwindcss/plugin");
    module2.exports = plugin(function({ addComponents, theme }) {
      addComponents({
        ".badge": {
          display: "inline-flex",
          alignItems: "center",
          justifyContent: "center",
          gap: "2px",
          borderRadius: "9999px",
          fontWeight: "600",
          boxShadow: theme("boxShadow.small-200"),
          verticalAlign: "middle",
          userSelect: "none",
          maxWidth: "100%",
          minWidth: "0px"
        },
        ".badge-label": {
          "@apply truncate": {}
        },
        ".badge-remove-button": {
          "@apply inline-flex rounded-full outline-current": {}
        },
        ".badge-neutral": {
          color: theme("colors.neutral.700"),
          backgroundColor: theme("colors.neutral.300"),
          "& .badge-remove-button:hover, .badge-remove-button:focus": {
            backgroundColor: theme("colors.neutral.400")
          }
        },
        ".badge-info": {
          color: theme("colors.info.400"),
          backgroundColor: theme("colors.info.100"),
          "& .badge-remove-button:hover, .badge-remove-button:focus": {
            backgroundColor: theme("colors.info.200")
          }
        },
        ".badge-success": {
          color: theme("colors.success.400"),
          backgroundColor: theme("colors.success.100"),
          "& .badge-remove-button:hover, .badge-remove-button:focus": {
            backgroundColor: theme("colors.success.200")
          }
        },
        ".badge-warning": {
          color: theme("colors.warning.500"),
          backgroundColor: theme("colors.warning.100"),
          "& .badge-remove-button:hover, .badge-remove-button:focus": {
            backgroundColor: theme("colors.warning.200")
          }
        },
        ".badge-error": {
          color: theme("colors.error.400"),
          backgroundColor: theme("colors.error.100"),
          "& .badge-remove-button:hover, .badge-remove-button:focus": {
            backgroundColor: theme("colors.error.200")
          }
        },
        ".badge-xs": {
          "@apply text-body-xs": {},
          padding: "2px 6px",
          "& .icon": { fontSize: "12px" },
          "&:has(.icon:first-child)": { paddingLeft: "4px" },
          "&:has(.icon:last-child)": { paddingRight: "4px" },
          "&:has(> .icon:only-child)": { padding: "2px" }
        },
        ".badge-sm": {
          "@apply text-body-xs": {},
          padding: "4px 8px",
          "& .icon": { fontSize: "16px" },
          "&:has(> .icon:first-child)": { paddingLeft: "6px" },
          "&:has(> .icon:last-child)": { paddingRight: "6px" },
          "&:has(> .icon:only-child)": { padding: "4px" }
        },
        ".badge-md": {
          "@apply text-body-sm": {},
          padding: "6px 10px",
          "& .icon": { fontSize: "20px" },
          "&:has(> .icon:first-child)": { paddingLeft: "6px" },
          "&:has(* ~ .icon)": { paddingRight: "6px" },
          "&:has(> .icon:only-child)": { padding: "6px" }
        },
        ".badge-lg": {
          "@apply text-body": {},
          padding: "8px 12px",
          "& .icon": { fontSize: "24px" },
          "&:has(.icon:first-child)": { paddingLeft: "8px" },
          "&:has(.icon:last-child)": { paddingRight: "8px" },
          "&:has(> .icon:only-child)": { padding: "8px" }
        }
      });
    });
  }
});

// tailwind_plugins/banner.js
var require_banner = __commonJS({
  "tailwind_plugins/banner.js"(exports2, module2) {
    var plugin = require("tailwindcss/plugin");
    module2.exports = plugin(function({ addComponents, theme }) {
      addComponents({
        ".banner": {
          width: "100%",
          display: "flex",
          alignItems: "center",
          gap: "2px",
          borderRadius: "12px",
          color: theme("colors.neutral.900"),
          "& .close-button": {
            color: "currentColor",
            padding: "8px",
            borderRadius: "9999px",
            display: "flex",
            alignItems: "center",
            justifyContent: "center"
          }
        },
        ".banner-icon-container": {
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          borderRadius: "8px",
          boxShadow: theme("boxShadow.small-200"),
          backgroundColor: "currentColor"
        },
        ".banner-icon": {
          color: theme("colors.neutral.100")
        },
        ".banner-label": {
          color: "currentColor",
          fontWeight: "bold"
        },
        ".banner-info": {
          backgroundColor: theme("colors.info.100")
        },
        ".banner-info .banner-label": {
          color: theme("colors.info.400")
        },
        ".banner-info .banner-icon-container": {
          backgroundColor: theme("colors.info.400")
        },
        ".banner-info .close-button": {
          color: theme("colors.info.400")
        },
        ".banner-success": {
          backgroundColor: theme("colors.success.100")
        },
        ".banner-success .banner-label": {
          color: theme("colors.success.300")
        },
        ".banner-success .banner-icon-container": {
          backgroundColor: theme("colors.success.300")
        },
        ".banner-success .close-button": {
          color: theme("colors.success.300")
        },
        ".banner-warning": {
          backgroundColor: theme("colors.warning.100")
        },
        ".banner-warning .banner-icon-container": {
          backgroundColor: theme("colors.warning.300")
        },
        ".banner-warning .banner-label": {
          color: theme("colors.warning.300")
        },
        ".banner-warning .close-button": {
          color: theme("colors.warning.300")
        },
        ".banner-error": {
          backgroundColor: theme("colors.error.100")
        },
        ".banner-error .banner-icon-container": {
          backgroundColor: theme("colors.error.300")
        },
        ".banner-error .banner-label": {
          color: theme("colors.error.300")
        },
        ".banner-error .close-button": {
          color: theme("colors.error.300")
        },
        ".banner-sm": {
          "@apply text-body-xs": {},
          padding: "8px",
          gap: "8px",
          "& .banner-icon-container": {
            width: "24px",
            height: "24px",
            padding: "4px"
          },
          "& .banner-icon": {
            fontSize: "16px"
          }
        },
        ".banner-md": {
          "@apply text-body-sm": {},
          padding: "8px",
          gap: "8px",
          "& .banner-icon-container": {
            width: "32px",
            height: "32px",
            padding: "4px"
          },
          "& .banner-icon": {
            fontSize: "24px"
          }
        },
        ".banner-lg": {
          "@apply text-body-sm": {},
          padding: "12px",
          gap: "12px",
          "& .banner-icon-container": {
            width: "40px",
            height: "40px",
            padding: "8px"
          },
          "& .banner-icon": {
            fontSize: "24px"
          }
        }
      });
    });
  }
});

// tailwind_plugins/phoenix.js
var require_phoenix = __commonJS({
  "tailwind_plugins/phoenix.js"(exports2, module2) {
    var plugin = require("tailwindcss/plugin");
    module2.exports = plugin(function({ addVariant }) {
      addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"]);
      addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"]);
      addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"]);
    });
  }
});

// tailwind_plugins/form_field.js
var require_form_field = __commonJS({
  "tailwind_plugins/form_field.js"(exports2, module2) {
    var plugin = require("tailwindcss/plugin");
    module2.exports = plugin(function({ addComponents, theme }) {
      addComponents({
        ".form-field": {
          width: "100%",
          display: "flex",
          flexDirection: "column"
        },
        ".select": {
          backgroundImage: `url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%230F61AD' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e")`,
          backgroundPosition: "right 0.5rem center",
          backgroundRepeat: "no-repeat",
          backgroundSize: "1.5em 1.5em"
        },
        ".select:disabled": {
          backgroundImage: `url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%23CAD2DA' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e")`
        },
        ".select.form-field-input-error": {
          backgroundImage: `url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%23C71938' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e")`
        }
      });
      addComponents({
        ".form-field-label": {
          display: "block",
          color: theme("colors.neutral.900"),
          fontWeight: 600,
          order: -1,
          marginBottom: "4px",
          "&.disabled": {
            color: theme("colors.neutral.400")
          }
        },
        ".form-field-label-sm": {
          "@apply text-body-xs": {}
        },
        ".form-field-label-md": {
          "@apply text-body-sm": {}
        },
        ".form-field-label-lg": {
          "@apply text-body": {}
        }
      });
      addComponents({
        ".form-field-input": {
          width: "100%",
          borderRadius: "9999px",
          border: `1px solid ${theme("colors.neutral.300")}`,
          boxShadow: theme("boxShadow.input"),
          backgroundColor: "rgba(245, 247, 250, 0.5)",
          color: theme("colors.neutral.900"),
          fontWeight: "normal",
          "&::placeholder": {
            color: theme("colors.neutral.600")
          },
          "&:focus": {
            borderColor: theme("colors.primary.300"),
            boxShadow: theme("boxShadow.input-focus")
          },
          ".form-field &.form-field-input-error": {
            backgroundColor: "rgba(254, 227, 212, 0.32)",
            borderColor: theme("colors.error.300"),
            boxShadow: theme("boxShadow.input-error")
          },
          ".form-field &.form-field-input-error form-field-icon": {
            color: theme("colors.error.300")
          },
          "textarea&": {
            border: `1px solid ${theme("colors.neutral.300")}`,
            borderRadius: "12px"
          },
          "&:disabled": {
            color: theme("colors.neutral.400"),
            backgroundColor: "rgba(224, 229, 235, 0.5)",
            border: `1px solid ${theme("colors.neutral.300")}`,
            boxShadow: theme("boxShadow.input"),
            cursor: "not-allowed"
          }
        },
        ".form-field-input-sm": {
          "@apply text-body-xs": {},
          padding: "8px 12px"
        },
        ".form-field-input-md": {
          "@apply text-body-sm": {},
          padding: "8px 12px"
        },
        ".form-field-input-lg": {
          "@apply text-body": {},
          padding: "8px 12px"
        }
      });
      addComponents({
        ".checkbox-container": {
          "@apply flex items-center gap-2 text-neutral-700 text-body-sm": {}
        },
        ".checkbox": {
          "@apply rounded border-neutral-700 text-primary-300 focus:ring-primary-300 focus-visible:ring-2 focus-visible:ring-primary-300 cursor-pointer": {},
          "&:disabled": {
            "@apply border-neutral-400 text-neutral-400 cursor-not-allowed": {}
          }
        },
        ".checkbox-label": {
          "@apply flex items-start gap-2 cursor-pointer": {},
          ".checkbox:checked ~ &": {
            "@apply font-semibold text-neutral-900": {}
          },
          ".checkbox:disabled ~ &": {
            "@apply text-neutral-400 cursor-not-allowed": {}
          }
        }
      });
      addComponents({
        ".radio-container": {
          "@apply flex items-center gap-2 text-neutral-700 text-body-sm": {}
        },
        ".radio": {
          "@apply  border-neutral-700 text-primary-300 focus:ring-primary-300 focus-visible:ring-2 focus-visible:ring-primary-300 cursor-pointer": {},
          "&:disabled": {
            "@apply border-neutral-400 text-neutral-400 cursor-not-allowed": {}
          }
        },
        ".radio-label": {
          "@apply flex items-start gap-2 cursor-pointer": {},
          ".radio:checked ~ &": {
            "@apply font-semibold text-neutral-900": {}
          },
          ".radio:disabled ~ &": {
            "@apply text-neutral-400 cursor-not-allowed": {}
          }
        }
      });
      addComponents({
        ".form-field-error": {
          "@apply text-helper": {},
          color: theme("colors.error.300"),
          marginTop: "4px",
          order: 1
        }
      });
    });
  }
});

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
              50: "#FFF9EB",
              100: "#FFF3D5",
              200: "#FFD181",
              300: "#FFA02E",
              400: "#F57200",
              500: "#AD4500"
            },
            success: {
              50: "#EDFDEC",
              100: "#D2FBD0",
              200: "#72E985",
              300: "#1CB854",
              400: "#0F8F57",
              500: "#096C53"
            },
            error: {
              50: "#FFF2EB",
              100: "#FEE3D4",
              200: "#FB9580",
              300: "#F42D2D",
              400: "#C71938",
              500: "#75082E"
            },
            info: {
              50: "#EDF8FC",
              100: "#C7E9F6",
              200: "#ACDDF2",
              300: "#74C7E9",
              400: "#48859E",
              500: "#1D4453"
            },
            driving: {
              50: "#F1F8F8",
              100: "#C9E4E5",
              200: "#92C8CB",
              300: "#4AA4A8",
              400: "#3C8285",
              500: "#1E4243"
            },
            theory: {
              50: "#F0F7FA",
              100: "#D6EEF5",
              200: "#82C5D9",
              300: "#0082A9",
              400: "#01627E",
              500: "#003444"
            }
          },
          backgroundImage: {
            "gradient-break": "linear-gradient(to right bottom, #74C7E9, #417990)",
            "gradient-driving": "linear-gradient(to right bottom, #1FBAC1, #367577)",
            "gradient-theory": "linear-gradient(to right bottom, #39AED1, #0A4F64)",
            "gradient-exam": "linear-gradient(to right bottom, #FFA02E, #D86C0D)",
            "gradient-vacation": "linear-gradient(to right bottom, #798796, #081318)",
            "gradient-sick-leave": "linear-gradient(to right bottom, #FF6838, #993313)"
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
            inner: "inset 1px 0px 0px #E0E5EB",
            "small-100": "0px 2px 4px -2px rgba(31, 41, 51, 0.08)",
            "small-200": "0px 2px 4px -2px rgba(31, 41, 51, 0.08)",
            "small-300": "0px 4px 8px -2px rgba(31, 41, 51, 0.08)",
            "small-400": "0px 4px 12px -4px rgba(31, 41, 51, 0.16)",
            "medium-100": "0px 12px 24px -8px rgba(31, 41, 51, 0.12)",
            "medium-200": "0px 16px 24px -8px rgba(31, 41, 51, 0.16)",
            "medium-300": "0px 24px 28px -12px rgba(31, 41, 51, 0.18)",
            "medium-400": "0px 28px 40px -8px rgba(31, 41, 51, 0.2)",
            "large-100": "0px 32px 48px -24px rgba(31, 41, 51, 0.2)",
            "large-200": "0px 36px 56px -24px rgba(31, 41, 51, 0.28)",
            "large-300": "0px 40px 64px -24px rgba(31, 41, 51, 0.36)",
            "large-400": "0px 48px 84px -32px rgba(31, 41, 51, 0.48)",
            input: "inset 0px 2px 2px 0px rgba(224, 229, 235, 0.64)",
            "input-focus": "inset 0px 2px 2px 0px rgba(42, 96, 118, 0.24)",
            "input-disabled": "inset 0px 2px 2px rgba(121, 135, 150, 0.24)",
            "input-success": "inset 0px 2px 2px 0px rgba(28, 184, 84, 0.24)",
            "input-error": "inset 0px 2px 2px 0px rgba(255, 87, 34, 0.24)"
          },
          fontFamily: {
            sans: ["Open Sans", "sans-serif"]
          },
          borderRadius: {
            4: "4px",
            8: "8px",
            12: "12px",
            16: "16px",
            24: "24px"
          }
        }
      },
      plugins: [
        require("@tailwindcss/forms"),
        require_typography(),
        require_layout(),
        require_variants(),
        require_badge(),
        require_banner(),
        require_phoenix(),
        require_form_field()
      ]
    };
  }
});

// main.js
module.exports = {
  preset: require_tailwind_preset()
};
//# sourceMappingURL=main.cjs.js.map
