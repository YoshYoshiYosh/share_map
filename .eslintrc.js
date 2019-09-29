module.exports = {
  env: {
    browser: true
  },
  extends: [
    // airbnbのルールを導入、Reactを入れていない場合は「-base」アリの方
    'airbnb-base'
  ],
  globals: {
    // 指定したグローバルオブジェクトに対する警告を除外する
    '$': true,
    'google': true,
    'ga': true,
  },
  'rules': {
    // 除外したルール
    // 開発環境ではdebuggerを許容する
    'no-debugger': process.env.NODE_ENV === 'production' ? 2 : 0,

    'no-alert': 0,
    'prefer-destructuring': 0,
  }
}