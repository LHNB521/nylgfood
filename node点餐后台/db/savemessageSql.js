var savemessageSql = {
    insertSavemessageSql: 'INSERT INTO savemessage(CUSID, NAME, IPHONE, BINDID) VALUES(?, ?, ?, ?)',
    queryAll: 'SELECT * FROM savemessage WHERE CUSID'
  }
  module.exports = savemessageSql