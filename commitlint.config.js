// commitlint.config.cjs
const { defineConfig } = require('cz-git');

module.exports = defineConfig({
  extends: ['@commitlint/config-conventional'],

  // === Regras (fonte única dos SCOPES) ===
  rules: {
    // ajuste a lista abaixo para o seu projeto
    'scope-enum': [2, 'always', [
      'core','ui','api','auth','db','infra','build','ci','tests','docs'
    ]],
    'scope-case': [2, 'always', 'kebab-case'],
    // opcional: mantenha o padrão dos types convencionais
    // 'type-enum': [2, 'always', ['feat','fix','docs','style','refactor','perf','test','build','ci','chore','revert']],
  },

  // === Prompt do cz-git ===
  prompt: {
    // mensagens (ajuste à vontade)
    messages: {
      type: "Select the type of change that you're committing:",
      scope: "Denote the SCOPE of this change (module/subsystem). Press Enter to skip:",
      customScope: "Custom SCOPE (e.g., auth, db, ui):",
      subject: "Write a SHORT, IMPERATIVE description:\n",
      body: "Provide a LONGER description (optional). Use '|' to break line:\n",
      breaking: "List any BREAKING CHANGES (optional). Use '|' to break line:\n",
      footerPrefixSelect: "Select the ISSUES action (optional):",
      customFooterPrefix: "Input ISSUES action (e.g., Resolves):",
      footer: "List any ISSUES. E.g.: #31, ABC-9 (comma/space separated):\n",
      confirmCommit: "Are you sure you want to proceed with the commit above?",
    },

    // types mostrados no menu
    types: [
      { value: 'feat',     name: 'feat:     A new feature',                                            emoji: ':sparkles:' },
      { value: 'fix',      name: 'fix:      A bug fix',                                                emoji: ':bug:' },
      { value: 'docs',     name: 'docs:     Documentation only changes',                               emoji: ':memo:' },
      { value: 'style',    name: "style:    Changes that do not affect the meaning of the code",       emoji: ':lipstick:' },
      { value: 'refactor', name: 'refactor: A code change that neither fixes a bug nor adds a feature',emoji: ':recycle:' },
      { value: 'perf',     name: 'perf:     A code change that improves performance',                   emoji: ':zap:' },
      { value: 'test',     name: 'test:     Adding missing tests or correcting existing tests',         emoji: ':white_check_mark:' },
      { value: 'build',    name: 'build:    Changes that affect the build system or external deps',     emoji: ':package:' },
      { value: 'ci',       name: 'ci:       Changes to CI configuration and scripts',                   emoji: ':ferris_wheel:' },
      { value: 'chore',    name: "chore:    Other changes that don't modify src or test files",         emoji: ':hammer:' },
      { value: 'revert',   name: 'revert:   Reverts a previous commit',                                 emoji: ':rewind:' },
    ],

    // Deixe vazio: cz-git usará a lista de rules.scope-enum automaticamente
    scopes: [],
    allowCustomScopes: true,
    allowEmptyScopes: true,

    // Ações para issues — compatível com GitHub/GitLab
    issuePrefixes: [
      { value: 'Closes', name: 'Closes:   close issue(s) on merge' },
      { value: 'Fixes',  name: 'Fixes:    fix issue(s) on merge' },
      { value: 'Refs',   name: 'Refs:     reference issue(s) (no close)' },
    ],
    allowCustomIssuePrefix: true,
    allowEmptyIssuePrefix: true,

    useEmoji: false,
    upperCaseSubject: null,
    markBreakingChangeMode: false,
    allowBreakingChanges: ['feat', 'fix'],
    breaklineNumber: 100,
    breaklineChar: '|',
    skipQuestions: [],
    defaultScope: '',
    defaultSubject: '',
    defaultBody: '',
    defaultIssues: '',
    customScopesAlign: 'bottom',
    customScopesAlias: 'custom',
    emptyScopesAlias: 'empty',
    customIssuePrefixAlign: 'top',
    emptyIssuePrefixAlias: 'skip',
    customIssuePrefixAlias: 'custom',
    confirmColorize: true,
    scopeOverrides: undefined,
    themeColorCode: '',
    useAI: false,
    aiNumber: 1,
  },
});
