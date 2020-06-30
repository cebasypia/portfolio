// eslint-disable-next-line no-undef
module.exports = {
  env: {
    es6: true,
  },
  extends: ['eslint:recommended', 'plugin:vue/essential', 'prettier'],

  parserOptions: {
    ecmaVersion: 11,
    sourceType: 'module',
  },
  plugins: ['vue', 'prettier'],
  rules: {
    'prettier/prettier': [
      'error',
      {
        // 各種設定
      },
    ],
  },
}
