const test = require('node:test');
const assert = require('node:assert/strict');

test('basic platform smoke test', () => {
  assert.equal(typeof 'ResQNet', 'string');
});
