module.exports = {
  root: true,
  env: {
    es6: true,
    node: true,
  },
  extends: [
    "eslint:recommended",
    "google",
  ],
  rules: {
    _quotes: ["error", "double", "no-unused-vars", "warn"],
    get quotes() {
      return this._quotes;
    },
    set quotes(value) {
      this._quotes = value;
    },
  },
  parserOptions: {"ecmaVersion": 2020},
};
