import { defineConfig, globalIgnores } from 'eslint/config';
import js from '@eslint/js';
import globals from 'globals';
import tseslint from 'typescript-eslint';
import json from '@eslint/json';
import markdown from '@eslint/markdown';
import css from '@eslint/css';
import { tailwindSyntax } from '@eslint/css/syntax';
import eslintConfigPrettier from 'eslint-config-prettier/flat';
import tailwind from 'eslint-plugin-tailwindcss';

export default defineConfig([
  globalIgnores([
    'config/',
    'deps/',
    'lib/',
    'storybook/',
    'priv/static/assets/',
    'priv/static/main*cjs*',
    'priv/static/module*mjs*',
    'package.json',
    'package-lock.json'
  ]),
  {
    files: ['**/*.{js,mjs,cjs,ts}'],
    plugins: { js },
    extends: ['js/recommended']
  },
  {
    files: ['**/*.{js,mjs,cjs,ts}'],
    languageOptions: {
      globals: { ...globals.browser, ...globals.node }
    }
  },
  tseslint.configs.recommended,
  {
    files: ['**/*.json'],
    plugins: { json },
    language: 'json/json',
    extends: ['json/recommended']
  },
  {
    files: ['**/*.md'],
    plugins: { markdown },
    language: 'markdown/gfm',
    extends: ['markdown/recommended']
  },
  {
    files: ['**/*.css'],
    plugins: { css },
    language: 'css/css',
    extends: ['css/recommended'],
    languageOptions: {
      customSyntax: tailwindSyntax
    }
  },
  {
    files: ['priv/static/layout.css'],
    rules: {
      'css/no-invalid-at-rules': 'off'
    }
  },
  {
    rules: {
      '@typescript-eslint/no-require-imports': 'off'
    }
  },
  tailwind.configs['flat/recommended'],
  eslintConfigPrettier
]);
