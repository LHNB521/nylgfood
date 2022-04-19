var syscusSql = {
  insert: 'INSERT INTO syscus(CUSID, NICKNAME, PASSWORD, LIMITS) VALUES(?, ?, ?, ?)',
  queryAll: 'SELECT * FROM syscus'
}
module.exports = syscusSql