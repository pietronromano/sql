const pg = require('pg');

class Pool {
  _pool = null;

  connect(options) {
    this._pool = new pg.Pool(options);
    //DIDN'T SEEM TO work for setting the schema
    //return this._pool.query('SET search_path = comercio;');
    //This actually initiates the connection: use it to set the schema
    return this._pool.query('SELECT 1 + 1;');
  }

  close() {
    return this._pool.end();
  }

  query(sql, params) {
    return this._pool.query(sql, params);
  }
}

module.exports = new Pool();
